project = "go"

runner {
  enabled = true
  profile = "kratix-production"

  data_source "git" {
    url  = "https://github.com/abangser/waypoint-example-go"
  }
}

app "go-k8s" {
  labels = {
    "service" = "go-k8s",
    "env"     = "dev"
  }

  build {
    use "docker" {}
    registry {
      use "docker" {
        image = "abangser/waypoint-example-go"
        tag = gitrefpretty()
        local = true
      }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path = "/"
      service_port = 3000
    }
  }

  release {
    use "kubernetes" {}
  }
}
