# frozen_string_literal: true

module Hyperui
  module Form
    class Select < Base
      erb_template <<~HTML
        <%= select_tag name, options_for_select(choices, selected:), **opts %>
      HTML

      attr_reader :name, :choices, :options, :selected, :html_options

      def initialize(name, choices = [], options = {}, html_options = {})
        super

        @name = name
        @choices = choices
        @options = options
        @html_options = html_options
        @selected = options.delete(:selected)
      end

      def opts
        @options.merge(@html_options).tap do |opts|
          opts[:class] = "#{opts[:class]} rounded-md border-gray-200 text-gray-700 sm:text-sm"
        end
      end
    end
  end
end
