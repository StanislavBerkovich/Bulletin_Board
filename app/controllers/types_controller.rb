class TypesController < ApplicationController
  # GET /types
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  before_filter :authenticate_user!

  def index
    @type = Type.new
    @types = Type.all.sort_by { |t| t.name }
  end

  def create
    type = Type.new(params.require('type').permit(:name))
    if type.save
      redirect_to :back, notice: "Type '#{type.name}' successfully created"
    else
      redirect_to :back, alert: get_errors(type)
    end
  end

  def destroy
    @type = Type.find(params[:id])
    if @type.adverts.empty?
      @type.destroy
      redirect_to :back, notice: "Type '#{@type.name}' was successfully deleted"
    else
      redirect_to :back, alert: "Type '#{@type.name}' wasn't deleted, because it has adverts"
    end
  end

end
