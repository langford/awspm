create() {
	if [ $# -eq 3 ]; then
		
		profile_vars $2 $3
		echo "Amazon Profile Manager"
		echo "--------------------------------------"
		echo "Working on profile: ${PROFILE_NAME}"
		
		# Does profile dir exist?
		if [ ! -d "$PROFILE_DIR" ]; then
			mkdir -p $PROFILE_DIR
			echo "${PROFILE_DIR} did not exist, so we made it."
		else
			echo "${PROFILE_DIR} exists."
		fi

		# Does profile key dir exist?
		if [ ! -d "$PROFILE_KEY_DIR" ]; then
			mkdir -p $PROFILE_KEY_DIR
			echo "${PROFILE_KEY_DIR} did not exist, so we made it."
		else
			echo "${PROFILE_KEY_DIR} exists."
		fi

		# Does private key exist?
		if [ ! -f "$PROFILE_PRIVATE_KEY" ]; then
			echo "Private key does not exist - let's create it."
			/usr/bin/env openssl genrsa -out $PROFILE_PRIVATE_KEY -aes256 4096
		else
			echo "${PROFILE_PRIVATE_KEY} exists."
		fi

		# Does public key exist?
		if [ ! -f "$PROFILE_PUBLIC_KEY" ]; then
			echo "Public key does not exist - let's create it."
			/usr/bin/env openssl rsa -pubout -in $PROFILE_PRIVATE_KEY -out $PROFILE_PUBLIC_KEY
		else
			echo "${PROFILE_PUBLIC_KEY} exists."
		fi

		# Does user config exist?
		if [ ! -f "$PROFILE_USER_CONF" ]; then
			build_config
		else
			echo "${PROFILE_USER_CONF} exists."
			echo -n "Overwrite config? (y/n): "
			read overwrite
			if [ "$overwrite" == "y" ]; then
				build_config
			else
				echo "Not overwriting config."
			fi
		fi
		exit 0
	fi

	_help
	exit 1
}

build_config() {
	echo "Configuration for ${PROFILE_USER} does not exist - let's create it."
	echo -n "AWS_REGION: "
	read aws_region

	echo -n "AWS_ACCESS_KEY_ID: "
	read aws_access_key_id

	echo -n "AWS_SECRET_ACCESS_KEY: "
	read aws_secret_access_key

	conf="export AWS_REGION=${aws_region}\nexport AWS_ACCESS_KEY_ID=${aws_access_key_id}\nexport AWS_SECRET_ACCESS_KEY=${aws_secret_access_key}"
	echo -e $conf | /usr/bin/env openssl rsautl -encrypt -inkey $PROFILE_PUBLIC_KEY -pubin -out $PROFILE_USER_CONF
}