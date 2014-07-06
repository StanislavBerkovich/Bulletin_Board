class Advert < ActiveRecord::Base
  validate :body, presence: true
  extend Enumerize
  belongs_to :user
  belongs_to :type

  enumerize :state, in: [:draft, :new, :rejected, :approved, :published, :archives]


  def self.send_in_archive
    5.times { puts "%%%%%%%%%%%%%%%%%%%%%" }
    adverts = Advert.all
    adverts.each { |advert|
      advert.body += "+"
      advert.save
    }
  end

  def self.count_of author
    Advert.where(user: author).count
  end

  def state_is? require_state
    state == require_state.to_s
  end
end
