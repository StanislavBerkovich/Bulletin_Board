namespace :my_gens do
  desc "Generator for adverts"
  task adverts: :environment do
    types = ['others', 'cars', 'realty']
    states = [:draft, :new, :rejected, :approved, :published, :archives]
    users = User.where(role_id: Role.user_role.id)
    users.each do |user|
      30.times do
        user.adverts.build(body: Faker::Lorem.paragraph(2), type: Type.find_by(name: types[Random.new.rand(0...types.length)]),
                           state: states[Random.new.rand(0...states.length)]).save
      end
    end
  end

end
