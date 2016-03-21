#/bin/basg
# Get s3 creds from env var and write to password file
rm -f /etc/passwd-s3fs
echo "$S3_IDENTITY":"$S3_CREDENTIAL" >> /etc/passwd-s3fs
chmod 600 /etc/passwd-s3fs
# Mount s3 bucket from environment variable
mkdir -p /data
s3fs -o nonempty $S3_BUCKET /data
