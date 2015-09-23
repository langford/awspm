AWS Profile Manager
======================

Think of this project like RVM but for managing Amazon profiles.

The biggest addition to this is that not only will it load stored
Amazon credentials into your shell as environment varables. But
the configurations are also encrypted at rest.

Installation
============

```
git clone https://github.com/flyinprogrammer/awspm.git $HOME/.awspm
export PATH="$HOME/.awspm/bin:$PATH"
```

You'll probably want to put `$HOME/.awspm/bin` permanently on your path.

Dependencies
============

Make sure you have openssl installed and accessible in your PATH.

Usage
=====

```
$awspm help
-------------------------------------------------
Usage:
  awspm [command] [arguments]

Available commands:
  bash:   prints out a maybe useful bash helper.
  clear:  provides the commands to clear any environment varialbes awspm might set
  create: used to create or edit a profile user
  help:   prints this help documention
  ls:     lists profiles and profile users
  rm:     used to remove all profiles, a profile, or a profile user
  view:   provides the commands to load a profile user's credentials into ENV

Examples:

show bash helpers:
  awspm bash

list avaialble profiles:
  awspm ls

list available users for profile 'default':
  awspm ls default

create a user 'admin' for profile 'default':
  awspm create default admin

edit a user 'admin' for profile 'default':
  awspm create default admin

view the conf for user 'admin' belonging to profile 'default':
  awspm view default admin

remove user 'admin' from profile 'default':
  awspm rm default admin

remove profile 'default':
  awspm rm default

remove everything:
  awspm rm
```

Examples
========

Create a profile (personal_account) and user (admin):
```
$ awspm create personal_account admin
Amazon Profile Manager
--------------------------------------
Working on profile: personal_account
/Users/flyinprogrammer/.awspm/profiles/personal_account did not exist, so we made it.
/Users/flyinprogrammer/.awspm/profiles/personal_account/keys did not exist, so we made it.
Private key does not exist - let's create it.
Generating RSA private key, 4096 bit long modulus
...............................................................................................................................................................................++
..................................................................................................................................++
e is 65537 (0x10001)
Enter pass phrase for /Users/flyinprogrammer/.awspm/profiles/personal_account/keys/pkey: <password>
Verifying - Enter pass phrase for /Users/flyinprogrammer/.awspm/profiles/personal_account/keys/pkey: <password>
Public key does not exist - let's create it.
Enter pass phrase for /Users/flyinprogrammer/.awspm/profiles/personal_account/keys/pkey: <password>
writing RSA key
Configuration for admin does not exist - let's create it.
AWS_DEFAULT_REGION: us-east-1
AWS_ACCESS_KEY_ID: foo
AWS_SECRET_ACCESS_KEY: bar
```

View the credentials we just created for profile (personal_account) user (admin): 
```
$ awspm view personal_account admin
Enter pass phrase for /Users/flyinprogrammer/.awspm/profiles/personal_account/keys/pkey: <password>
export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCESS_KEY_ID=foo
export AWS_SECRET_ACCESS_KEY=bar
# Run this command to configure your shell
# eval "$(/Users/flyinprogrammer/.awspm/bin/awspm view personal_account admin)"
```

Bash Helpers
============

```
$ awspm bash
You might find it helpful to add the following
bash helper funcion to your .profile/.bashrc:

awspm_load() {
  eval "$(/Users/flyinprogrammer/.awspm/bin/awspm view $1 $2)"
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
  eval "$(/Users/flyinprogrammer/.awspm/bin/awspm clear)"
}

Usage:
awspm_clear

Will allow you to quickly clear your shell of awspm environment variables.
```