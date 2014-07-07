class AdminJobController < ApplicationController
  before_filter :authenticate_user!

  def nonpublished
    @adverts = Advert.where(state: :new).page(params[:page]).per(5)
  end

  def publish
    advert = Advert.find(params[:advert])
    advert.state = :published
    advert.save
    redirect_to :back
  end

  def rejected
    advert = Advert.find(params[:advert])
    advert.state = :rejected
    advert.save
    redirect_to :back
  end

  def new_advert_type
    @type = Type.new
  end

  def create_type
    Type.create(params.require('type').permit(:name))
    redirect_to :root
  end

end
