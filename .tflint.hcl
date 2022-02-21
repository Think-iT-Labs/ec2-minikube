config {
  module = true
}

plugin "aws" {
  enabled = true
  version = "0.12.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "terraform_naming_convention" {
  enabled = true
}
rule "terraform_typed_variables" {
  enabled = true
}
rule "terraform_unused_required_providers" {
  enabled = true
}
