class AdminJobController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_advert, only: [:approve, :rejected, :reject_reason]


  def nonpublished
    @adverts = Advert.where(state: :new).page(params[:page]).per(5)
  end

  def approve
    @advert.state = :approved
    respond_to do |format|
      if @advert.save
        AdvertsMailer.advert_approve_email(@advert).deliver

        format.html { redirect_to :back, notice: 'Advert was successfully approved.' }
      else
        format.html { redirect_to :back, alert: 'Something went wrong!' }
      end
    end
  end

  def reject_reason
  end

  def approve_all
    @adverts = Advert.where(state: :new)
    @adverts.each do    |advert|
      advert.update(state: :approved)
      AdvertsMailer.advert_approve_email(@advert).deliver
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: 'All new adverts were successfully approved.' }
    end
  end

  def rejected
    @advert.state = :rejected
    @advert.reject_reason = "because #{params['advert'][:reject_reason].downcase}"
    respond_to do |format|
      if @advert.save
        AdvertsMailer.advert_reject_email(@advert).deliver
        format.html { redirect_to admin_job_nonpublished_path, notice: 'Advert was successfully rejected.' }
      else
        format.html { redirect_to admin_job_nonpublished_path, alert: 'Something went wrong!' }
      end
    end
  end

  def manage_advert_type
    @type = Type.new
    @types = Type.all.sort_by { |t| t.name }
  end

  def create_type
    type = Type.new(params.require('type').permit(:name))
    if type.save
      redirect_to :back, notice: "Type '#{type.name}' successfully created"
    else
      redirect_to :back, alert: get_errors(type)
    end
  end

  def delete_type
    @type = Type.find(params[:id])
    if @type.adverts.empty?
      @type.destroy
      redirect_to :back, notice: "Type '#{@type.name}' was successfully deleted"
    else
      redirect_to :root_path, alert: "Type '#{@type.name}' wasn't deleted"
    end
  end

  private

  def set_advert
    @advert = Advert.find(params[:id])
  end


end
