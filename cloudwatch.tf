resource "aws_cloudwatch_dashboard" "eks_pods" {
  dashboard_name = "EKS-Pod-Resource-Monitor"

  dashboard_body = jsonencode({
    widgets = [
      {
        "type" : "metric",
        "x" : 0, "y" : 0, "width" : 12, "height" : 6,
        "properties" : {
          "title" : "Top 5 Pods by CPU",
          "view" : "timeSeries",
          "region" : "us-east-1",
          "stat" : "Average",
          "period" : 60,
          "metrics" : [
            [
              "ContainerInsights",
              "cpu_usage_total",
              "ClusterName",
              "my-eks-cluster",
              "Namespace",
              "default"
            ]
          ],
          "yAxis" : {
            "left" : {
              "label" : "Memory (MB)"
            }
          },
          "legend" : {
            "position" : "bottom"
          },
          "title" : "Memory Usage",
          "stat" : "Average"
        }
      },
      {
        "type" : "metric",
        "x" : 12, "y" : 0, "width" : 12, "height" : 6,
        "properties" : {
          "title" : "Top 5 Pods by Memory",
          "view" : "timeSeries",
          "region" : "us-east-1",
          "stat" : "Average",
          "period" : 60,
          "metrics" : [
            [
              "ContainerInsights",
              "memory_working_set",
              "ClusterName",
              "my-eks-cluster",
              "Namespace",
              "default"
            ]
          ],
          "yAxis" : {
            "left" : {
              "label" : "Memory (MB)"
            }
          },
          "legend" : {
            "position" : "bottom"
          },
          "title" : "Memory Usage",
          "stat" : "Average"
        }
      }
    ]
  })
}


resource "aws_cloudwatch_log_metric_filter" "pod_failures" {
  name           = "eks-pod-failures"
  log_group_name = "/aws/containerinsights/my-eks-cluster/application"
  pattern        = "?CrashLoopBackOff ?OOMKilled ?FailedScheduling ?FailedMount ?Error"

  metric_transformation {
    value     = "1"
    namespace = "EKSAppErrors"
    name      = "PodFailureEvents"
  }

  depends_on = [helm_release.cloudwatch_insights]
}

resource "aws_cloudwatch_metric_alarm" "container_restarts" {
  alarm_name          = "container-restarts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 0
  metric_name         = "container_restart_count"
  namespace           = "ContainerInsights"
  statistic           = "Sum"
  period              = 60

  dimensions = {
    ClusterName = "my-eks-cluster"
  }

  alarm_description = "Alert when any container restarts"
  alarm_actions     = [aws_sns_topic.alerts.arn]
  treat_missing_data = "notBreaching"
}

