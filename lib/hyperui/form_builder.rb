# frozen_string_literal: true

module Hyperui
  class FormBuilder < ActionView::Helpers::FormBuilder
    def button(value = nil, options = {}, &block)
      @template.render Form::Submit.new(value, **options, &block)
    end

    def select(method, choices = nil, options = {}, html_options = {}, &block)
      options.merge!(selected: options[:selected].presence || object.try(method))

      @template.render Form::Select.new(generate_name(method), choices, options, html_options, &block)
    end

    def submit(value = nil, options = {})
      button(value.presence || 'Submit', **options)
    end

    def label(method, content_or_options = nil, options = {}, &block)
      opts = content_or_options.is_a?(Hash) ? content_or_options : options
      content = content_or_options.is_a?(String) ? content_or_options : method.to_s.humanize

      @template.render Form::Label.new(generate_name(method), content, **opts, &block)
    end

    def email_field(method, options = {})
      @template.render Form::Input.new(generate_name(method), object.try(method).presence, type: 'email',
                                                                                           **options) do |input|
        yield input if block_given?
      end
    end

    def password_field(method, options = {})
      @template.render Form::Input.new(generate_name(method), object.try(method).presence, type: 'password',
                                                                                           **options) do |input|
        yield input if block_given?
      end
    end

    def date_field(method, options = {})
      @template.render Form::Input.new(generate_name(method), object.try(method).presence, type: 'date',
                                                                                           **options) do |input|
        yield input if block_given?
      end
    end

    def number_field(method, options = {}, &block)
      @template.render Form::Input.new(generate_name(method), object.try(method).presence, type: 'number', **options,
                                       &block)
    end

    def text_field(method, options = {}, &block)
      @template.render Form::Input.new(generate_name(method), object.try(method).presence, type: 'text', **options,
                                       &block)
    end

    def field_with_icon(method, options = {}, &block)
      @template.render Form::Input.new(method, **options) do |input_component|
        input_component.with_icon(&block)
      end
    end

    def field_with_button(method, options = {}, &block)
      @template.render Form::Input.new(method, **options) do |input_component|
        input_component.with_button(&block)
      end
    end

    private

    def generate_name(method)
      return object_name + "[#{method}]" if object_name.present?

      method
    end
  end
end
