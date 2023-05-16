output "settings" {
  description = "All raw settings fetched from the cluster"
  value       = "${module.elastic-stack.settings}"
}
