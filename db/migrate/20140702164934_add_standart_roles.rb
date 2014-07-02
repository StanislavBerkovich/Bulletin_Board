class AddStandartRoles < ActiveRecord::Migration
  def up
    roles = ['admin', 'user', 'guest']
    roles.each do |role|
      Role.create name: role
    end
  end
end
