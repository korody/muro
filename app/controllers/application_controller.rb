class ApplicationController < ActionController::Base
  include SessionsHelper
  add_flash_types :error, :success, :info, :warning
  protect_from_forgery with: :exception
end
