class AdminJobController < ApplicationController
  def nonpublished
    @adverts = Advert.where(state: :new).page(params[:page]).per(10)
  end

  def publish
    advert = Advert.find(params[:advert])
    advert.state = :published
    advert.save
    redirect_to admin_job_nonpublished_path
  end

  def rejected
    advert = Advert.find(params[:advert])
    advert.state = :rejected
    advert.save
    redirect_to admin_job_nonpublished_path
  end
end
