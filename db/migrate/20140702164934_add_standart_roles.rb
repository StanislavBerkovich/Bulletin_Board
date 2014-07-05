class AddStandartRoles < ActiveRecord::Migration
  def up
    roles = ['admin', 'user']
    roles.each do |role|
      Role.create name: role
    end
  end
end
