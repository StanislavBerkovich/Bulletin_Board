class DefaultTypes < ActiveRecord::Migration
  def change
    ['others', 'cars', 'realty'].each do |t|
      Type.create name: t
    end

  end
end
