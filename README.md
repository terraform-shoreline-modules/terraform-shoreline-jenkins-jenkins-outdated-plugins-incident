
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Jenkins Outdated Plugins Incident
---

The Jenkins outdated plugins incident occurs when one or more plugins installed on a Jenkins server are not up to date. This can lead to potential security vulnerabilities, performance issues, and compatibility problems with other plugins or applications that rely on them. The incident requires immediate attention and updates to the affected plugins to ensure the smooth functioning of Jenkins and prevent any potential security threats.

### Parameters
```shell
export JENKINS_HOME="PLACEHOLDER"

export YOUR_JENKINS_PASSWORD="PLACEHOLDER"

export YOUR_JENKINS_USERNAME="PLACEHOLDER"

export LIST_OF_PLUGINS_TO_UPDATE="PLACEHOLDER"

export YOUR_JENKINS_URL="PLACEHOLDER"

export PATH_TO_JENKINS_UPDATE_CENTER="PLACEHOLDER"

export PATH_TO_JENKINS_PLUGINS="PLACEHOLDER"
```

## Debug

### Check the version of Jenkins running.
```shell
${JENKINS_HOME}/jenkins.sh version
```

### List all installed plugins along with their versions.
```shell
${JENKINS_HOME}/jenkins.sh list-plugins
```

### Check if any plugins have updates available.
```shell
${JENKINS_HOME}/jenkins.sh list-plugins | grep -v ')$' | awk '{ print $1 }' | xargs ${JENKINS_HOME}/jenkins.sh install-plugin
```

### Verify the status of updated plugins.
```shell
${JENKINS_HOME}/jenkins.sh list-plugins | grep -v ')$'
```

### Restart Jenkins for changes to take effect.
```shell
${JENKINS_HOME}/jenkins.sh restart
```

### The system administrator may have overlooked plugin update notifications and failed to update them in a timely manner.
```shell


#!/bin/bash



# Set the path to the Jenkins plugins directory

PLUGINS_DIR=${PATH_TO_JENKINS_PLUGINS}



# Get a list of all installed plugins

INSTALLED_PLUGINS=$(ls $PLUGINS_DIR)



# Set the path to the Jenkins update center

UPDATE_CENTER=${PATH_TO_JENKINS_UPDATE_CENTER}



# Get a list of all available plugin updates from the update center

AVAILABLE_UPDATES=$(curl $UPDATE_CENTER/update-center.json | grep -o '\"name\": \"[^\"]*\"' | awk -F ':' '{print $2}' | sed 's/\"//g')



# Check if any installed plugins have available updates

for plugin in $INSTALLED_PLUGINS; do

  if [[ $AVAILABLE_UPDATES =~ $plugin ]]; then

    echo "Plugin '$plugin' has an available update."

  fi

done


```

## Repair

### During the maintenance window, update the plugins by either manually downloading them from the Jenkins update center or by using a plugin manager tool like Jenkins CLI or Jenkins Configuration as Code.
```shell


#!/bin/bash



# Define variables

JENKINS_URL="${YOUR_JENKINS_URL}"

JENKINS_USERNAME="${YOUR_JENKINS_USERNAME}"

JENKINS_PASSWORD="${YOUR_JENKINS_PASSWORD}"

PLUGINS="${LIST_OF_PLUGINS_TO_UPDATE}"



# Download Jenkins CLI

wget "${JENKINS_URL}/jnlpJars/jenkins-cli.jar"



# Install plugins using Jenkins CLI

java -jar jenkins-cli.jar -s "${JENKINS_URL}" -auth "${JENKINS_USERNAME}:${JENKINS_PASSWORD}" install-plugin ${PLUGINS}



# Restart Jenkins to apply the changes

java -jar jenkins-cli.jar -s "${JENKINS_URL}" -auth "${JENKINS_USERNAME}:${JENKINS_PASSWORD}" restart


```