class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name, null: false
      t.timestamps
    end

    change_table :adverts do |t|
      t.belongs_to :type
    end
  end
end
