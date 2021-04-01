data "ec_stack" "latest" {
  version_regex = "latest"
  region        = "%s"
}

resource "ec_deployment" "dedicated_coordinating" {
  name                   = "%s"
  region                 = "%s"
  version                = data.ec_stack.latest.version
  deployment_template_id = "%s"

  elasticsearch {
    topology {
      id         = "hot_content"
      zone_count = 1
      size       = "1g"
    }
    topology {
      id         = "warm"
      zone_count = 1
      size       = "2g"
    }
    topology {
      id         = "coordinating"
      zone_count = 2
      size       = "1g"
    }
  }
}