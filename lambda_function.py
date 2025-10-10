import boto3
import json
import os
from datetime import datetime, timezone

# Initialize AWS clients
dynamodb = boto3.resource('dynamodb')
sns = boto3.client('sns')

def lambda_handler(event, context):
    print("Event received:", json.dumps(event))

    # Extract file info from the S3 event
    record = event['Records'][0]
    bucket_name = record['s3']['bucket']['name']
    object_key = record['s3']['object']['key']
    size = record['s3']['object']['size']

    # Get environment variables
    table_name = os.environ['TABLE_NAME']
    sns_topic_arn = os.environ['SNS_TOPIC_ARN']

    # Save metadata to DynamoDB
    table = dynamodb.Table(table_name)
    table.put_item(Item={
        'filename': object_key,
        'bucket': bucket_name,
        'size': size,
        'uploaded_at': datetime.now(timezone.utc).isoformat()
    })

    # Publish message to SNS
    sns.publish(
        TopicArn=sns_topic_arn,
        Message=f"New image uploaded: {object_key} ({size} bytes)",
        Subject="New Image Uploaded to S3"
    )

    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Metadata stored and notification sent!"})
    }
