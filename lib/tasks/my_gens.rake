namespace :my_gens do
  desc "Generator for adverts"
  task :adverts, [:count] => :environment do |task, args|
    count = args[:count].to_i
    count = 10 unless args.has_key?(:count)
    types = ['others', 'cars', 'realty']
    states = [:draft, :new, :rejected, :approved, :published, :archives]
    users = User.where(role_id: Role.user_role.id)
    users.each do |user|
      count.times do
        user.adverts.build(body: Faker::Lorem.paragraph(2), type: Type.find_by(name: types[Random.new.rand(0...types.length)]),
                           state: states[Random.new.rand(0...states.length)]).save
      end
    end
  end

  desc "Delete all adverts"
  task :delete_adverts => :environment do
    Advert.all.each do |a|
      a.destroy
    end
  end

end
