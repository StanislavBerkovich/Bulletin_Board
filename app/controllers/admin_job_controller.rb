class AdminJobController < ApplicationController
  def nonpublished
    @adverts = Advert.where(state: :new).page(params[:page]).per(10)
  end
end
