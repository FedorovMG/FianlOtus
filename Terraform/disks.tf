/*
resource "yandex_compute_disk" "disk_clickhouse" {
  type = "network-hdd"
  size = "20"
  image_id = "fd8cqj9qiedndmmi3vq6"
}
*/
resource "yandex_compute_disk" "disk_airflow" {
  type = "network-hdd"
  size = "20"
  image_id = "fd8cqj9qiedndmmi3vq6"
}
