class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.belongs_to :user

      t.text :body

      t.timestamps
    end
  end
end
