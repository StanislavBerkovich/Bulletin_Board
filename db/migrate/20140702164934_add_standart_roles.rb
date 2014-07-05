class AddStandartRoles < ActiveRecord::Migration
  def up
    roles = ['admin', 'user']
    roles.each do |role|
      Role.create name: role
    end
    User.create(email: 'admin@admin.admin', password: "adminadmin", role: Role.admin_role, name: "admin", surname: "admin")
  end
end
