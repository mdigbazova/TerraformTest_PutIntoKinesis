provider "aws" {
  region = "${var.aws_region}"
}

# IAM

## IAM Role
resource "aws_iam_role" "iam_for_terraform_lambda" {
  name = "kinesis_streamer_iam_role"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
EOF
}


## IAM Role Policies

resource "aws_iam_role_policy_attachment" "terraform_lambda_iam_policy_basic_execution" {
  role = "${aws_iam_role.iam_for_terraform_lambda.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "terraform_lambda_iam_policy_kinesis_execution" {
  role = "${aws_iam_role.iam_for_terraform_lambda.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaKinesisExecutionRole"
}

# Lambda

resource "aws_lambda_function" "terraform_kinesis_streamer_func" {
  #filename = "lambda_code.zip"
  filename = "breck_msg.zip"
  function_name = "kinesis_streamer_test_lambda_function"
  role = "${aws_iam_role.iam_for_terraform_lambda.arn}"
  handler = "lib/handler.testHandler"
  runtime = "nodejs4.3"
  source_code_hash = "${base64sha256(file("breck_msg.zip"))}"
  #source_code_hash = "${base64sha256(file("lambda_code.zip"))}"#
}

resource "aws_lambda_event_source_mapping" "kinesis_lambda_event_mapping" {
  batch_size = 100
  event_source_arn = "${aws_kinesis_stream.kinesis_streamer_test_stream.arn}"
  enabled = true
  function_name = "${aws_lambda_function.terraform_kinesis_streamer_func.arn}"
  starting_position = "TRIM_HORIZON"
}

# Kinesis

## Kinesis Streams
resource "aws_kinesis_stream" "kinesis_streamer_test_stream" {
  name = "terraform-kinesis-streamer-test-stream" #terraform-kinesis-streamer-test-stream
  shard_count = 1
  retention_period = 24
  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes"
  ]
  tags {
    Environment = "dev"
  }
}
