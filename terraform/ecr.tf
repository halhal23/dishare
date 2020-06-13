resource "aws_ecr_repository" "dishare-nuxt" {
  name                 = "dishare-nuxt"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
resource "aws_ecr_repository" "dishare-rails" {
  name                 = "dishare-rails"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}