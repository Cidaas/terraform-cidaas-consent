resource "cidaas_consent_group" "group" {
  group_name  = var.group_name
  description = var.description
}

resource "cidaas_consent" "consent" {
  for_each = { for consent in var.consents : consent.name => consent }

  consent_group_id = cidaas_consent_group.group.id
  name             = each.value.name
  enabled          = var.enabled
}


locals {
  consents = flatten([
    for consent in var.consents : [
      for cv in consent.consent_versions : {
        name            = consent.name
        consent_id      = cidaas_consent.consent[consent.name].id
        consent_type    = consent.consent_type
        scopes          = consent.scopes
        required_fields = consent.required_fields
        version         = cv.version
        cl              = cv.consent_locales
      }
    ]
  ])
}

resource "cidaas_consent_version" "consent_version" {
  for_each = { for item in local.consents : "${item.name}-Version${item.version}" => item }

  consent_id      = each.value.consent_id
  version         = each.value.version
  consent_type    = each.value.consent_type
  scopes          = each.value.consent_type != "URL" ? each.value.scopes : null
  required_fields = each.value.consent_type != "URL" ? each.value.required_fields : null
  consent_locales = each.value.cl
}
