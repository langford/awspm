Amazon Profile Manager
======================

Think of this project like RVM but for managing Amazon profiles.

The biggest addition to this is that not only will it load stored
Amazon credentials into your shell as environment varables. But it
the configurations are also encrypted at rest.

Installation
============

Clone this repo into: `$HOME/.apm`

Add `$HOME/.apm/bin` to your $PATH


Configuration
=============

The first step for this to work is to create an openssl key which
APM will use to encrypt your credentials. By default we use your
`$HOME/id_rsa` key. This can be overriden with the following
environment varaible: $APM_SSL_KEY_PATH

APM recommends you use a key which requires a password. 

Usage
=====

  
