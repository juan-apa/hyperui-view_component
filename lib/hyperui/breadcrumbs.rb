# frozen_string_literal: true

module Hyperui
  class Breadcrumbs < Base
    renders_many :items, 'Hyperui::Breadcrumbs::Item'

    erb_template <<~HTML
      <%= content_tag :nav, 'aria-label': 'Breadcrumb', **options do %>
        <ol class="flex items-center gap-1 text-sm text-gray-600 h-full">
          <li>
            <a href="<%= home_path %>" class="block transition hover:text-gray-700 rounded-lg hover:bg-gray-100 p-2">
              <span class="sr-only">Home</span>

              <svg xmlns="http://www.w3.org/2000/svg" class="size-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
              </svg>
            </a>
          </li>

          <% items.each do |item| %>
            <%= item %>
          <% end %>
        </ol>
      <% end %>
    HTML

    attr_reader :home_path, :options

    def initialize(home_path:, **kwargs)
      @home_path = home_path
      @options = kwargs
    end

    class Item < Base
      erb_template <<~HTML
        <li>
          <svg xmlns="http://www.w3.org/2000/svg" class="size-4" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"/>
          </svg>
        </li>
        <%= content_tag :li, class: classes do %>
          <%= content %>

          <% if path? %>
            <%= link_to label, path, class: 'block transition hover:text-gray-700', **options %>
          <% else %>
            <span><%= label %></span>
          <% end %>
        <% end %>
      HTML

      attr_reader :label, :path, :active, :options

      def initialize(label:, path: nil, active: false, **kwargs)
        @label = label
        @path = path
        @active = active
        @options = kwargs
      end

      def active?
        active
      end

      def path?
        path.present?
      end

      def classes
        component_classes = [].tap do |classes|
          classes << 'p-2'
          classes << 'rounded-lg hover:bg-gray-100' if path?
          classes << 'font-semibold' if active?
          classes << options.delete(:class)
        end
        component_classes.tap(&:compact!).join(' ')
      end
    end
  end
end
