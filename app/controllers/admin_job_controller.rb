class AdminJobController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_advert, only: [:approve, :rejected, :reject_reason]

  rescue_from SQLite3::ConstraintException do |exception|
    flash[:error] = "Access denied."
    redirect_to :back
  end

  def nonpublished
    @adverts = Advert.where(state: :new).page(params[:page]).per(5)
  end

  def approve
    @advert.state = :approved
    respond_to do |format|
      if @advert.save
        format.html { redirect_to :back, notice: 'Advert was successfully updated.' }
      else
        format.html { redirect_to :back, error: 'Something went wrong!' }
      end
    end
  end

  def reject_reason
  end

  def approve_all
    @adverts = Advert.where(state: :new)
    @adverts.each { |advert| advert.update(state: :approved) }
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Advert was successfully updated.' }
    end
  end

  def rejected
    @advert.state = :rejected
    @advert.reject_reason = "because #{params['advert'][:reject_reason].downcase}"
    respond_to do |format|
      if @advert.save
        format.html { redirect_to admin_job_nonpublished_path, notice: 'Advert was successfully updated.' }
      else
        format.html { redirect_to admin_job_nonpublished_path, error: 'Something went wrong!' }
      end
    end
  end

  def manage_advert_type
    @type = Type.new
    @types = Type.all.sort_by { |t| t.name }
  end

  def create_type
    Type.new(params.require('type').permit(:name)).save
    if Type.new(params.require('type').permit(:name)).save
      format.html { redirect_to :back, notice: 'Type was successfully created.' }
    else
      format.html { redirect_to :back, error: 'Something went wrong!' }
    end
  end

  def delete_type
    @type = Type.find(params[:id])
    @type.destroy
    redirect_to :back
  end

  private

  def set_advert
    @advert = Advert.find(params[:id])
  end


end
