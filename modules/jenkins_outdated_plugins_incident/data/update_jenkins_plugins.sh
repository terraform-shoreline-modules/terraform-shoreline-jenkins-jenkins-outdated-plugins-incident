

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