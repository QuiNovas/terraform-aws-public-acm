# terraform-aws-public-acm
Terraform Module for creating an acm certificate with dns validation

This module creates a public acm with DNS validation. Set `dns_validation` variable to true only if your parent domain is hosted in the same account. It issues the certificate by adding the validation records in the parent domain. If parent domain is not in the same account, the `domain_validation_options` output can be used in other terraform or add the records manually in your parent dns zone to get the certificate issued.

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|--------|
| dns\_validation | A boolean to validate the certificate using DNS. `hosted_zone_domain_name` should be passed as input if this is set to true | `bool` | n/a | yes |
| domain\_name | A domain name for which the certificate should be issued | `string` | n/a | yes |
| hosted\_zone\_domain\_name | The parent domain name to put the validation records of the sub domain, required if dns_validation is true | `string` | "" | no |
| subject\_alternative\_names | An optional set of domains that should be SANs in the issued certificate | `list(string)` | [] | no |
| tags | A mapping of key-value pairs to tag the resource | `map(string)` | {} | no |

## Usage
```
module "test" {
  dns_validation            = true
  domain_name               = "app.example.com"
  hosted_zone_domain_name   = "example.com"
  subject_alternative_names = ["www.app.example.com"]

  tags = {
    "Terraform"  = "true",
    "Enviroment" = "Test"
  }

  source = "QuiNovas/public-acm/aws"
}

```

## Outputs
| Name | Description |
|------|-------------|
| arn | The ARN (Amazon Resource Name) of the certificate |
| domain\_name | The domain name for which the certificate is issued |
| domain\_validation\_options | Set of domain validation objects which can be used to complete certificate validation outside of this terraform |
| status | Status of the certificate |

## Authors

Module managed by Quinovas (https://github.com/QuiNovas)

## License

Apache License, Version 2.0, January 2004 (http://www.apache.org/licenses/). See LICENSE for full details.