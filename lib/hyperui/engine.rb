# frozen_string_literal: true

module Hyperui
  class Engine < ::Rails::Engine
    isolate_namespace Hyperui

    initializer 'hyperui.importmap', before: 'importmap' do |app|
      app.config.importmap.paths << Engine.root.join('config/importmap.rb')
      app.config.importmap.cache_sweepers << root.join('app/assets/javascripts')
    end

    initializer 'hyperui.assets' do |app|
      app.config.assets.precompile += %w[hyperui_manifest]
    end
  end
end
