resource "yandex_compute_instance" "clickhouse" {
  name = "clickhouse-server"
  platform_id = "standard-v1"
  resources {
    cores = 2
    memory = 4
  }
  
  boot_disk {
    disk_id = yandex_compute_disk.disk_clickhouse.id
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.data_subnet.id
    nat = true
  }
  
  metadata = {
    
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}" 
  }
}


/*
resource "yandex_vpc_security_group" "airflow-ports" {
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
}


resource "yandex_vpc_security_group" "cluster-sg" {
  network_id = yandex_vpc_network.data_net.id

  ingress {
    description    = "HTTPS (secure)"
    port           = 8443
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "clickhouse-client (secure)"
    port           = 9440
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description    = "Allow all egress cluster traffic"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_mdb_clickhouse_cluster" "mych" {
  name               = "mych"
  environment        = "PRESTABLE"
  network_id         = yandex_vpc_network.data_net.id
  security_group_ids = [yandex_vpc_security_group.cluster-sg.id]

  clickhouse {
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 32
    }
  }

  host {
    type      = "CLICKHOUSE"
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.data_subnet.id
  }

  database {
    name = "testdb"
  }

  user {
    name     = "testuser"
    password = "testuser"
    permission {
      database_name = "testdb"
    }
  }
}
*/