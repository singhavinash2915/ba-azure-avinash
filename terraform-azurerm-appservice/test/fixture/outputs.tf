### Outputs ###

output "app_service_linux" {
  description = "App Service Linux (Linux WebApp) output object if Linux is choosen. Please refer to `./modules/linux-web-app/README.md`"
  value       = module.app_service_linux.app_service_linux
  sensitive   = true
}
output "app_service_container" {
  description = "App Service Container (Linux WebApp) output object if Container is choosen. Please refer to `./modules/container-web-app/README.md`"
  value       = module.app_service_container.app_service_container
  sensitive   = true
}
output "app_service_windows" {
  description = "App Service Windows (Windows WebApp) output object if Windows is choosen. Please refer to `./modules/windows-web-app/README.md`"
  value       = module.app_service_win.app_service_windows
  sensitive   = true
}

output "app_service_linux_root" {
  description = "App Service Linux (Linux WebApp) output object if Linux is choosen. Please refer to `./modules/linux-web-app/README.md`"
  value       = module.app_service_linux.app_service
  sensitive   = true
}
output "app_service_container_root" {
  description = "App Service Container (Linux WebApp) output object if Container is choosen. Please refer to `./modules/container-web-app/README.md`"
  value       = module.app_service_container.app_service
  sensitive   = true
}
output "app_service_windows_root" {
  description = "App Service Windows (Windows WebApp) output object if Windows is choosen. Please refer to `./modules/windows-web-app/README.md`"
  value       = module.app_service_win.app_service
  sensitive   = true
}
output "app_service_id_linux_root" {
  description = "ID of App Service Linux (Linux WebApp)"
  value       = nonsensitive(module.app_service_linux.id)
}
output "app_service_id_container_root" {
  description = "Id of App Service Container (Linux WebApp)"
  value       = nonsensitive(module.app_service_container.id)
}
output "app_service_id_windows_root" {
  description = "ID of App Service Windows (Windows WebApp)"
  value       = nonsensitive(module.app_service_win.id)
}
output "app_service_plan_id_linux_root" {
  description = "ID of App Service Linux Plan (Linux WebApp)"
  value       = module.app_service_linux.service_plan_id
}
output "app_service_plan_id_container_root" {
  description = "Id of App Service Container Plan (Linux WebApp)"
  value       = module.app_service_container.service_plan_id
}
output "app_service_plan_id_windows_root" {
  description = "ID of App Service Windows Plan (Windows WebApp)"
  value       = module.app_service_win.service_plan_id
}

output "app_service_custom_domain_verification_id_windows_root" {
  description = "domain ownership verification of App Service Windows  (Windows WebApp)"
  value       = nonsensitive(module.app_service_win.app_service_custom_domain_verification_id)

}
output "app_service_custom_domain_verification_id_linux_root" {
  description = "domain ownership verification of App Service Linux  (Linux WebApp)"
  value       = nonsensitive(module.app_service_linux.app_service_custom_domain_verification_id)

}
output "app_service_custom_domain_verification_id_container_root" {
  description = "domain ownership verification of App Service Linux Container (Linux WebApp)"
  value       = nonsensitive(module.app_service_container.app_service_custom_domain_verification_id)

}

output "app_service_linux_easyauth_root" {
  description = "App Service Linux (Linux WebApp) with easyauthv1 output object if Linux is choosen. Please refer to `./modules/linux-web-app/README.md`"
  value       = module.app_service_linux_easyauth.app_service
  sensitive   = true
}
output "app_service_container_easyauth_root" {
  description = "App Service Container (Linux WebApp) with easyauthv1 output object if Container is choosen. Please refer to `./modules/container-web-app/README.md`"
  value       = module.app_service_container_easyauth.app_service
  sensitive   = true
}
output "app_service_win_easyauth_root" {
  description = "App Service Windows (Windows WebApp) with easyauthv1 output object if Windows is choosen. Please refer to `./modules/windows-web-app/README.md`"
  value       = module.app_service_win_easyauth.app_service
  sensitive   = true
}

output "app_service_linux_easyauth_with_slots_root" {
  description = "App Service Linux (Linux WebApp) with easyauthv1 and Slots output object if Windows is choosen. Please refer to `./modules/windows-web-app/README.md`"
  value       = module.app_service_linux_easyauth_with_slots.app_service
  sensitive   = true
}