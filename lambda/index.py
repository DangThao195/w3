import boto3
import os

bedrock = boto3.client("bedrock-agent-runtime")
dynamodb = boto3.resource("dynamodb")

table = dynamodb.Table(os.environ["TABLE_NAME"])
kb_id = os.environ["KB_ID"]

def lambda_handler(event, context):

    file_name = event["Records"][0]["s3"]["object"]["key"]

    print("Processing:", file_name)

    response = bedrock.retrieve_and_generate(
        input={
            "text": f"Summarize document {file_name}"
        },
        retrieveAndGenerateConfiguration={
            "type": "KNOWLEDGE_BASE",
            "knowledgeBaseConfiguration": {
                "knowledgeBaseId": kb_id,
                "modelArn": "arn:aws:bedrock:ap-southeast-1::foundation-model/anthropic.claude-v2"
            }
        }
    )

    summary = response["output"]["text"]

    table.put_item(
        Item={
            "file_name": file_name,
            "summary": summary
        }
    )

    print("Saved to DynamoDB")

    return {
        "statusCode": 200
    }