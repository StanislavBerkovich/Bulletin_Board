require 'rails_helper'

RSpec.describe Role, :type => :model do
  before(:all) do
    Role.create(name: 'admin')
    Role.create(name: 'user')
    @role = Role.create(name: Faker::Lorem.word)

    @user = User.create email: Faker::Internet.email, password: Faker::Internet.password(8),
                        name: Faker::Name.first_name, surname: Faker::Name.last_name, role: Role.user_role
    @admin = User.new email: Faker::Internet.email, password: Faker::Internet.password(8),
                      name: Faker::Name.first_name, surname: Faker::Name.last_name, role: Role.admin_role
  end

  it 'is invalid wihout name' do
    @role = Role.new(name: nil)
    @role.should_not be_valid
  end

  it 'must be uniqness' do
    @role = Role.new name: 'admin'
    @role.should_not be_valid
  end

  it 'is invalid with empty name' do
    @role = Role.new name: ''
    @role.should_not be_valid
  end

  it 'is must give admin and user role' do
    Role.admin_role.name.should == 'admin'
    Role.user_role.name.should == 'user'
  end

  it 'must give all role names' do
    arr = Role.get_avalible
    arr.length.should == 3
  end

  it 'must give name' do
    @role.to_s.should == @role.name
  end


  after(:all) do
    Role.all.each{|r| r.destroy}
  end
end