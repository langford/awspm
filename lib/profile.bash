# Expects to be passed the profile name.
# Expects AWSPM_DIR to already be set.
profile_vars() {
	if [ $# -ge 1 ]; then
		profile_basic $1
	else
		echo "Someone has messed up a call to profile_vars."
		exit 1
	fi

	if [ $# -eq 2 ]; then
		profile_user $2
	fi
}

profile_basic() {
	PROFILE_NAME=$1
	PROFILE_DIR=$PROFILES_DIR/${PROFILE_NAME}
	PROFILE_KEY_DIR=$PROFILE_DIR/keys
	PROFILE_PRIVATE_KEY=$PROFILE_KEY_DIR/pkey
	PROFILE_PUBLIC_KEY=$PROFILE_KEY_DIR/pkey.pub
}

profile_user() {
	PROFILE_USER=$1
	PROFILE_USER_CONF=$PROFILE_DIR/$PROFILE_USER.conf
}