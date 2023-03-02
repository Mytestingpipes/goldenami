sleep 30
aws inspector2 create-findings-report --filter-criteria '{"resourceTags" : [{"comparison" : "EQUALS" , "key" : "Name" , "value": "Goldenami-v1"}]}' --report-format JSON --s3-destination bucketName=gami-sat/gami-v/,kmsKeyArn=arn:aws:kms:us-east-1:363638483937:key/19ebe049-fb7a-4352-ac1a-8722b093b528
