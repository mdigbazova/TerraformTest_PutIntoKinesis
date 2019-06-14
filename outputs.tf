output "kinesis_arn" {
  description = "The arn of the Kinesis stream"
  value       = "${aws_kinesis_stream.kinesis_streamer_test_stream.arn}"
}

output "kinesis_name" {
  description = "The name of the Kinesis stream"
  value       = "${aws_kinesis_stream.kinesis_streamer_test_stream.name}"
}


output "kinesis_id" {
  description = "The Kinesis stream id"
  value       = "${aws_kinesis_stream.kinesis_streamer_test_stream.id}"
}


output "tags" {
  description = "Tags"
  value       = "${aws_kinesis_stream.kinesis_streamer_test_stream.tags}"
}

output "aws_lambda_event_source_arn" {
  description = "The Lambda vent mapping"
  value       = "${aws_lambda_event_source_mapping.kinesis_lambda_event_mapping.event_source_arn}"
}


output "aws_lambda_function" {
  description = "Lambda function"
  value       = "${aws_lambda_function.terraform_kinesis_streamer_func.function_name}"
}