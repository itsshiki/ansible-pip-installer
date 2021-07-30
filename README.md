# ansible-pip-installer
Anything needed to install Ansible into a virtualenv in three files.

## HowTo
1. Execute the ```install.sh```  with ```bash``` or make it executable and run it afterwards
2. ????????
3. Profit!

After the installation you have to activate the virtualenv with the command ```source venv/bin/activate``` to use ansible magic in your CLI.

When you're done you can just close your terminal or ```deactivate``` the virtualenv.

## What are all these files for?!
### Minimum needed files:
* ```install.sh```: Installs ```python3-virtualenv``` via ```apt```, creates a virtualenv, installs ```ansible```, ```ansible-lint``` and ```yamllint``` into it and installs all collections and roles written into the ```requirements.yml```
* ```requirements.txt```: Contents all Python modules needed for Ansible and linting with the ```lint.sh``` script
  * You can expand it with other Python modules if you want to! Or remove those ugly linters, yuck.
* ```requirements.yml```: Is needed by ansible-galaxy; It contents the collections and roles you need for your playbook(s) (you should ask Google again here if you don't know about ansible-galaxy)
  * This is an empty template. Fill it with life! But you don't have to.

### Nice to have for linting:
* ```.yamllint.yml```: Configuration file for yamllint (try it without the config after installation, then you know why it's needed)
* ```lint.sh```: Tests all your yaml files inside this directory for bad syntax or other errors with ```yamllint``` and ```ansible-lint```

### Nice to have for ansible binaries:
* ```ansible.cfg```: Configuration file for all ansible executables (google it for more information)
