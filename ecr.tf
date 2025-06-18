# module "ecr" {
#   source  = "terraform-aws-modules/ecr/aws"
#   version = "~> 1.6"
#
#   repository_name                 = "asp-net-repo"
#   repository_image_tag_mutability = "IMMUTABLE"
#   repository_image_scan_on_push   = true
#   repository_force_delete         = true
#
#   repository_lifecycle_policy = jsonencode({
#     rules = [
#       {
#         rulePriority = 1,
#         description  = "Keep last 30 images",
#         selection = {
#           tagStatus     = "tagged",
#           tagPrefixList = ["v"],
#           countType     = "imageCountMoreThan",
#           countNumber   = 30
#         },
#         action = {
#           type = "expire"
#         }
#       }
#     ]
#   })
#
#   tags = {
#     Environment = "Test"
#     Terraform   = "True"
#   }
# }
