class HomeController < ApplicationController
  def index
    @adverts = Advert.where(state: :published).order(:id).page(params[:page]).per(10)
  end
end
