#!/bin/bash
# Variables
RDS_HOST="terraform-20240916054218433500000006.c38i02cui857.us-west-1.rds.amazonaws.com" # Replace with your actual RDS endpoint
RDS_PORT="3306" # Replace if you're using a different port
RDS_DB_NAME="terraform-20240916054218433500000006" # Replace with your database name
RDS_USER="admin" # Replace with your database username
RDS_PASSWORD="Jenkins_Ninjas" # Replace with your database password
S3_BUCKET_NAME="jenkins-ninjas-backup-bucket" # Replace with your S3 bucket name
BACKUP_FILE="backup-$(date +'%Y%m%d%H%M%S').sql"
AWS_REGION="us-west-1" # Replace with your AWS region

# Create MySQL dump
echo "Creating MySQL dump..."
mysqldump -h $RDS_HOST -P $RDS_PORT -u $RDS_USER -p$RDS_PASSWORD $RDS_DB_NAME > /tmp/$BACKUP_FILE

if [ $? -eq 0 ]; then
    echo "MySQL dump created successfully: /tmp/$BACKUP_FILE"
else
    echo "Failed to create MySQL dump"
    exit 1
fi

# Upload dump to S3
echo "Uploading backup to S3..."
aws s3 cp /tmp/$BACKUP_FILE s3://$S3_BUCKET_NAME/$BACKUP_FILE --region $AWS_REGION

if [ $? -eq 0 ]; then
    echo "Backup uploaded to S3 successfully"
else
    echo "Failed to upload backup to S3"
    exit 1
fi

# Clean up
rm /tmp/$BACKUP_FILE