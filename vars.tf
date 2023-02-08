locals {
    env_name = "bank_offloading"
    description = "Production environment for GKO Solution Workshop"
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "owner" {
  type = string
  default = "eric"
}

variable "CONFLUENT_CLOUD_API_KEY" {
  type = string
}

variable "CONFLUENT_CLOUD_API_SECRET" {
  type = string
}

variable "subnet_mappings" {
  type = string
}

variable "cluster_name" {
  type = string
}


# locals {
#   cluster_name = {
#     pre-prod   = "pre-prod"
#     stage = "stage"
#     prod  = "prod"
#     test  = "test"
#   }
# }