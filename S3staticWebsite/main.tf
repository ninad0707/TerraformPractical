#Create S3 Bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
#once bucket created make it public using below
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#create access control list for the bucket created 
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}

#create  object and upload to S3 bucket
resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.mybucket.id
  key    = index.html
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.mybucket.id
  key    = error.html
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
}

#Enable static website hosting parameter on S3 bucket
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

 depends_on = [ aws_s3_bucket_acl.example ]
}