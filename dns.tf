data "azurerm_dns_zone" "this" {
  name                = var.base_domain
  resource_group_name = var.dns_zone_resource_group_name
}

resource "azurerm_dns_cname_record" "this" {
  name                = format("*.apps.%s", var.cluster_name)
  zone_name           = data.azurerm_dns_zone.this.name
  resource_group_name = var.dns_zone_resource_group_name
  ttl                 = 300
  record              = format("%s-%s.%s.cloudapp.azure.com.", var.cluster_name, replace(data.azurerm_dns_zone.this.name, ".", "-"), resource.azurerm_resource_group.this.location)
}
