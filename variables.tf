#################
### Variables ###
#################

variable "p" {
  description = "An abbreviated prefix for all of the resource names"
  type        = "string"
  default     = "PRJ"
}

variable "project_id" {
  description = "The project ID of the project"
  type        = "string"
  default     = "proj-222320"
}

variable "region" {
  description = "The region of the project"
  type        = "string"
  default     = "europe-north1"
}

variable "zone" {
  description = "The zone of the project"
  type        = "string"
  default     = "europe-north1-c"
}

variable "name" {
  description = "Name of the project"
  type        = "string"
  default     = "proj"
}
