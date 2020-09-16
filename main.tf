##################################
# IAM User - SynapseStudiosGrafana
##################################
resource "aws_iam_user" "synapsestudios_grafana" {
  name = "synapsestudios-grafana"
  path = "/sysops/"
  tags = var.tags
}

resource "aws_iam_access_key" "synapsestudios_grafana_key" {
  user = aws_iam_user.synapsestudios_grafana.name
}

#########################################
# IAM Policy - CloudWatchMetricsReadyOnly
#########################################
data "aws_iam_policy_document" "monitoring_policy" {
  statement {
    sid = "SynapseStudiosMonitoringPolicy"

    actions = [
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:DescribeAnomalyDetectors",
      "cloudwatch:DescribeInsightRules",
      "cloudwatch:GetDashboard",
      "cloudwatch:GetInsightRuleReport",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:GetMetricWidgetImage",
      "cloudwatch:ListDashboards",
      "cloudwatch:ListMetrics",
      "cloudwatch:ListTagsForResource",
      "ec2:DescribeInstances",
      "ecs:DescribeServices",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "rds:DescribeDBClusters",
      "rds:DescribeDBInstances",
      "rds:DescribeEvents",
      "rds:DescribePendingMaintenanceActions",
      "s3:GetAccountPublicAccessBlock",
      "s3:GetBucketAcl",
      "s3:GetBucketCORS",
      "s3:GetBucketLocation",
      "s3:GetBucketNotification",
      "s3:GetBucketPolicy",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketTagging",
      "s3:GetBucketWebsite",
      "s3:GetEncryptionConfiguration",
      "s3:GetObjectAcl",
      "s3:HeadBucket",
      "s3:List*",
      "ses:GetSendQuota",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:ListQueues",
      "sqs:ListQueueTags",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "monitoring_policy" {
  name   = "SynapseStudiosMonitoring"
  path   = "/sysops/"
  policy = data.aws_iam_policy_document.monitoring_policy.json
}

resource "aws_iam_user_policy_attachment" "synapsestudios_grafana_cloudwatch_policy" {
  user       = aws_iam_user.synapsestudios_grafana.name
  policy_arn = aws_iam_policy.monitoring_policy.arn
}

#######################################
# IAM Policy - SynapseStudiosMonitoring
#######################################
data "aws_iam_policy_document" "synapsestudios_monitoring_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#####################################
# IAM Role - SynapseStudiosMonitoring
#####################################
resource "aws_iam_role" "synapsestudios_monitoring" {
  name               = "SynapseStudiosMonitoring"
  path               = "/sysops/"
  assume_role_policy = data.aws_iam_policy_document.synapsestudios_monitoring_policy.json
}

resource "aws_iam_role_policy_attachment" "monitoring_policy" {
  role       = aws_iam_role.synapsestudios_monitoring.name
  policy_arn = aws_iam_policy.monitoring_policy.arn
}

#######################################################
# IAM EC2 Instance Profile for SynapseStudiosMonitoring
#######################################################
resource "aws_iam_instance_profile" "synapsestudios_monitoring" {
  name = "synapsestudios_monitoring"
  role = aws_iam_role.synapsestudios_monitoring.name
}
