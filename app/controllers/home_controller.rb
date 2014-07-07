class HomeController < ApplicationController
  def index
    @adverts = Advert.where(state: :published).reverse_order.order(:id).page(params[:page]).per(5)
  end
end
