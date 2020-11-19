data "template_file" "success_output" {
  template = "${file("terraform-helm-chart/output.txt")}"

  vars {

    deployment_name        = "${var.deployment_name}-${var.deployment_environment}"
    deployment_environment = "dev"
    deployment_endpoint    = "${var.deployment_endpoint}
    deployment_path        = "${var.deployment_path}"
    release_version        = "${var.release_version}" 
}

output "Success" {
  value = "${data.terraform_helm_chart.success_output.rendered}"
}
