#!/bin/bash
# copyright (C) 2016 Roberto Selbach <roberto@selbach.ca>
# sourced from https://github.com/rselbach/c-cedilla-fedora

COMPOSE_FILE="/usr/share/X11/locale/en_US.UTF-8/Compose"
if [ ! -s "$COMPOSE_FILE" ]; then
  echo >&2 "ERROR: unable to locate system compose."
  exit 1
fi
echo "Writing new $HOME/.XCompose..."
sed -e 's,\xc4\x86,\xc3\x87,g' \
    -e 's,\xc4\x87,\xc3\xa7,g' <"$COMPOSE_FILE">"$HOME/.XCompose"

echo Installing im-chooser...
sudo dnf install im-chooser

echo Setting up GNOME...
gsettings set org.gnome.settings-daemon.plugins.keyboard active false

cat<<EOF
Running im-chooser.
Please choose "Use X Compose table" and then Log out.
EOF

im-chooser > /dev/null 2>&1

echo Done. Please log out to apply the changes.