module "app_service_plan" {
  source = "./../.." # Use the local version to test it

  app_service_plan_name = "${local.prefix_kebab}-${local.hash_suffix}-asp"
  location              = module.rg.resource_group_location
  resource_group_name   = module.rg.resource_group_name
  os_type               = "Linux"
  sku_name              = "B2"


}
module "app_service_plancomp" {
  source = "./../.." # Use the local version to test it

  app_service_plan_name = "${local.prefix_kebab}-${local.hash_suffix}-aspc"
  location              = module.rgcomp.resource_group_location
  resource_group_name   = module.rgcomp.resource_group_name

  kind = "Linux"
  sku = {
    tier = "PremiumV2"
    size = "P1v2"
  }
}