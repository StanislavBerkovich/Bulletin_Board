class PersonsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_person, only: [:edit, :profile, :save_changes, :delete]

  def profile
    @adverts_count = Advert.count_of @person
    @adverts = @person.adverts.reverse_order.order(:id).page(params[:page]).per(5)
  end

  def edit

  end

  def save_changes
    if @person.update person_params
      redirect_to persons_profile_path id: @person
    else
      redirect_to :back
    end
  end

  def delete
    @person.destroy
    redirect_to root_path
  end

  def new
    @person = User.new
  end

  def index
    @persons = User.order(:id).page(params[:page]).per(10) - [current_user]
  end


  private

  def set_person
    if params.include? :id
      @person = User.find(params[:id])
    else
      @person = User.new
    end
  end


  def person_params
    p = params.require('user').permit(:email, :name, :surname)
    if params[:user][:password] != ''
      p[:password], p[:password_confirmation] = params[:user][:password], params[:user][:password_confirmation]
    end
    p[:role] = Role.find_by(name: params[:user][:role]) if params[:user].has_key? :role
    p
  end

end
