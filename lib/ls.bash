_ls() {
	if [ $# -eq 1 ]; then
		if [ $(find $PROFILES_DIR -maxdepth 1 -type d | wc -l) -ge 2 ]; then
			echo "Here are the known profiles:"
			find $PROFILES_DIR -maxdepth 1 -type d | tail -n +2 | xargs -r -n 1 basename
		else
			echo "No profiles found."
		fi
		exit 0

	fi

	if [ $# -eq 2 ]; then
		
		profile_vars $2
		
		# Does profile dir exist?
		if [ ! -d "$PROFILE_DIR" ]; then
			echo "${PROFILE_DIR} did not exist."
			exit 1
		fi

		if [ $(find $PROFILE_DIR -maxdepth 1 -type f | wc -l) -ge 1 ]; then
			echo "Here are the known users for the profile (${PROFILE_NAME}):"
			find $PROFILE_DIR -maxdepth 1 -type f | xargs -r -n 1 basename | sed s/\.conf//g
		else
			echo "No users found."
		fi

		exit 0
	fi

	_help
	exit 1
}