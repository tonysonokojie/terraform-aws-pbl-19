# The entire section create a certiface, public zone, and validate the certificate using DNS method

# Create the certificate using a wildcard for all the domains created in mynginx.co.uk
resource "aws_acm_certificate" "mynginx" {
domain_name       = "*.mynginx.co.uk"
validation_method = "DNS"
}

# calling the hosted zone
data "aws_route53_zone" "mynginx" {
name = "mynginx.co.uk"
private_zone = false
}

# selecting validation method
resource "aws_route53_record" "mynginx" {
for_each = {
    for dvo in aws_acm_certificate.mynginx.domain_validation_options : dvo.domain_name => {
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
zone_id         = data.aws_route53_zone.mynginx.zone_id
}

# validate the certificate through DNS method
resource "aws_acm_certificate_validation" "mynginx" {
certificate_arn         = aws_acm_certificate.mynginx.arn
validation_record_fqdns = [for record in aws_route53_record.mynginx : record.fqdn]
}

# create records for tooling
resource "aws_route53_record" "tooling" {
zone_id = data.aws_route53_zone.mynginx.zone_id
name    = "tooling.mynginx.co.uk"
type    = "A"

alias {
    name                   = aws_lb.ext-alb.dns_name
    zone_id                = aws_lb.ext-alb.zone_id
    evaluate_target_health = true
}
}


# create records for wordpress
resource "aws_route53_record" "wordpress" {
zone_id = data.aws_route53_zone.mynginx.zone_id
name    = "wordpress.mynginx.co.uk"
type    = "A"

alias {
    name                   = aws_lb.ext-alb.dns_name
    zone_id                = aws_lb.ext-alb.zone_id
    evaluate_target_health = true
}
}