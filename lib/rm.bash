_rm() {
	if [ $# -eq 1 ]; then
		echo -n "Delete all profiles? (y/n): "
		read delete_all
		if [ "$delete_all" == "y" ]; then
			rm -rf $AWSPM_DIR/profiles/*
			exit 0
		else
			echo "Not deleting all profiles."
			exit 1
		fi
	fi

	if [ $# -eq 2 ]; then
		
		profile_vars $2
		
		# Does profile dir exist?
		if [ ! -d "$PROFILE_DIR" ]; then
			echo "${PROFILE_DIR} did not exist."
			exit 1
		fi

		echo -n "Delete entire profile: ${PROFILE_NAME} ? (y/n): "
		read delete_profile
		if [ "$delete_profile" == "y" ]; then
			rm -rf $PROFILE_DIR
			exit 0
		else
			echo "Not deleting profile (${PROFILE_NAME})."
			exit 1
		fi
	fi

	if [ $# -eq 3 ]; then
		profile_vars $2 $3

		# Does profile dir exist?
		if [ ! -d "$PROFILE_DIR" ]; then
			echo "${PROFILE_DIR} did not exist."
			exit 1
		fi

		# Does user config exist?
		if [ ! -f "$PROFILE_USER_CONF" ]; then
			echo "${PROFILE_USER_CONF} did not exist."
			exit 1
		fi

		echo -n "Delete user (${PROFILE_USER}) from profile (${PROFILE_NAME}) ? (y/n): "
		read delete_user
		if [ "$delete_user" == "y" ]; then
			rm -rf $PROFILE_USER_CONF
			exit 0
		else
			echo "Not deleting user (${PROFILE_USER}) from profile (${PROFILE_NAME})."
			exit 1
		fi
	fi

	_help
	exit 1
}