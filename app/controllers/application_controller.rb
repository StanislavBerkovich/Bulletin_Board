class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_i18n_locale_from_params

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = I18n.t "views.access_denied."
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:alert] = "Invalid id."
    redirect_to root_url
  end

  protect_from_forgery with: :exception


  def default_url_options
    {locale: I18n.locale}
  end

  private

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def get_errors object
    object.errors.full_messages.uniq
  end
end
