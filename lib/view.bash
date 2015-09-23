view() {
	if [ $# -eq 3 ]; then
		
		profile_vars $2 $3
		
		# Does profile dir exist?
		if [ ! -d "$PROFILE_DIR" ]; then
			echo "${PROFILE_DIR} did not exist."
			exit 1
		fi

		# Does profile key dir exist?
		if [ ! -d "$PROFILE_KEY_DIR" ]; then
			echo "${PROFILE_KEY_DIR} did not exist."
			exit 1
		fi

		# Does private key exist?
		if [ ! -f "$PROFILE_PRIVATE_KEY" ]; then
			echo "Private key does not exist."
			exit 1
		fi

		# Does public key exist?
		if [ ! -f "$PROFILE_PUBLIC_KEY" ]; then
			echo "Public key does not exist."
			exit 1
		fi

		# Does user config exist?
		if [ ! -f "$PROFILE_USER_CONF" ]; then
			echo "Configuration for ${PROFILE_USER} does not exist."
			exit 1
		else
			/usr/bin/env openssl rsautl -decrypt -inkey $PROFILE_PRIVATE_KEY -in $PROFILE_USER_CONF
			echo "# Run this command to configure your shell"
			echo "# eval \"\$(${AWSPM_DIR}/bin/awspm view ${PROFILE_NAME} ${PROFILE_USER})\""
		fi

		exit 0
	fi

	_help
	exit 1
}