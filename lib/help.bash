_help() {
cat << EOF 
-------------------------------------------------
Usage:
  awspm [command] [arguments]

Available commands:
  bash: prints out a maybe useful bash helper.
  clear: provides the commands to clear any environment varialbes awspm might set
  create: used to create or edit a profile user
  help: prints this help documention
  ls: lists profiles and profile users
  rm: used to remove all profiles, a profile, or a profile user
  view: provides the commands to load a profile user's credentials into ENV

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

remove user 'admin' from profile 'default':
  awspm rm default admin

remove profile 'default':
  awspm rm default

remove everything:
  awspm rm


EOF
}