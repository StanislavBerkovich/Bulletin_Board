class Advert < ActiveRecord::Base
  validates :body, presence: true, length: {minimum: 1}
  validates :type, presence: true
  validates :user, presence: true
  validates :state, presence: true

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



  def self.destroy_old
    adverts = Advert.where('updated_at <= ?', 6.months.ago)
    adverts.each { |advert| advert.destroy }
  end

  def self.publish_approved
    adverts = Advert.where(state: 'approved')
    adverts.each { |advert| advert.update(state: :published) }
  end

  def self.send_in_archive
    adverts = Advert.where('updated_at <= ? AND state == ?', 3.days.ago, 'published')
    adverts.each { |advert| advert.update(state: :archives) }
  end

end
