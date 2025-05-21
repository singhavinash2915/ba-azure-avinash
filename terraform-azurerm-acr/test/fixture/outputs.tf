output "acr_fqdn" {
  value = module.acr.acr_fqdn
}
output "acr_id" {
  value = module.acr.acr_id
}
output "acr_name" {
  value = module.acr.acr_name
}
output "admin_password" {
  value     = module.acr.admin_password
  sensitive = true
}
output "admin_username" {
  value = module.acr.admin_username
}
output "login_server" {
  value = module.acr.login_server
}
output "acr_id_premium" {
  value = module.acr_premium.acr_id
}