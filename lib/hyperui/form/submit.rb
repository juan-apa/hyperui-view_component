# frozen_string_literal: true

module Hyperui
  module Form
    class Submit < Base
      attr_reader :value, :size, :variant, :options

      erb_template <<~HTML
        <%= submit_tag value, class: classes, **options %>
      HTML

      def initialize(value, size: :md, variant: :solid, **kwargs)
        @value = value
        @size = size.to_sym
        @variant = variant.to_sym
        @options = kwargs
      end

      def classes
        String.new('flex rounded border').tap do |class_str|
          class_str << " #{size_classes}"
          class_str << " #{variant_classes}"
          class_str << " #{options.delete(:class)}" if options.key?(:class)
        end
      end

      def size_classes
        case size
        when :xs
          'px-2 py-1 text-xs'
        when :sm
          'px-4 py-2 text-sm'
        when :md
          'px-12 py-3 text-sm'
        when :lg
          'px-16 py-4 text-lg'
        end
      end

      def variant_classes
        case variant
        when :solid
          'border-indigo-600 bg-indigo-600 text-white hover:bg-transparent hover:text-indigo-600 focus:outline-none focus:ring active:text-indigo-500'
        when :outline
          'border-indigo-600 text-indigo-600 hover:bg-indigo-600 hover:text-white focus:outline-none focus:ring active:bg-indigo-500'
        end
      end
    end
  end
end
