"""Dependency-free stdio LSP server providing Org folding ranges only."""

import json
import re
import sys

HEADING = re.compile(r"^(\*+)[ \t]+")
BEGIN = re.compile(r"^[ \t]*#\+begin_(\S+)(?:[ \t]|$)", re.I)
END = re.compile(r"^[ \t]*#\+end_(\S+)[ \t]*$", re.I)
DYNAMIC_BEGIN = re.compile(r"^[ \t]*#\+begin:[ \t]+", re.I)
DYNAMIC_END = re.compile(r"^[ \t]*#\+end:[ \t]*$", re.I)
DRAWER = re.compile(r"^[ \t]*:([\w-]+):[ \t]*$")


def folding_ranges(text):
    lines = text.splitlines()
    ranges = []
    headings = []
    block = None
    drawer = None

    def add(start, end):
        if end > start:
            ranges.append({"startLine": start, "endLine": end, "kind": "region"})

    for row, line in enumerate(lines):
        if block is not None:
            start, name = block
            match = END.match(line)
            if (name is None and DYNAMIC_END.match(line)) or (
                match and match[1].lower() == name
            ):
                add(start, row)
                block = None
            continue
        match = BEGIN.match(line)
        if match or DYNAMIC_BEGIN.match(line):
            block = (row, match[1].lower() if match else None)
            continue
        match = HEADING.match(line)
        if match:
            # A heading terminates malformed/unclosed drawers as well.
            drawer = None
            level = len(match[1])
            while headings and headings[-1][0] >= level:
                _, start = headings.pop()
                add(start, row - 1)
            headings.append((level, row))
            continue
        match = DRAWER.match(line)
        if match:
            if match[1].upper() == "END":
                if drawer is not None:
                    add(drawer, row)
                    drawer = None
            elif drawer is None:
                drawer = row
    for _, start in headings:
        add(start, len(lines) - 1)
    return sorted(ranges, key=lambda item: (item["startLine"], -item["endLine"]))


def read_message():
    headers = {}
    while True:
        line = sys.stdin.buffer.readline()
        if not line:
            return None
        if line in (b"\r\n", b"\n"):
            break
        key, value = line.decode("ascii").split(":", 1)
        headers[key.lower()] = value.strip()
    length = int(headers["content-length"])
    body = bytearray()
    while len(body) < length:
        chunk = sys.stdin.buffer.read(length - len(body))
        if not chunk:
            return None
        body.extend(chunk)
    return json.loads(body)


def reply(request_id, result=None, error=None):
    message = {"jsonrpc": "2.0", "id": request_id}
    if error is None:
        message["result"] = result
    else:
        message["error"] = error
    body = json.dumps(message, ensure_ascii=False).encode("utf-8")
    sys.stdout.buffer.write(f"Content-Length: {len(body)}\r\n\r\n".encode("ascii"))
    sys.stdout.buffer.write(body)
    sys.stdout.buffer.flush()


def main():
    documents = {}
    shutdown = False
    while True:
        message = read_message()
        if message is None:
            return
        method = message.get("method")
        params = message.get("params") or {}
        request_id = message.get("id")
        if method == "exit":
            sys.exit(0 if shutdown else 1)
        if method == "initialize":
            reply(request_id, {
                "capabilities": {
                    "textDocumentSync": {"openClose": True, "change": 1},
                    "foldingRangeProvider": True,
                },
                "serverInfo": {"name": "org-lite", "version": "0.1.0"},
            })
        elif method == "shutdown":
            shutdown = True
            reply(request_id)
        elif shutdown:
            if "id" in message:
                reply(request_id, error={"code": -32600, "message": "Server shut down"})
        elif method == "textDocument/didOpen":
            document = params["textDocument"]
            documents[document["uri"]] = document["text"]
        elif method == "textDocument/didChange":
            # Advertise full-document synchronization: no UTF-16 edit arithmetic.
            for change in params["contentChanges"]:
                documents[params["textDocument"]["uri"]] = change["text"]
        elif method == "textDocument/didClose":
            documents.pop(params["textDocument"]["uri"], None)
        elif method == "textDocument/foldingRange":
            reply(request_id, folding_ranges(documents.get(params["textDocument"]["uri"], "")))
        elif "id" in message:
            reply(request_id, error={"code": -32601, "message": "Method not found"})


if __name__ == "__main__":
    main()
