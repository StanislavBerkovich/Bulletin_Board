class Advert < ActiveRecord::Base extends Enumerize
  belongs_to :user

  enumerize :state, in: [:draft, :rejected, :approved ,:published, :archives]


end
