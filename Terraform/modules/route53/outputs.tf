output "zone_id" {
  value = data.aws_route53_zone.app_zone.id
}

output "cert_arn" {
  value = aws_acm_certificate.cert.arn
}