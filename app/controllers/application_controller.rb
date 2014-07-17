class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:alert] = "Invalid id."
    redirect_to root_url
  end

  protect_from_forgery with: :exception

  private

  def get_errors object
    object.errors.full_messages.uniq
  end
end
