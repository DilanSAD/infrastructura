variable "ami" {
  description = "AMI ID para la instancia EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2 (e.g., t2.micro, t3.small, etc.)"
  type        = string
}

variable "tags_ec2" {
  description = "Etiquetas generales para la instancia EC2"
  type        = map(string)
  default     = {}
}

variable "instance_name" {
  description = "Nombre lógico de la instancia EC2 (para la etiqueta 'Name')"
  type        = string
}
