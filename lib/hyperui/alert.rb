# frozen_string_literal: true

module Hyperui
  class Alert < Base
    TYPE_MAP = {
      alert: :warning,
      notice: :info,
      **%i[info success warning danger].index_by(&:itself)
    }.freeze

    erb_template <<~HTML
      <%= content_tag :div, role: "alert", class: component_class, data: component_data, **options do %>
        <div class="flex items-start gap-4">
          <%= content_tag :span, class: inner_classes do %>
            <%= icon %>
          <% end %>

          <div class="flex-1">
            <% if title.present? %>
              <strong class="block font-medium text-gray-900"><%= title %></strong>
            <% end %>

            <div class="mt-1 text-sm text-gray-700 my-auto">
              <%= text_or_content %>
            </div>
          </div>

          <% if dismissable %>
            <button class="text-gray-500 transition hover:text-gray-600" data-action="click-><%= controller_name %>#dismiss">
              <span class="sr-only">Dismiss</span>

              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          <% end %>
        </div>
      <% end %>
    HTML

    attr_reader :text, :type, :title, :dismissable, :options, :component_class, :component_data

    def initialize(text = nil, type: :info, title: nil, dismissable: true, **kwargs)
      @text = text
      @type = TYPE_MAP[type.to_sym]
      raise ArgumentError, "Invalid alert type: #{type}" if @type.nil?

      @title = title
      @dismissable = dismissable
      @options = kwargs
      @component_class = [classes, @options.delete(:class)].tap(&:compact!)
                                                           .join(' ')
      @component_data = data.deep_merge(@options.delete(:data) || {}) do |_key, alert_value, options_value|
        alert_value.is_a?(String) ? "#{alert_value} #{options_value}" : alert_value.merge(options_value)
      end
    end

    def text_or_content
      text.presence || content
    end

    def data
      {
        controller: controller_name,
        action: "mouseover->#{controller_name}#pause mouseout->#{controller_name}#resume",
        "#{controller_name}-dismissable-value": dismissable
      }
    end

    def classes
      'rounded-xl border border-gray-100 bg-white p-4'
    end

    def inner_classes
      case type
      when :info
        'text-blue-600'
      when :success
        'text-green-600'
      when :warning
        'text-yellow-600'
      when :danger
        'text-red-600'
      end
    end

    def icon
      case type
      when :info
        info_icon
      when :success
        success_icon
      when :warning
        warning_icon
      when :danger
        danger_icon
      end
    end

    def info_icon
      <<~SVG.html_safe
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
          <path stroke-linecap="round" stroke-linejoin="round" d="m11.25 11.25.041-.02a.75.75 0 0 1 1.063.852l-.708 2.836a.75.75 0 0 0 1.063.853l.041-.021M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9-3.75h.008v.008H12V8.25Z" />
        </svg>
      SVG
    end

    def warning_icon
      <<~SVG.html_safe
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
          <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9 3.75h.008v.008H12v-.008Z" />
        </svg>
      SVG
    end

    def danger_icon
      <<~SVG.html_safe
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
          <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9 3.75h.008v.008H12v-.008Z" />
        </svg>
      SVG
    end

    def success_icon
      <<~SVG.html_safe
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
          <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
        </svg>
      SVG
    end
  end
end
