resource "helm_release" "cloudwatch_insights" {
  name       = "cloudwatch-agent"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-cloudwatch-metrics"
  namespace  = "amazon-cloudwatch"
  create_namespace = true

  set {
    name  = "clusterName"
    value = "my-eks-cluster"
  }

  set {
    name  = "region"
    value = "us-east-1"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "cloudwatch-agent"
  }

  set {
    name  = "logs.enabled"
    value = "true"
  }

  depends_on = [module.eks]
}
