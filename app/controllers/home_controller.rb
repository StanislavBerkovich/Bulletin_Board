class HomeController < ApplicationController
  def index
    @adverts = Advert.where(state: :published).order(:id).reverse_order.page(params[:page]).per(5)
  end
end
