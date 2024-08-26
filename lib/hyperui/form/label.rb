# frozen_string_literal: true

module Hyperui
  module Form
    class Label < Base
      erb_template <<~HTML
        <%= label_tag name, nil, class: "block text-xs font-medium text-gray-700 \#{label_class}", **options do %>
          <%= text.presence || content.presence || name.humanize %>
        <% end %>
      HTML

      attr_reader :name, :text, :options, :label_class

      def initialize(name, text = nil, **kwargs)
        super

        @name = name
        @text = text
        @options = kwargs
        @label_class = @options.delete(:class)
      end

      def text_or_name
        text.presence || name.humanize
      end
    end
  end
end
