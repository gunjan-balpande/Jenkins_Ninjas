# Create S3 bucket for static website hosting
resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "jenkins-ninjas-static-website-bucket"  # Ensure this bucket name is globally unique

  # Removed deprecated website block
  

  tags = {
    Name = "Jenkins_Ninjas_S3_SWH"
  }
}



# Create S3 bucket for RDS backups
resource "aws_s3_bucket" "backup_bucket" {
  bucket = "jenkins-ninjas-backup-bucket"  # Ensure this bucket name is globally unique

  tags = {
    Name = "Jenkins_Ninjas_S3_Backup"
  }
}

# Configure the S3 bucket for static website hosting
resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website_bucket.id

  index_document {
    suffix = "index.html"
  }

  # Uncomment the following line if you have a custom error page
  # error_document {
  #   key = "error.html"
  # }
}

# Set object ownership controls for the static website bucket
resource "aws_s3_bucket_ownership_controls" "static_website_bucket_ownership" {
  bucket = aws_s3_bucket.static_website_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Set object ownership controls for the RDS backup bucket
resource "aws_s3_bucket_ownership_controls" "rds_backup_bucket_ownership" {
  bucket = aws_s3_bucket.backup_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}


# Block public access for the static website bucket
resource "aws_s3_bucket_public_access_block" "static_website_public_access_block" {
  bucket = aws_s3_bucket.static_website_bucket.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets  = false
}

# Add bucket policy for public read access
resource "aws_s3_bucket_policy" "static_website_policy" {
  bucket = aws_s3_bucket.static_website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.static_website_bucket.arn}/*"
      }
    ]
  })
}


# Add CORS configuration for the static website bucket
resource "aws_s3_bucket_cors_configuration" "static_website_cors" {
  bucket = aws_s3_bucket.static_website_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST", "PUT", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}