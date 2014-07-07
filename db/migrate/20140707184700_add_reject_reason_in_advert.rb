class AddRejectReasonInAdvert < ActiveRecord::Migration
  def change
    change_table :adverts do |t|
      t.string :reject_reason
    end
  end
end
