# frozen_string_literal: true

module Hyperui
  class Card < Base
    erb_template <<~HTML
      <%= content_tag :div, class: classes, **options do %>
        <%= content %>
      <% end %>
    HTML

    attr_reader :options

    def initialize(**kwargs)
      super

      @options = kwargs
      @arg_class = options.delete(:class)
    end

    def classes
      String.new('bg-white shadow shadow-md rounded p-2 md:p-4').tap do |class_str|
        class_str << " #{@arg_class}" if @arg_class.present?
      end
    end
  end
end
