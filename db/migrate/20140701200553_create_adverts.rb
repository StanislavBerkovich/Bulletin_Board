class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.belongs_to :user

      t.string :body

      t.timestamps
    end
  end
end
