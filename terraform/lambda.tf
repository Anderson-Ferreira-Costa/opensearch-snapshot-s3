data "archive_file" "this" {
  type        = "zip"
  source_file = "files/snapshot_opensearch.py"
  output_path = "files/snapshot_opensearch.zip"
}
resource "aws_lambda_function" "this" {

  function_name    = "snapshot_opensearch"
  filename         = data.archive_file.this.output_path
  source_code_hash = data.archive_file.this.output_base64sha256

  role    = aws_iam_role.role_for_lambda.arn
  runtime = "python3.9"
  handler = "snapshot_opensearch.lambda_handler"
  layers  = [aws_lambda_layer_version.this.arn]
  timeout = 10

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.this.id]
  }
}

resource "aws_lambda_layer_version" "this" {
  filename   = "files/mylayer.zip"
  layer_name = "mylayer"

  compatible_runtimes = ["python3.9"]
}


