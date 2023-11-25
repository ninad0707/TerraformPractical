#Print the endpoints url of bucket
output "websiteendpoints" {
  value = aws_s3_bucket.mybucket.id

}