resource "digitalocean_droplet" "www-1" {
 image              = "ubuntu-18-04-x64"
 name               = "www-1"
 region             = "sgp1"
 size               = "s-1vcpu-1gb"
 private_networking = true
 ssh_keys = [
  "${var.ssh_fingerprint}"
 ]

 connection {
  user        = "root"
  type        = "ssh"
  private_key = "${file(var.pvt_key)}"
  timeout     = "2m"
 }

 provisioner "remote-exec" {
  inline = [
   "export PATH=$PATH:/user/bin",
   # install nginx
   "sudo apt-get update",
   "sudo apt-get -y install nginx"
  ]
 }
}