provider "cidaas" {
  base_url = "https://cidaas.dev.de"
}

module "cidaas_consent_module" {
  source = "git@github.com:Cidaas/terraform-cidaas-consent.git"

  providers = {
    cidaas = cidaas
  }

  group_name  = "sample_consent_group"
  consents = [
    {
      name            = "consent1"
      consent_type    = "SCOPES"
      scopes          = ["developer"]
      required_fields = ["name"]
      consent_versions = [
        {
          version = 1
          consent_locales = [
            {
              content = "consent version in German"
              locale  = "de"
            },
            {
              content = "consent version in English"
              locale  = "en"
            }
          ]
        },
        {
          version = 2
          consent_locales = [
            {
              content = "consent version in French"
              locale  = "fr"
            }
          ]
        }
      ]
    },
    {
      name            = "consent2"
      consent_type    = "URL"
      consent_versions = [
        {
          version = 1
          consent_locales = [
            {
              content = "consent version in German"
              locale  = "de"
              url     = "https://cidaas.de/de"
            }
          ]
        }
      ]
    }
  ]
}
