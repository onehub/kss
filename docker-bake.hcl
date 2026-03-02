variable "VERSIONS" {
  default = {
    "1.9" = { version = "1.9.3-p551", archive = "bz2", openssl = "1.0.2", bundler = "1.17.3" }
    "2.0" = { version = "2.0.0-p648", archive = "bz2", openssl = "1.0.2", bundler = "1.17.3" }
    "2.1" = { version = "2.1.10",     archive = "bz2", openssl = "1.0.2", bundler = "1.17.3" }
    "2.2" = { version = "2.2.10",     archive = "bz2", openssl = "1.0.2", bundler = "1.17.3" }
    "2.3" = { version = "2.3.8",      archive = "bz2", openssl = "1.0.2", bundler = "1.17.3" }
    "2.4" = { version = "2.4.10",     archive = "bz2", openssl = "1.1",   bundler = "1.17.3" }
    "2.5" = { version = "2.5.9",      archive = "bz2", openssl = "1.1",   bundler = "1.17.3" }
    "2.6" = { version = "2.6.10",     archive = "bz2", openssl = "1.1",   bundler = "1.17.3" }
    "2.7" = { version = "2.7.8",      archive = "bz2", openssl = "1.1",   bundler = "" }
    "3.0" = { version = "3.0.7",      archive = "gz",  openssl = "1.1",   bundler = "" }
    "3.1" = { version = "3.1.7",      archive = "gz",  openssl = "1.1",   bundler = "" }
    "3.2" = { version = "3.2.10",     archive = "gz",  openssl = "1.1",   bundler = "" }
    "3.3" = { version = "3.3.10",     archive = "gz",  openssl = "1.1",   bundler = "" }
    "3.4" = { version = "3.4.8",      archive = "gz",  openssl = "1.1",   bundler = "" }
    "4.0" = { version = "4.0.1",      archive = "gz",  openssl = "1.1",   bundler = "" }
  }
}

group "default" {
  targets = [
    "ruby-1-9",
    "ruby-2-0",
    "ruby-2-1",
    "ruby-2-2",
    "ruby-2-3",
    "ruby-2-4",
    "ruby-2-5",
    "ruby-2-6",
    "ruby-2-7",
    "ruby-3-0",
    "ruby-3-1",
    "ruby-3-2",
    "ruby-3-3",
    "ruby-3-4",
    "ruby-4-0",
  ]
}

target "_common" {
  dockerfile = "Dockerfile"
  context    = "."
}

target "ruby-1-9" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "1.9"
    RUBY_VERSION   = VERSIONS["1.9"].version
    RUBY_ARCHIVE   = VERSIONS["1.9"].archive
    OPENSSL        = VERSIONS["1.9"].openssl
    INSTALL_BUNDLER = VERSIONS["1.9"].bundler
  }
  tags = ["kss-test:1.9"]
}

target "ruby-2-0" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "2.0"
    RUBY_VERSION   = VERSIONS["2.0"].version
    RUBY_ARCHIVE   = VERSIONS["2.0"].archive
    OPENSSL        = VERSIONS["2.0"].openssl
    INSTALL_BUNDLER = VERSIONS["2.0"].bundler
  }
  tags = ["kss-test:2.0"]
}

target "ruby-2-1" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "2.1"
    RUBY_VERSION   = VERSIONS["2.1"].version
    RUBY_ARCHIVE   = VERSIONS["2.1"].archive
    OPENSSL        = VERSIONS["2.1"].openssl
    INSTALL_BUNDLER = VERSIONS["2.1"].bundler
  }
  tags = ["kss-test:2.1"]
}

target "ruby-2-2" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "2.2"
    RUBY_VERSION   = VERSIONS["2.2"].version
    RUBY_ARCHIVE   = VERSIONS["2.2"].archive
    OPENSSL        = VERSIONS["2.2"].openssl
    INSTALL_BUNDLER = VERSIONS["2.2"].bundler
  }
  tags = ["kss-test:2.2"]
}

target "ruby-2-3" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "2.3"
    RUBY_VERSION   = VERSIONS["2.3"].version
    RUBY_ARCHIVE   = VERSIONS["2.3"].archive
    OPENSSL        = VERSIONS["2.3"].openssl
    INSTALL_BUNDLER = VERSIONS["2.3"].bundler
  }
  tags = ["kss-test:2.3"]
}

target "ruby-2-4" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "2.4"
    RUBY_VERSION   = VERSIONS["2.4"].version
    RUBY_ARCHIVE   = VERSIONS["2.4"].archive
    OPENSSL        = VERSIONS["2.4"].openssl
    INSTALL_BUNDLER = VERSIONS["2.4"].bundler
  }
  tags = ["kss-test:2.4"]
}

target "ruby-2-5" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "2.5"
    RUBY_VERSION   = VERSIONS["2.5"].version
    RUBY_ARCHIVE   = VERSIONS["2.5"].archive
    OPENSSL        = VERSIONS["2.5"].openssl
    INSTALL_BUNDLER = VERSIONS["2.5"].bundler
  }
  tags = ["kss-test:2.5"]
}

target "ruby-2-6" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "2.6"
    RUBY_VERSION   = VERSIONS["2.6"].version
    RUBY_ARCHIVE   = VERSIONS["2.6"].archive
    OPENSSL        = VERSIONS["2.6"].openssl
    INSTALL_BUNDLER = VERSIONS["2.6"].bundler
  }
  tags = ["kss-test:2.6"]
}

target "ruby-2-7" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "2.7"
    RUBY_VERSION   = VERSIONS["2.7"].version
    RUBY_ARCHIVE   = VERSIONS["2.7"].archive
    OPENSSL        = VERSIONS["2.7"].openssl
    INSTALL_BUNDLER = VERSIONS["2.7"].bundler
  }
  tags = ["kss-test:2.7"]
}

target "ruby-3-0" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "3.0"
    RUBY_VERSION   = VERSIONS["3.0"].version
    RUBY_ARCHIVE   = VERSIONS["3.0"].archive
    OPENSSL        = VERSIONS["3.0"].openssl
    INSTALL_BUNDLER = VERSIONS["3.0"].bundler
  }
  tags = ["kss-test:3.0"]
}

target "ruby-3-1" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "3.1"
    RUBY_VERSION   = VERSIONS["3.1"].version
    RUBY_ARCHIVE   = VERSIONS["3.1"].archive
    OPENSSL        = VERSIONS["3.1"].openssl
    INSTALL_BUNDLER = VERSIONS["3.1"].bundler
  }
  tags = ["kss-test:3.1"]
}

target "ruby-3-2" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "3.2"
    RUBY_VERSION   = VERSIONS["3.2"].version
    RUBY_ARCHIVE   = VERSIONS["3.2"].archive
    OPENSSL        = VERSIONS["3.2"].openssl
    INSTALL_BUNDLER = VERSIONS["3.2"].bundler
  }
  tags = ["kss-test:3.2"]
}

target "ruby-3-3" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "3.3"
    RUBY_VERSION   = VERSIONS["3.3"].version
    RUBY_ARCHIVE   = VERSIONS["3.3"].archive
    OPENSSL        = VERSIONS["3.3"].openssl
    INSTALL_BUNDLER = VERSIONS["3.3"].bundler
  }
  tags = ["kss-test:3.3"]
}

target "ruby-3-4" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "3.4"
    RUBY_VERSION   = VERSIONS["3.4"].version
    RUBY_ARCHIVE   = VERSIONS["3.4"].archive
    OPENSSL        = VERSIONS["3.4"].openssl
    INSTALL_BUNDLER = VERSIONS["3.4"].bundler
  }
  tags = ["kss-test:3.4"]
}

target "ruby-4-0" {
  inherits = ["_common"]
  args = {
    RUBY_MAJOR     = "4.0"
    RUBY_VERSION   = VERSIONS["4.0"].version
    RUBY_ARCHIVE   = VERSIONS["4.0"].archive
    OPENSSL        = VERSIONS["4.0"].openssl
    INSTALL_BUNDLER = VERSIONS["4.0"].bundler
  }
  tags = ["kss-test:4.0"]
}
