class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # TODO FIXME I can not find how to skip this when test
  before_action :authenticate_user! unless Rails.env.test?
end
