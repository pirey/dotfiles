#!/bin/sh

echo "installing adminer..."

adminerdir=~/.local/opt/adminer/4.7.4

if [ ! -d $adminerdir ]; then
    mkdir -p $adminerdir

    git clone https://github.com/pematon/adminer-theme /tmp/adminer-theme
    mv /tmp/adminer-theme/lib/* $adminerdir

    # adminer engine
    curl -o $adminerdir/adminer.php -L https://github.com/vrana/adminer/releases/download/v4.7.4/adminer-4.7.4.php

    # adminer default plugin
    curl -o $adminerdir/plugins/plugin.php -L https://raw.githubusercontent.com/vrana/adminer/master/plugins/plugin.php

    # adminer index
    cat << 'ADMINER_INDEX' > $adminerdir/index.php
    <?php
    function adminer_object()
	{
		// Required to run any plugin.
		include_once "./plugins/plugin.php";

		// Plugins auto-loader.
		foreach (glob("plugins/*.php") as $filename) {
			include_once "./$filename";
		}

		// Specify enabled plugins here.
		$plugins = [
			// AdminerTheme has to be the last one!
			new AdminerTheme('default-blue'),

			// Color variant can by specified in constructor parameter.
			// new AdminerTheme("default-orange"),
			// new AdminerTheme("default-blue"),
			// new AdminerTheme("default-green", ["192.168.0.1" => "default-orange"]),
		];

		return new AdminerPlugin($plugins);
	}

	// Include original Adminer or Adminer Editor.
	include "./adminer.php";
ADMINER_INDEX

    cat << 'ADMINER_START' > $adminerdir/adminer
    #!/bin/sh

    php -S localhost:9999 -t $(dirname $0)
ADMINER_START

    sudo -S chmod u+x $adminerdir/adminer
fi

