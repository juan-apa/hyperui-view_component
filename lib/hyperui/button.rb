# frozen_string_literal: true

module Hyperui
  class Button < Base
    erb_template <<~HTML
      <%= content_tag tag, class: classes, **options do %>
        <%= text.presence || content %>
      <% end %>
    HTML

    attr_reader :text, :tag, :size, :type, :path, :options

    def initialize(text_or_path = nil, text = nil, tag: :a, size: :md, type: :solid, **kwargs)
      super

      @text = text
      @tag = tag.to_sym
      @size = size.to_sym
      @type = type.to_sym
      @path = text_or_path
      @options = kwargs.tap do |opts|
        opts[:href] = path if tag == :a
        opts[:type] = 'button' if tag == :button
      end
    end

    def classes
      String.new('rounded border text-center').tap do |class_str|
        class_str << " #{size_classes}"
        class_str << " #{type_classes}"
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

    def type_classes
      case type
      when :solid
        'border-indigo-600 bg-indigo-600 text-white hover:bg-transparent hover:text-indigo-600 focus:outline-none focus:ring active:text-indigo-500'
      when :outline
        'border-indigo-600 text-indigo-600 hover:bg-indigo-600 hover:text-white focus:outline-none focus:ring active:bg-indigo-500'
      end
    end
  end
end
