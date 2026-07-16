variable "cluster_name" {
  type    = string
  default = "vion-eks-cluster"
}

resource "aws_eks_cluster" "vion_cluster" {
  name     = var.cluster_name
  role_arn = "arn:aws:iam::123456789012:role/eks-mock-role"

  vpc_config {
    # MiniStack ignores strict subnet configurations but requires the block
    subnet_ids = ["subnet-12345678", "subnet-87654321"]
  }
}

output "cluster_name" {
  value = aws_eks_cluster.vion_cluster.name
}
