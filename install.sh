#! /bin/bash

# check_exitcode:
# Checks the given exitcode and outputs a message corresponding to it
# Exitcodes other than 0 will exit the script with the given exitcode
# args:
## 1: exitcode
## 2: optional - will quiet the "done" message if "skippls" is given (failing
##    commands will still output a message)
function check_exitcode {
  case $1 in
    "0")
      if [[ $2 != "skippls" ]]; then
        echo "done"
      fi
      ;;
    *)
      echo 'failed - see log for details'
      echo -e "--------------------\n" &>> ./install.log
      exit $1
      ;;
  esac
}

# execute_stuff:
# Handles logging and CLI output
# args:
## 1: Echo message for CLI
## 2: Command to execute (will also be logged)
## 3: optional - will quiet the "done" message if "skippls" is given (failing
##    commands will still output a message)
function execute_stuff {
  if [[ $3 != "skippls" ]]; then
    echo_args="-n"
  fi
  echo $echo_args "[*] $1... "
  echo -e "\n$2" &>> ./install.log
  eval $2 &>> ./install.log
  check_exitcode $? $3
}

date &>> ./install.log

execute_stuff "Collecting password for sudo if needed" \
                "sudo bash -c exit 0" \
                skippls
execute_stuff "Installing python3-venv" \
                "DEBIAN_FRONTEND=noninteractive sudo apt-get install python3-venv -y"
execute_stuff "Creating virtualenv for Ansible" \
                "python3 -m venv venv"
execute_stuff "Activating virtualenv" \
                "source venv/bin/activate"
execute_stuff "Upgrading pip" \
                "python3 -m pip install --upgrade pip"
execute_stuff "Installing wheel with pip" \
                "python3 -m pip install wheel"
execute_stuff "Installing Ansible and requirements with pip (might take a while)" \
                "python3 -m pip install -r requirements.txt"
execute_stuff "Installing collections with ansible-galaxy (Warning about the collection path can be ignored)" \
                "ansible-galaxy collection install -p .ansible/collections -r requirements.yml"
execute_stuff "Installing roles with ansible-galaxy... " \
                "ansible-galaxy role install -r requirements.yml"

echo -e "--------------------\n" &>> ./install.log

echo "[*] Anything done! Have a nice day."
