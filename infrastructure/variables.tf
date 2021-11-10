variable "build" {
  description = "Build number"
}

variable "commit" {
  description = "Full git commit sha"
}

variable "function_key" {
  description = "Path to the function zip within the package S3 bucket"
}

variable "layer_key" {
  description = "Path to the layer zip within the package S3 bucket"
}

variable "package_bucket" {
  description = "Name of the S3 bucket containing built packages"
}

variable "repository" {
  description = "The full repo URL"
}

variable "service" {
  description = "The name of the service"
}
