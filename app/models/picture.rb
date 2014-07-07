
class Picture < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "200x200>", :small => "100x100>"}

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :advert

  before_destroy :image_destroy

  def url type
    image.url type
  end


  private

  def image_destroy
    image = nil
    save
  end
end