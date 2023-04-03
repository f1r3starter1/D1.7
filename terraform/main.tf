terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~>0.65.0"
    }
  }
}
provider "yandex" {
  token     = "t1.9euelZrGlZ6ZzI-Jns6Vi82enp6VkO3rnpWaxpGelMzHnY3JksvNlInLjczl9Pd1GVZe-e9QNGOr3fT3NUhTXvnvUDRjqw.DxfA-nNU6nXDQyXS6nBckCzZdJmyPIWgP_zyJzpYPeBr6Lj1LoW9YZ7dEAj1ODUChs2eQ_-5GXLna0K5cPSkCw"
  cloud_id  = "b1g52fls4gn42ltpb8r4"
  folder_id = "b1gkah722jo1350jlth2"
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "network" {
  name = "swarm-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet_swarm1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

module "swarm_cluster" {
  source        = "./modules/instance"
  vpc_subnet_id = yandex_vpc_subnet.subnet.id
  managers      = 1
  workers       = 2
}
