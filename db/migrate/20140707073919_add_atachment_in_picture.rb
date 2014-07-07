class AddAtachmentInPicture < ActiveRecord::Migration
  def self.up
    add_attachment :pictures, :image
  end
end
