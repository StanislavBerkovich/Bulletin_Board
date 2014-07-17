require 'rails_helper'

RSpec.describe User, :type => :model do

  before(:each) do
    Role.create(name: 'admin')
    Role.create(name: 'user')
    @user = User.new email: Faker::Internet.email, password: Faker::Internet.password(8),
                     name: Faker::Name.first_name, surname: Faker::Name.last_name, role: Role.user_role
    @user_copy = User.new email: @user.email, password: @user.password,
                          name: @user.name, surname: @user.surname, role: @user.role
    @admin = User.new email: Faker::Internet.email, password: Faker::Internet.password(8),
                      name: Faker::Name.first_name, surname: Faker::Name.last_name, role: Role.admin_role
  end


  it 'admin and user should be valid' do
    @user.should be_valid
    @admin.should be_valid
  end

  it "can't add equals users" do
    @user.save
    @user_copy.save.should == false
  end

  it 'is invalid without email' do
    @user.email = nil
    @user.should_not be_valid
  end

  it 'is invalid without name' do
    @user.name = nil
    @user.should_not be_valid
  end

  it 'is invalid without surname' do
    @user.surname = nil
    @user.should_not be_valid
  end

  it 'should determine roles' do
    @user.is?(Role.user_role).should == true
    @admin.is?(Role.admin_role).should == true
    @user.is?(Role.admin_role).should == false
    @admin.is?(Role.user_role).should == false
  end

  it 'should add role' do
    @user.role=Role.admin_role
    @user.role.should == Role.admin_role
  end


  after(:each) do
    @user.destroy
    @user_copy.destroy
    @admin.destroy
    Role.all.each do |r|
      r.destroy
    end
  end

end
