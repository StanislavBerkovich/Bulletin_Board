class AddStateInAdvert < ActiveRecord::Migration
  def change
    change_table :adverts do |t|
      t.string :state, null:false
    end

  end
end
