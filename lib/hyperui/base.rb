# frozen_string_literal: true

module Hyperui
  class Base < ViewComponent::Base
    def self.primary_abstract_component?
      name == 'Hyperui::Base'
    end

    def self.controller_name
      if superclass.try(:primary_abstract_component?)
        name.underscore.dasherize.gsub('/', '--')
      else
        superclass.controller_name
      end
    end

    def controller_name
      self.class.controller_name
    end

    def data = {}

    def classes = +''
  end
end
