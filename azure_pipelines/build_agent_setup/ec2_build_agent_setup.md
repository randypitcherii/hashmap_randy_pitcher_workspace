# Set Up EC2 Build Agent
This document explains how to set up a new EC2 instance for usage as an Azure DevOps build agent.

## Notes
- I used an x64 EC2 instance with the Amazon Linux 2 AMI. T2.micro works fine for me. If you use a different OS or different architecture, you'll need to use different Azure DevOps installation commands.

## Setup
These steps are a simplified and easier to follow version of the official build agent instructions. [Feel free to refer to the official instructions as needed.](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux?view=azure-devops)

1. [Create a Personal Access Token (PAT) in Azure Devops in your user settings.](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux?view=azure-devops#permissions) Remember this value as you'll need it later. 
2. In your devops project, go to project settings > agent pools and select "Add Pool". Name this Pool without spaces and remember the name of the pool for later.
3. Create your AWS EC2 instance. Name and tag it well and keep track of your access key.
4. Use `scp` to copy the [`ec2_build_agent_setup.sh`](./ec2_build_agent_setup.sh) into your new instance. The command will look similar to 
    ```bash
    scp -i ~/.ssh/{your_ec2_keypair}.pem ./ec2_build_agent_setup.sh ec2-user@{your_ec2_url_or_public_ip}:~
    ```
5. `ssh` into your ec2 instance. The command will look similar to 
    ```bash
    ssh -i ~/.ssh/{your_ec2_keypair}.pem ec2-user@{your_ec2_url_or_public_ip}
    ```
6. Run the following:
    ```bash
    cd # get to your home directory where the setup is
    sh ./ec2_build_agent_setup.sh
    ```
7. The config wizard that is started by the previous script will require you to provide the following 3 pieces of information:

    - The URL of your devops project. It will look like the following: `https://dev.azure.com/{your-organization}`
    - Your PAT from step 1. 
    - The name of the agent pool from step 2.
    - A good, descriptive name for your new pipeline build agent.
8. The final portion of the script will start the devops service. You can confirm that all is well with your agent by going to your project settings > agent pools > select your pool and look for the new agent. You should see that it is online.

At this point, you may use the above steps to create more build agents in this same pool if necessary. No need to create a new PAT each time.

## Usage
In your pipeline yamls, simply use the following to run your pipeline with your new agent pool:
```yaml
# Put this at the top of your yaml
pool: '{name_of_your_new_pool}'

# add the rest of your pipeline definition below
```