output "key_vault_id" {
  description = "Resource ID of the platform Key Vault."
  value       = azurerm_key_vault.this.id
}

output "key_vault_uri" {
  description = "URI of the platform Key Vault."
  value       = azurerm_key_vault.this.vault_uri
}
