class HomeController < ApplicationController
  def index
    @adverts = Advert.order(:id).page params[:page]

  end
end
