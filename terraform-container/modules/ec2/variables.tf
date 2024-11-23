variable "ami" {
  description = "AMI ID para la instancia EC2"
  type        = string
  default     = "ami-0abcdef1234567890"  # ID ficticio para LocalStack
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "name" {
  description = "Nombre de la instancia EC2"
  type        = string
}
