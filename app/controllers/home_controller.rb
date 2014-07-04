class HomeController < ApplicationController
  def index
    @adverts = Advert.order(:id).page(params[:page]).per(10)

  end
end
