resource "aws_acm_certificate" "certificate" {
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "certificate" {
  count        = var.dns_validation ? 1 : 0
  name         = var.hosted_zone_domain_name
  private_zone = false
}

resource "aws_route53_record" "certificate" {
  for_each = {
    for dvo in var.dns_validation ? aws_acm_certificate.certificate.domain_validation_options : [] : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.certificate.0.zone_id
}

resource "aws_acm_certificate_validation" "certificate" {
  count                   = var.dns_validation ? 1 : 0
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate : record.fqdn]
}
