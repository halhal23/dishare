resource "aws_acm_certificate" "dishare-certificate" {
  domain_name = aws_route53_zone.dishare-host-zone.name
  validation_method = "DNS"
  tags = {
    "dishare" = "certificate"
  }
}
data "aws_acm_certificate" "dishare-acm" {
  domain   = "dishare.work"
}

output "dishare-acm-arm" {
  value = "${data.aws_acm_certificate.dishare-acm.arn}"
}