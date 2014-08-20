# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[User.all, Role.all, Type.all].flatten.each do |i|
  i.destroy!
end


roles = ['admin', 'user']
roles.each do |role|
  Role.create name: role
end
types = ['others', 'cars', 'realty']
states = [:draft, :new, :rejected, :approved, :published, :archives]
types.each do |t|
  Type.create name: t
end

admin = User.create(email: 'admin@admin.admin', password: "adminadmin",
                    role: Role.admin_role, name: "admin", surname: "admin");
users_registration_data = [
    {login: 'stanislav.berkovich@gmail.com', password: '11111111'},
    {login: 'syper0708@mail.ru', password: '12345678'},
    {login: 'sun@tut.by', password: 'suniscool'},
    {login: 'sasha@gmail.com', password: '12345678'}
]

users = []

users_registration_data.each do |user|
  users << User.create(email: user[:login], password: user[:password],
                       role: Role.user_role, name: Faker::Name.first_name, surname: Faker::Name.last_name)
  10.times do
    users.last.adverts.build(body: Faker::Lorem.paragraph(2), type: Type.find_by(name: types[Random.new.rand(0...types.length)]),
                             state: states[Random.new.rand(0...states.length)]).save
  end
end

