module PersonsHelper
  def full_name user
    "#{user.name.capitalize} #{user.surname.capitalize}"
  end
end