class AdminJobController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_advert, only: [:approve, :rejected, :reject_reason]




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
