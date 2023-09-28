resource "shoreline_notebook" "jenkins_outdated_plugins_incident" {
  name       = "jenkins_outdated_plugins_incident"
  data       = file("${path.module}/data/jenkins_outdated_plugins_incident.json")
  depends_on = [shoreline_action.invoke_jenkins_plugin_update_checker,shoreline_action.invoke_update_jenkins_plugins]
}

resource "shoreline_file" "jenkins_plugin_update_checker" {
  name             = "jenkins_plugin_update_checker"
  input_file       = "${path.module}/data/jenkins_plugin_update_checker.sh"
  md5              = filemd5("${path.module}/data/jenkins_plugin_update_checker.sh")
  description      = "The system administrator may have overlooked plugin update notifications and failed to update them in a timely manner."
  destination_path = "/agent/scripts/jenkins_plugin_update_checker.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "update_jenkins_plugins" {
  name             = "update_jenkins_plugins"
  input_file       = "${path.module}/data/update_jenkins_plugins.sh"
  md5              = filemd5("${path.module}/data/update_jenkins_plugins.sh")
  description      = "During the maintenance window, update the plugins by either manually downloading them from the Jenkins update center or by using a plugin manager tool like Jenkins CLI or Jenkins Configuration as Code."
  destination_path = "/agent/scripts/update_jenkins_plugins.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_jenkins_plugin_update_checker" {
  name        = "invoke_jenkins_plugin_update_checker"
  description = "The system administrator may have overlooked plugin update notifications and failed to update them in a timely manner."
  command     = "`chmod +x /agent/scripts/jenkins_plugin_update_checker.sh && /agent/scripts/jenkins_plugin_update_checker.sh`"
  params      = ["PATH_TO_JENKINS_UPDATE_CENTER","PATH_TO_JENKINS_PLUGINS"]
  file_deps   = ["jenkins_plugin_update_checker"]
  enabled     = true
  depends_on  = [shoreline_file.jenkins_plugin_update_checker]
}

resource "shoreline_action" "invoke_update_jenkins_plugins" {
  name        = "invoke_update_jenkins_plugins"
  description = "During the maintenance window, update the plugins by either manually downloading them from the Jenkins update center or by using a plugin manager tool like Jenkins CLI or Jenkins Configuration as Code."
  command     = "`chmod +x /agent/scripts/update_jenkins_plugins.sh && /agent/scripts/update_jenkins_plugins.sh`"
  params      = ["YOUR_JENKINS_PASSWORD","YOUR_JENKINS_URL","LIST_OF_PLUGINS_TO_UPDATE","YOUR_JENKINS_USERNAME"]
  file_deps   = ["update_jenkins_plugins"]
  enabled     = true
  depends_on  = [shoreline_file.update_jenkins_plugins]
}

