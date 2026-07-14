resource "aws_s3_bucket" "frontend" {
  bucket        = "frontend-s3"
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "hosting" {
  bucket = aws_s3_bucket.frontend.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "html" {
  bucket       = aws_s3_bucket.frontend.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/index.html") # Forces upload on change
}

# This resource opens up local CORS channels for S3
resource "aws_s3_bucket_cors_configuration" "frontend_cors" {
  bucket = aws_s3_bucket.frontend.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST", "PUT", "HEAD"]
    allowed_origins = ["*"] # Allows local cross-port communication
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}