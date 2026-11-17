use zed_extension_api::{self as zed, Command, LanguageServerId, Result, Worktree};

struct OrgLite;

impl zed::Extension for OrgLite {
    fn new() -> Self {
        Self
    }

    fn language_server_command(
        &mut self,
        _language_server_id: &LanguageServerId,
        worktree: &Worktree,
    ) -> Result<Command> {
        let python = worktree
            .which("python3")
            .ok_or("Org Lite folding requires python3 on Zed's PATH")?;
        // Embed the server so installation needs no copied scripts or absolute paths.
        Ok(Command {
            command: python,
            args: vec!["-u".into(), "-c".into(), include_str!("../server/org_lsp.py").into()],
            env: Default::default(),
        })
    }
}

zed::register_extension!(OrgLite);
