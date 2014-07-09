require 'rails_helper'

RSpec.describe Type, :type => :model do
  before(:all) do
    Type.create(name: 'cars')
    Type.create(name: 'realty')
    @type = Role.create(name: Faker::Lorem.word)
  end

  it 'is invalid wihout name' do
    type = Type.new(name: nil)
    type.should_not be_valid
  end

  it 'must be uniqness' do
    type = Type.new name: 'cars'
    type.should_not be_valid
  end

  it 'is invalid with empty name' do
    type = Type.new name: ''
    type.should_not be_valid
  end

  it 'must give name' do
    @type.to_s.should == @type.name
  end


  after(:all) do
    Role.all.each { |r| r.destroy }
  end
end
