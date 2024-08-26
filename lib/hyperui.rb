# frozen_string_literal: true

require 'hyperui/version'
require 'hyperui/engine'
require 'view_component'

module Hyperui
end

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/generators")
loader.ignore('lib/hyperui/railtie.rb') unless defined?(Rails::Railtie)
loader.setup
