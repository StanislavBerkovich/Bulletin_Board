module PersonsHelper
  def full_name user
    begin
      "#{user.name.capitalize} #{user.surname.capitalize}"
    rescue => e
      ''
    end
  end
end
