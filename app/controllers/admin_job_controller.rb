class AdminJobController < ApplicationController
  before_filter :authenticate_user!


  rescue_from SQLite3::ConstraintException do |exception|
    flash[:error] = "Access denied."
    redirect_to :back
  end

  def nonpublished
    @adverts = Advert.where(state: :new).page(params[:page]).per(5)
  end

  def approve
    advert = Advert.find(params[:advert])
    advert.state = :approved
    advert.save
    redirect_to :back
  end

  def rejected
    advert = Advert.find(params[:advert])
    advert.state = :rejected
    advert.save
    redirect_to :back
  end

  def manage_advert_type
    @type = Type.new
    @types = Type.all.sort_by { |t| t.name }
  end

  def create_type
    Type.new(params.require('type').permit(:name)).save
    redirect_to :root
  end

  def delete_type
    @type = Type.find(params[:id])
    @type.destroy
    redirect_to :back
  end

end
