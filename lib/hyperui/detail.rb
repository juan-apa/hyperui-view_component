# frozen_string_literal: true

module Hyperui
  class Detail < Base
    renders_many :items, 'Hyperui::Detail::Item'

    erb_template <<~HTML
      <% if title? %>
        <%= content_tag :div, class: classes, **options do %>
          <%= content_tag :h3, title, class: 'text-lg font-medium text-gray-900' %>
            <dl class="-my-3 divide-y divide-gray-100 text-sm">
              <% items.each do |item| %>
                <%= item %>
              <% end %>
            </dl>
        <% end %>
      <% else %>
        <%= content_tag :div, class: classes, **options do %>
          <dl class="-my-3 divide-y divide-gray-100 text-sm">
            <% items.each do |item| %>
              <%= item %>
            <% end %>
          </dl>
        <% end %>
      <% end %>
    HTML

    attr_reader :title, :options

    def initialize(title = nil, **kwargs)
      super

      @title = title
      @options = kwargs
    end

    def classes
      String.new('flow-root py-3').tap do |classes_str|
        classes_str << " #{options.delete(:class)}" if options.key?(:class)
      end
    end

    def title?
      title.present?
    end

    class Item < Base
      erb_template <<~HTML
        <%= content_tag :div, class: classes, **options do %>
          <dt class="font-medium text-gray-900"><%= label %></dt>
          <dd class="text-gray-700 sm:col-span-2"><%= text.presence || content %></dd>
        <% end %>
      HTML

      attr_reader :label, :text, :options

      def initialize(label, text = nil, **kwargs)
        super

        @label = label
        @text = text
        @options = kwargs
      end

      def classes
        String.new('grid grid-cols-1 gap-1 p-3 sm:grid-cols-3 sm:gap-4').tap do |classes_str|
          classes_str << " #{options.delete(:class)}" if options.key?(:class)
        end
      end
    end
  end
end
