variable "function_key" {
  description = "Path to the function zip within the package S3 bucket"
}

variable "layer_key" {
  description = "Path to the layer zip within the package S3 bucket"
}

variable "package_bucket" {
  description = "Name of the S3 bucket containing built packages"
}

variable "tags" {
  description = "Tags to apply to all resources"
}
