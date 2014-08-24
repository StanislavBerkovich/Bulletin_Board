class AdvertsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  before_filter :authenticate_user!, except: [:show, :index, :personal_locale, :search]
  before_action :set_advert, only: [:show, :edit, :update, :destroy, :approve, :reject, :reject_reason]

  # GET /adverts
  # GET /adverts.json
  def index
    @search = Advert.search(params[:q])
    @adverts = @search.result.includes(:type, :user).where(state: :published).page(params[:page]).per(5)
  end


  # GET /adverts/1
  # GET /adverts/1.json
  def show
  end

  # GET /adverts/new
  def new
    @advert = Advert.create(state: :draft)
    @types = Type.get_for_select
  end

  # GET /adverts/1/edit
  def edit
    @advert.update_attributes(state: :draft)
    @types = Type.get_for_select
  end

  # POST /adverts
  # POST /adverts.json
  def create
    @types = Type.get_for_select
    @advert = Advert.new(advert_params)
    @advert.update_attributes(user: current_user, state: :new)
    respond_to do |format|
      if @advert.save
        format.html { redirect_to @advert, notice: t('.advert_create_successfully') }
        format.json { render :show, status: :created, location: @advert }
      else
        flash[:alert] = get_errors(@advert)
        format.html { render :new }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adverts/1
  # PATCH/PUT /adverts/1.json
  def update
    @types = Type.get_for_select
    @advert.update_attributes(state: :new, reject_reason: nil)
    respond_to do |format|
      if @advert.update(advert_params)
        format.html { redirect_to @advert, notice: 'Advert was successfully updated.' }
        format.json { render :show, status: :ok, location: @advert }
      else
        flash[:alert] = get_errors(@advert)
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
      format.html { redirect_to :back, notice: 'Advert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

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
      format.html { redirect_to nonpublished_adverts_path, notice: 'All new adverts were successfully approved.' }
    end
  end

  def reject
    @advert.update_attribute(:reject_reason, Unicode::downcase(params['advert'][:reject_reason]))
    change_state :rejected
  end

  def search
    unless params[:query].empty?
      @query_text = params[:query]
      @adverts = Advert.full_text_search(params)
    else
      redirect_to :back, alert: I18n.t('adverts.search.empty')
    end

  end

  def personal_locale
    redirect_to root_path(locale: params[:set_locale])
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

  def change_state state
    @advert.update_attribute(:state, state)
    respond_to do |format|
      if @advert.save
        AdvertsMailer.advert_change_state(@advert, state).deliver
        format.html { redirect_to nonpublished_adverts_path, notice: "Advert was successfully #{state}." }
      else
        format.html { redirect_to nonpublished_adverts_path, alert: 'Something went wrong!' }
      end
    end
  end

end
