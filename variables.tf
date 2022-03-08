variable "dns_validation" {
  description = "A boolean to validate the certificate using DNS. hosted_zone_domain_name should be passed as input if this is set to true"
  type        = bool
}

variable "domain_name" {
  description = "A domain name for which the certificate should be issued"
  type        = string
}

variable "hosted_zone_domain_name" {
  default     = ""
  description = "The parent domain name to put the validation records of the sub domain, required if dns_validation is true"
  type        = string
}

variable "subject_alternative_names" {
  default     = []
  description = "An optional set of domains that should be SANs in the issued certificate"
  type        = list(string)
}

variable "tags" {
  default     = {}
  description = "A mapping of key-value pairs to tag the resource"
  type        = map(string)
}
