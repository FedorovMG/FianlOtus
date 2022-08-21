resource "yandex_vpc_network" "data_net" {
  name = "data_net"
}

resource "yandex_vpc_subnet" "data_subnet" {
  network_id = yandex_vpc_network.data_net.id
  v4_cidr_blocks = [ "10.0.1.0/24" ]
  zone = var.zone
}

resource "yandex_vpc_security_group" "data-sg" {
  network_id = yandex_vpc_network.data_net.id
  ingress {
    protocol = "TCP"
    v4_cidr_blocks = [ "10.0.1.0/24" ]
    port = 22 
  }
  ingress {
    protocol = "TCP"
    v4_cidr_blocks = [ "10.0.1.0/24" ]
    port = 8080
  }
  ingress {
    protocol = "TCP"
    v4_cidr_blocks = [ "10.0.1.0/24" ]
    port = 443 
  }
}