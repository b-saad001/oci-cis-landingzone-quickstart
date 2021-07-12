# Copyright (c) 2021 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

module "lz_security_topic" {
  source                         = "../modules/monitoring/topics"
  depends_on                     = [ module.slow_down_topics ]
  compartment_id                 = module.lz_compartments.compartments[local.security_compartment_name].id
  notification_topic_name        = "${var.service_label}-SecurityTopic"
  notification_topic_description = "Topic for security related notifications."
  subscriptions = {
    s1 = { protocol = "EMAIL", endpoint = var.security_admin_email_endpoint },

    ### Examples of other subscription methods:
    /* 
    s2 = {protocol = "CUSTOM_HTTPS", endpoint = "https://www.oracle.com"},
    s3 = {protocol = "CUSTOM_HTTPS", endpoint = "https://www.google.com"}
    s4 = {protocol = "PAGER_DUTY", endpoint = "https://your.pagerduty.endpoint.url"}
    s5 = {protocol = "SLACK", endpoint = "https://your.slack.endpoint.url"}
    s6 = {protocol = "ORACLE_FUNCTIONS", endpoint = "<function_ocid>"} 
    */
  }
}

module "lz_network_topic" {
  source                         = "../modules/monitoring/topics"
  depends_on                     = [ module.slow_down_topics ]
  compartment_id                 = module.lz_compartments.compartments[local.security_compartment_name].id
  notification_topic_name        = "${var.service_label}-NetworkTopic"
  notification_topic_description = "Topic for network related notifications."

  subscriptions = {
    s1 = { protocol = "EMAIL", endpoint = var.network_admin_email_endpoint },

    ### Examples of other subscription methods:
    /* 
    s2 = {protocol = "CUSTOM_HTTPS", endpoint = "https://www.oracle.com"},
    s3 = {protocol = "CUSTOM_HTTPS", endpoint = "https://www.google.com"}
    s4 = {protocol = "PAGER_DUTY", endpoint = "https://your.pagerduty.endpoint.url"}
    s5 = {protocol = "SLACK", endpoint = "https://your.slack.endpoint.url"}
    s6 = {protocol = "ORACLE_FUNCTIONS", endpoint = "<function_ocid>"} 
    */
  }
}

resource "null_resource" "slow_down_topics" {
   depends_on = [ module.lz_compartments ]
   provisioner "local-exec" {
     command = "sleep 30" # Wait 30 seconds for compartments to be available.
   }
}