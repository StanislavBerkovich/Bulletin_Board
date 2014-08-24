class AdminJobController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_advert, only: [:approve, :rejected, :reject_reason]


  def nonpublished
    @adverts = Advert.get_nonpublished_for_page params[:page]
  end

  def approve
    change_state :approved
  end


  def reject_reason
  end

  def approve_all
    @adverts = Advert.get_nonpublished
    @adverts.each do |advert|
      advert.update(state: :approved)
      AdvertsMailer.advert_change_state(advert, :approved).deliver
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: 'All new adverts were successfully approved.' }
    end
  end

  def rejected
    @advert.update_attribute(:reject_reason, Unicode::downcase(params['advert'][:reject_reason]))
    change_state :rejected
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

  def change_state state
    @advert.update_attribute(:state, state)
    respond_to do |format|
      if @advert.save
        AdvertsMailer.advert_change_state(@advert, state).deliver
        format.html { redirect_to admin_job_nonpublished_path, notice: "Advert was successfully #{state}." }
      else
        format.html { redirect_to admin_job_nonpublished_path, alert: 'Something went wrong!' }
      end
    end
  end

end
