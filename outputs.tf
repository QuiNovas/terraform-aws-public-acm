output "arn" {
  description = "The ARN (Amazon Resource Name) of the certificate"
  value       = aws_acm_certificate.certificate.arn
}

output "domain_name" {
  description = "The domain name for which the certificate is issued"
  value       =  aws_acm_certificate.certificate.domain_name
}

output "domain_validation_options" {
  description = "Set of domain validation objects which can be used to complete certificate validation outside of this terraform"
  value       =  aws_acm_certificate.certificate.domain_validation_options
}

output "status" {
  description = "Status of the certificate"
  value       =  aws_acm_certificate.certificate.status
}