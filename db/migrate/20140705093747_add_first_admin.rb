class AddFirstAdmin < ActiveRecord::Migration
  def up
    User.create(email: 'admin@admin.admin', password: "adminadmin", role: Role.admin_role, name:"admin", surname:"admin")
  end
end
