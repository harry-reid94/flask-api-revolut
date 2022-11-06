resource "aws_efs_file_system" "efs" {
  tags = {
    Name = "flask-efs"
  }
}

# resource "aws_efs_mount_target" "mount_a" {
#   file_system_id = aws_efs_file_system.efs.id
#   subnet_id      = aws_subnet.private_subnet.0.id
# }

# resource "aws_efs_mount_target" "mount_b" {
#   file_system_id = aws_efs_file_system.efs.id
#   subnet_id      = aws_subnet.private_subnet.1.id
# }

resource "aws_efs_mount_target" "efs-mount" {
   count = length(aws_subnet.private_subnet.*.id)
   file_system_id  = aws_efs_file_system.efs.id
   subnet_id = element(aws_subnet.private_subnet.*.id, count.index)
   security_groups = [aws_security_group.efs_sg.id]
}