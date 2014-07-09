require 'rails_helper'

RSpec.describe Advert, :type => :model do
  before(:each) do
    @type = Type.create name: Faker::Lorem.word
    @user = User.create email: Faker::Internet.email, password: Faker::Internet.password(8),
                        name: Faker::Name.first_name, surname: Faker::Name.last_name, role: Role.user_role
    @advert = Advert.new(body: Faker::Lorem.sentence(10), user: @user, type: @type, state: :new)
    @other_advert = Advert.new(body: Faker::Lorem.sentence(10), user: @user, type: @type, state: :new)
  end

  it 'should be valid' do
    @advert.should be_valid
  end

  it 'invalid without body' do
    @advert.body = nil
    @advert.should_not be_valid
  end

  it 'invalid with empty body' do
    @advert.body = ''
    @advert.should_not be_valid
  end

  it 'invalid without type' do
    @advert.type = nil
    @advert.should_not be_valid
  end

  it 'invalid without user' do
    @advert.user = nil
    @advert.should_not be_valid
  end

  it 'invalid without state' do
    @advert.state = nil
    @advert.should_not be_valid
  end

  it 'should determine state' do
    @advert.state_is?(:new).should == true
    @advert.state_is?(:approved).should == false
  end

  it 'should count adverts of any author' do
    Advert.count_of(@user).should == 0
    @advert.save!
    Advert.count_of(@user).should == 1
    @other_advert.save!
    Advert.count_of(@user).should == 2
  end

  it 'should destroy old adverts' do
    @advert.updated_at = 7.months.ago
    @other_advert.updated_at = 5.months.ago
    @other_advert.save!
    @advert.save!
    Advert.find(@advert.id).should == @advert
    Advert.destroy_old
    lambda { @advert.reload }.should raise_error(ActiveRecord::RecordNotFound)
    @other_advert.reload.should == @other_advert
  end

  it 'should publish all approved adverts' do
    @advert.state = :approved
    @advert.save!
    @other_advert.save!
    other_advert_state = @other_advert.state
    Advert.publish_approved
    @advert.reload.state_is?('published').should == true
    @other_advert.reload.state_is?(other_advert_state).should == true
  end

  it 'should send in archive long time published adverts' do
    @advert.updated_at = 4.days.ago
    @advert.state = :published
    @other_advert.state = :published
    @other_advert.updated_at = 2.days.ago
    @advert.save!
    @other_advert.save!
    Advert.send_in_archive
    @advert.reload.state_is?(:archives).should == true
    @other_advert.reload.state_is?(:published).should == true
  end

  after(:each) do
    @advert.destroy
    @user.destroy
    @type.destroy
  end

end
