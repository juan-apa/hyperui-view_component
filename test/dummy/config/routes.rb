# frozen_string_literal: true

Rails.application.routes.draw do
  mount Hyperui::Engine => '/hyperui'
end
