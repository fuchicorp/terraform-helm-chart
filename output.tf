output "success_output" {
  value = <<EOF
 ${var.deployment_name} helm deployment 

 ######################### Helm Deploy #########################

  Congrats! Your helm chart has deployed successfully. Please see
  below for your chart details:

  Chart Name: "${var.deployment_name}"
  Deployment Enviroment/Namespace: "${var.deployment_environment}"
  Chart version: "${var.release_version}"

  Author: Fuchicorp

 ###############################################################

 Please use the commands below to view your deployment resources.

  - View your helm deployment: 
      helm ls | grep ${var.deployment_name}-${var.deployment_environment}
 
  - View your deployment pod(s): 
      kubectl get pod -n ${var.deployment_environment} | grep ${var.deployment_name}-${var.deployment_environment}

  - View your deployment service(s):
      kubectl get service -n ${var.deployment_environment} ${var.deployment_name}-${var.deployment_environment} 


 ================================================================
  
  Please navigate to this address to view your application:
     
     URL: https://${var.deployment_endpoint}/

 ===============================================================

  EOF
}

