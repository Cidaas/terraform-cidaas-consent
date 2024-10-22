output "consent_group_id" {
  value = cidaas_consent_group.group.id
}

output "consents" {
  value = cidaas_consent.consent
}

output "consent_versions" {
  value = cidaas_consent_version.consent_version
}
