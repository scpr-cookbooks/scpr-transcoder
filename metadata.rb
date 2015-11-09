name 'scpr-transcoder'
maintainer 'Southern California Public Radio'
maintainer_email 'erichardson@scpr.org'
license 'apache2'
description 'Installs/Configures scpr-transcoder'
long_description 'Installs/Configures scpr-transcoder'
version '0.1.4'

depends "scpr-consul", "~> 0.1.25"
depends "nodejs", "= 2.4.0"
depends "runit"
depends "scpr-tools"
