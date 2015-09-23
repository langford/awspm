_bash() {
cat << EOF 
You might find it helpful to add the following 
bash helper funcion to your .profile/.bashrc:

awspm_load() {
  eval "\$(${AWSPM_DIR}/bin/awspm view \$1 \$2)"
}

Usage:
awspm_load (profile) (user)

This saves you the hassle of copy+pasting from 'view' and from having
to wrap the command to evaluate it in your current shell.

Personally, I like creating even shorter helpers that load specific 
users with 1 command.

For example:

awspm_load_default() {
  awspm_load default admin
}

Now I simply need to run 'awspm_load_default' to get my default
credentials into my shell.

Additionally this helper:

awspm_clear() {
  eval "\$(${AWSPM_DIR}/bin/awspm clear)"
}

Usage:
awspm_clear

Will allow you to quickly clear your shell of awspm environment variables.
EOF
}