resource "aws_s3_bucket" "dishare-s3-bucket" {
  bucket = "dishare-bucket-for-image-uploade"
  acl    = "public-read"
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "dishare-bucket-for-image-uploade"
  }
}