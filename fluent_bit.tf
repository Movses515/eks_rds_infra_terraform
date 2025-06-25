resource "helm_release" "fluent_bit" {
  name       = "fluent-bit"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-for-fluent-bit"
  namespace  = "amazon-cloudwatch"
  create_namespace = true

  set {
    name  = "cloudWatch.enabled"
    value = "true"
  }

  set {
    name  = "cloudWatch.logGroupAutoCreate"
    value = "true"
  }

  set {
    name  = "cloudWatch.region"
    value = "us-east-1"
  }

  set {
    name  = "cloudWatch.logGroupName"
    value = "/aws/containerinsights/my-eks-cluster/application"
  }

  set {
    name  = "cloudWatch.logStreamPrefix"
    value = "fluentbit"
  }

  set {
    name  = "kinesis.enabled"
    value = "false"
  }

  set {
    name  = "elasticsearch.enabled"
    value = "false"
  }

  set {
    name  = "firehose.enabled"
    value = "false"
  }

  depends_on = [module.eks]
}
