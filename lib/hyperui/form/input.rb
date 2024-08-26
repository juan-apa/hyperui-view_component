# frozen_string_literal: true

module Hyperui
  module Form
    class Input < Base
      renders_one :icon
      renders_one :button

      erb_template <<~HTML
        <%= content_tag :div, class: wrapper_classes, **wrapper_options do %>
          <%= content %>

          <%= content_tag :input, nil, name: name, value: value, type: type, **input_options %>

          <% if icon? %>
            <span class="pointer-events-none text-gray-500 absolute inset-y-0 end-0 grid w-10 place-content-center">
              <%= icon %>
            </span>
          <% end %>

          <% if button? %>
            <span class="absolute inset-y-0 end-0 grid w-10 place-content-center">
              <%= button %>
            </span>
          <% end %>
        <% end %>

      HTML

      attr_reader :name, :value, :options, :type, :wrapper_options

      def initialize(name, value = nil, type: 'text', **kwargs)
        @options = kwargs.except(:type, :name, :value)
        @wrapper_options = @options.delete(:wrapper_options) || {}
        @name = name
        @value = value
        @type = type
      end

      def wrapper_classes
        classes = [wrapper_options.delete(:class)]
        classes << 'relative' if icon? || button?
        classes.compact.join(' ')
      end

      def input_options
        options.except(:wrapper_options).tap do |opts|
          opts[:class] ||= +''
          opts[:class] += ' w-full rounded-md border-gray-200 shadow-sm sm:text-sm disabled:bg-slate-50'
          opts[:class] += ' pe-10' if icon?
        end
      end
    end
  end
end
