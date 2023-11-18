# frozen_string_literal: true

# Your Ruby code goes here

# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server
