#!/bin/bash
LOG=/opt/user-data-$$.log
ansible-pull -i localhost -U https://github.com/udayayeswar/Ansible-dev main.yml -e 'ROLE=frontend' -e 'HOST=lacalhost' -e 'ROOT_USER=true'
