#!/usr/bin/env ruby

require "yaml"

input = YAML.load_file("./docker-compose.yml")
puts input["services"].keys.join("\n")
