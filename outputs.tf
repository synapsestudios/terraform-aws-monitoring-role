output "synapsestudios_grafana_key" {
  description = "AWS Access Key ID to be used with Grafana"
  value       = aws_iam_access_key.synapsestudios_grafana_key.id
}

output "synapsestudios_grafana_secret" {
  description = "AWS Access Key Secret to be used with Grafana"
  value       = aws_iam_access_key.synapsestudios_grafana_key.secret
}

output "role" {
  description = "The SynapseStudios Monitoring role resource."
  value       = aws_iam_role.synapsestudios_monitoring
}

output "instance_profile" {
  description = "The SynapseStudios Monitoring instance profileresource."
  value       = aws_iam_instance_profile.synapsestudios_monitoring
}
