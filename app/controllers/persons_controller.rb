class PersonsController < ApplicationController
  before_action :set_person, only: [:edit, :profile, :save_changes]

  def profile

  end

  def edit

  end

  def save_changes
    input_params = person_params
    @person.name = input_params[:name].downcase || @person.name
    @person.surname = input_params[:surname].downcase || @person.surname
    @person.email = input_params[:email] || @person.email
    @person.role = Role.find_by(name: input_params[:role]) || @person.role
    @person.password = input_params[:password] || @person.password
    @person.save
    redirect_to persons_profile_path id: @person
  end

  private

  def set_person
    @person = User.find(params[:id])

  end

  def person_params
    p = params.require('user').permit(:email, :name, :surname, :password, :role)
  end

end
