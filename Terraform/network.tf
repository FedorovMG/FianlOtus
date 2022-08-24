resource "yandex_vpc_network" "data_net" {
  name = "data_net"
}

resource "yandex_vpc_subnet" "data_subnet" {
  name = "MySubnet"
  zone = var.zone
  network_id = yandex_vpc_network.data_net.id
  v4_cidr_blocks = [ "10.0.1.0/24" ]
}
/*
resource "yandex_vpc_security_group" "sg" {
  network_id = yandex_vpc_network.data_net.id
  ingress {
    protocol = "TCP"
    v4_cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 65535
  }
}
*/