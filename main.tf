resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.resource_group_location
}

# Container Registry
resource "azurerm_container_group" "main" {
  name                = "aci-terraform"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-terraform"
  os_type             = "Linux"

  container {
    name   = "hello-terraform-container"
    image  = "jeremydavis/hello-azure:1.6"
    cpu    = "1"
    memory = "4"
    ports {
      port     = 8080
      protocol = "TCP"
    }
  }
}
