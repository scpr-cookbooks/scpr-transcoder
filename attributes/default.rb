default.scpr_transcoder.consul_service   = "transcoder-prod"
default.scpr_transcoder.version          = "0.1.1"
default.scpr_transcoder.user             = "transcoder"
default.scpr_transcoder.dir              = "/scpr/transcoder"
default.scpr_transcoder.port             = 8000

#----------

include_attribute "nodejs"

default.nodejs.install_method = "package"
default.nodejs.repo           = "https://deb.nodesource.com/node_4.x"