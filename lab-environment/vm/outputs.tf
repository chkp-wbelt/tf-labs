output "web1_ip_address" {
  value = module.web1.ip_address
  description = "IP address for web1"
}
output "web2_ip_address" {
  value = module.web2.ip_address
  description = "IP address for web2"
}
output "db1_ip_address" {
  value = module.db1.ip_address
  description = "IP address for db1"
}
