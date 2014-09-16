class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @yaml = YAML.load_file("#{Rails.root}/app/models/concerns/default.yml")
  end
end
