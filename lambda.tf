resource "aws_lambda_function" "pdf_processor" {
  function_name = "pdf-bedrock-processor"

  role    = aws_iam_role.lambda_role.arn
  handler = "index.lambda_handler"
  runtime = "python3.11"

  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")

  timeout = 60

  environment {
    variables = {
      TABLE_NAME = "pdf-summary"
      KB_ID      = "PASTE_YOUR_KB_ID"
    }
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.pdf_processor.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.docs_bucket.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.docs_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.pdf_processor.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3]
}