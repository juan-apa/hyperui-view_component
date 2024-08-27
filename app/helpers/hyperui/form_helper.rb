# frozen_string_literal: true

module Hyperui
  module FormHelper
    def hyper_form_with(**kwargs, &block)
      form_with(**kwargs.merge(builder: ::Hyperui::FormBuilder), &block)
    end

    def hyper_form_for(record, **kwargs, &block)
      form_for(record, **kwargs.merge(builder: ::Hyperui::FormBuilder), &block)
    end

    def hyper_form_tag(url_for_options = {}, **kwargs, &block)
      form_tag(url_for_options, **kwargs.merge(builder: ::Hyperui::FormBuilder), &block)
    end
  end
end
