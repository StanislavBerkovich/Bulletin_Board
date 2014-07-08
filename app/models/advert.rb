class Advert < ActiveRecord::Base
  validate :body, presence: true
  extend Enumerize
  belongs_to :user
  belongs_to :type
  has_many :pictures, dependent: :destroy

  enumerize :state, in: [:draft, :new, :rejected, :approved, :published, :archives]
  accepts_nested_attributes_for :pictures, :allow_destroy => true
  accepts_nested_attributes_for :type


  def state_is? require_state
    state == require_state.to_s
  end

  def self.count_of author
    Advert.where(user: author).count
  end


  #For cron

  def self.publish_approved
    adverts = Advert.where(state: 'approved')
    adverts.each { |advert| advert.update(state: :published) }
  end

  def self.send_in_archive
    adverts = Advert.where('updated_at <= ?', 3.days.ago)
    adverts.each { |advert| advert.update(state: :archives) }
  end


end
