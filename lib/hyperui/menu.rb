# frozen_string_literal: true

module Hyperui
  class Menu < Base
    renders_many :items, types: {
      blank: {
        renders: ->(**options) { Hyperui::Menu::BlankItem.new(**options) },
        as: :blank_item
      },
      basic: {
        renders: -> { Hyperui::Menu::BasicItem.new },
        as: :basic_item
      },
      link: {
        renders: ->(path, text, **options) { Hyperui::Menu::LinkItem.new(path, text, **options) },
        as: :link_item
      },
      submenu: {
        renders: ->(*args, **kwargs) { Hyperui::Menu::SubMenu.new(*args, **kwargs) },
        as: :submenu
      }
    }

    erb_template <<~HTML
      <%= content_tag :ul, class: classes, **options do %>
        <% items.each do |item| %>
          <%= item %>
        <% end %>

        <%= content %>
      <% end %>
    HTML

    attr_reader :options

    def initialize(**kwargs)
      super

      @options = kwargs
    end

    def classes
      String.new('space-y-1').tap do |classes_str|
        classes_str << " #{options.delete(:class)}" if options.key?(:class)
      end
    end

    class BlankItem < Base
      erb_template <<~HTML
        <%= content_tag :li, **options do %>
          <%= content %>
        <% end %>
      HTML

      attr_reader :options

      def initialize(**kwargs)
        super

        @options = kwargs
      end

      def active
        options[:active].present?
      end
    end

    class BasicItem < Base
      erb_template <<~HTML
        <%= content_tag :li, class: classes, **options do %>
          <%= content %>
        <% end %>
      HTML

      attr_reader :active, :options

      def initialize(active: false, **kwargs)
        super

        @active = active
        @options = kwargs
      end

      def classes
        String.new('block rounded-lg px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-100').tap do |classes_str|
          classes_str << ' bg-gray-100' if active
          classes_str << " #{options.delete(:class)}" if options.key?(:class)
        end
      end
    end

    class LinkItem < Base
      renders_one :prefix

      erb_template <<~HTML
        <%= content_tag :li, class: classes do %>
          <%= link_to path, class: 'w-full flex', **options do %>
            <%= prefix if prefix? %>

            <span><%= text %></span>

            <%= content %>
          <% end %>
        <% end %>
      HTML

      attr_reader :path, :text, :active, :options

      def initialize(path, text, active: false, **kwargs)
        super

        @path = path
        @text = text
        @active = active
        @options = kwargs
      end

      def classes
        String.new('block rounded-lg px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-100').tap do |classes_str|
          classes_str << ' bg-gray-100' if active
          classes_str << " #{options.delete(:class)}" if options.key?(:class)
        end
      end
    end

    class SubMenu < Base
      renders_one :prefix
      renders_many :items, types: {
        basic: {
          renders: -> { Hyperui::Menu::BasicItem.new },
          as: :basic_item
        },
        link: {
          renders: ->(path, text, **options) { Hyperui::Menu::LinkItem.new(path, text, **options) },
          as: :link_item
        },
        submenu: {
          renders: ->(*args, **kwargs) { Hyperui::Menu::SubMenu.new(*args, **kwargs) },
          as: :submenu
        }
      }

      erb_template <<~HTML
        <%= render Hyperui::Menu::BlankItem.new(**options) do %>
          <details class="group [&_summary::-webkit-details-marker]:hidden" <%= "open" if active_item? %>>
            <summary class="flex cursor-pointer items-center justify-between rounded-lg px-4 py-2 text-gray-700 hover:bg-gray-100 group-open:bg-gray-100">
              <%= prefix if prefix? %>
              <span class="text-sm font-medium"> <%= text %> </span>
              <span class="shrink-0 transition duration-300 group-open:-rotate-180">
                <svg xmlns="http://www.w3.org/2000/svg" class="size-5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"/>
                </svg>
              </span>
            </summary>

            <ul class="mt-2 space-y-1 px-4">
              <% items.each do |item| %>
                <%= item %>
              <% end %>
            </ul>
          </details>
        <% end %>
      HTML

      attr_reader :text, :options

      def initialize(text, **kwargs)
        super

        @text = text
        @options = kwargs
      end

      def active_item?
        items.any? do |item|
          case item.instance_variable_get(:@__vc_component_instance)
          when Hyperui::Menu::BasicItem, Hyperui::Menu::LinkItem, Hyperui::Menu::BlankItem
            item.active
          when Hyperui::Menu::SubMenu
            item.active_item?
          end
        end
      end
    end
  end
end
