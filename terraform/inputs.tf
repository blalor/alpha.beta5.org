variable "site_name" {
    type = "string"
    description = "the domain name of the site"
}

variable "aws_region" {
    type = "string"
    description = "the aws region where resources will be created"
    default = "us-east-1"
}

# variable "site_aliases" {
#     type = "list"
#     description = "list of hostnames the site will be served under"
# }

data "aws_ip_ranges" "cloudfront" {
    services = ["cloudfront"]
}

locals {
    ## where in the bucket the static site files exist
    jekyll_site_prefix = "/_site"
    photos_prefix = "/photos"
}
