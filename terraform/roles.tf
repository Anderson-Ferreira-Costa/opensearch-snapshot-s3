# Role for lambda
resource "aws_iam_role" "role_for_lambda" {
  name = "snapshot-opensearch"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

# Policy for lambda
resource "aws_iam_policy" "policy_for_lambda" {
  name = "snapshot-opensearch"
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "iam:PassRole",
          "es:ESHttpPut"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_lambda" {
  role       = aws_iam_role.role_for_lambda.name
  policy_arn = aws_iam_policy.policy_for_lambda.arn
}

# Role for OpenSearch
resource "aws_iam_role" "role_for_opensearch" {
  name = "TheSnapshotRole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "opensearchservice.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

# Policy for OpenSearch
resource "aws_iam_policy" "policy_for_opensearch" {
  name = "TheSnapshotRole"
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket"
        ],
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::meios-de-pagamento-prd-opensearch-bkp"]
      },
      {
        "Action" : [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Effect   = "Allow",
        Resource = ["arn:aws:s3:::meios-de-pagamento-prd-opensearch-bkp/*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_opensearch" {
  role       = aws_iam_role.role_for_opensearch.name
  policy_arn = aws_iam_policy.policy_for_opensearch.arn
}





