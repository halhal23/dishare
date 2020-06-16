resource "aws_route53_zone" "dishare-host-zone" {
  name    = "dishare.work"
  comment = "dishare.work host zone"
}
resource "aws_route53_record" "dishare-host-zone-record" {
  zone_id = aws_route53_zone.dishare-host-zone.zone_id
  name    = aws_route53_zone.dishare-host-zone.name
  type    = "A"

  alias {
    name                   = aws_lb.dishare_alb.dns_name
    zone_id                = aws_lb.dishare_alb.zone_id
    evaluate_target_health = false
  }
}
