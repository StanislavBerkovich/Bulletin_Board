class AdvertsController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :index]
  before_action :set_advert, only: [:show, :edit, :update, :destroy]

  # GET /adverts
  # GET /adverts.json
  def index
    @adverts = Advert.reverse_order.order(:id).page(params[:page]).per(5)
  end

  # GET /adverts/1
  # GET /adverts/1.json
  def show
  end

  # GET /adverts/new
  def new
    @advert = Advert.new
    @advert.state = :draft
    @types = Type.pluck(:name).sort
  end

  # GET /adverts/1/edit
  def edit
    @types = [@advert.type.name]
    @types << Type.pluck(:name)
    @types.flatten!.sort!.uniq!
  end

  # POST /adverts
  # POST /adverts.json
  def create
    params[:rrt]
    @advert = Advert.new(advert_params)
    @advert.user = current_user
    @advert.state = :new
    respond_to do |format|
      if @advert.save

        format.html { redirect_to @advert, notice: 'Advert was successfully created.' }
        format.json { render :show, status: :created, location: @advert }
      else
        format.html { render :new }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adverts/1
  # PATCH/PUT /adverts/1.json
  def update
    respond_to do |format|
      if @advert.update(advert_params)
        format.html { redirect_to @advert, notice: 'Advert was successfully updated.' }
        format.json { render :show, status: :ok, location: @advert }
      else
        format.html { render :edit }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adverts/1
  # DELETE /adverts/1.json
  def destroy
    @advert.destroy
    respond_to do |format|
      format.html { redirect_to adverts_url, notice: 'Advert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_advert
    @advert = Advert.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def advert_params
    p = params.require(:advert).permit(:body, pictures_attributes: [:image])
    p[:type] = Type.find_by(name: params[:advert][:type])
    p
  end
end
