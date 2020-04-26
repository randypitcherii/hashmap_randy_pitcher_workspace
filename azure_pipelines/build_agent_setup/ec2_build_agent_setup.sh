#!/bin/bash

# install python
sudo yum update -y
sudo yum install python3 git tar -y

# create venv and activate
python3 -m venv dbt_run_venv
source dbt_run_venv/bin/activate

# install python libs
pip install --upgrade pip && pip install dbt-snowflake

# install devops build agent
mkdir azure_devops_build_agent && cd azure_devops_build_agent
curl https://vstsagentpackage.azureedge.net/agent/2.166.4/vsts-agent-linux-x64-2.166.4.tar.gz -O

# configure devops build agent
tar zxvf vsts-agent-linux-x64-2.166.4.tar.gz
rm vsts-agent-linux-x64-2.166.4.tar.gz
./config.sh

# configure the devops build agent service and run it
sudo ./svc.sh install
sudo ./svc.sh run