class Advert < ActiveRecord::Base
  validate :body, presence: true
  extend Enumerize
  belongs_to :user
  belongs_to :type

  enumerize :state, in: [:draft, :new, :rejected, :approved ,:published, :archives]


  def self.send_in_archive
    5.times {puts "%%%%%%%%%%%%%%%%%%%%%"}
    adverts = Advert.where ['updated_at >= ?', 1.minute.ago]
    adverts.each { |advert| advert.state = :archives }
  end
end
