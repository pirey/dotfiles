#!/bin/sh

echo "installing adminer..."

adminer_dir=$HOME/.local/opt/adminer/4.7.6
adminer_download_url="https://github.com/vrana/adminer/releases/download/v4.7.6/adminer-4.7.6.php"
adminer_default_plugin_url="https://raw.githubusercontent.com/vrana/adminer/master/plugins/plugin.php"
adminer_theme_url="https://github.com/pematon/adminer-theme"

if [ ! -d $adminer_dir ]; then
    mkdir -p $adminer_dir

    if [ ! -d /tmp/adminer-theme ]; then
        git clone $adminer_theme_url /tmp/adminer-theme
    fi
    cp -r /tmp/adminer-theme/lib/* $adminer_dir

    # adminer engine
    curl -o $adminer_dir/adminer.php -L $adminer_download_url

    # adminer default plugin
    curl -o $adminer_dir/plugins/plugin.php -L $adminer_default_plugin_url

    # adminer index
    cat << 'ADMINER_INDEX' > $adminer_dir/index.php
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

    cat << 'ADMINER_START' > $adminer_dir/adminer
    #!/bin/sh

    php -S localhost:9999 -t $(dirname $0)
ADMINER_START

    chmod u+x $adminer_dir/adminer
fi

