resource "aws_instance" "example" {
  ami           = var.ami           # AMI ID para la instancia EC2
  instance_type = var.instance_type # Tipo de instancia EC2

  # Mezcla las etiquetas proporcionadas con una personalizada para el "Name"
  tags = merge(
    var.tags_ec2,
    { Name = var.instance_name } # Etiqueta "Name" personalizada
  )
}
