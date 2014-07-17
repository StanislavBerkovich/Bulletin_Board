class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      redirect_to new_user_session_path, notice: "Welcome! You successfully sign up. Now you can enter by your email and password"
    else
      redirect_to new_user_registration_path, alert: get_errors(@user)
    end
  end

  def update
    super
  end

  private


  def sign_up_params
    p = downcase_params params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
    p[:role] = Role.find_by(name: params[:role]) || Role.user_role
    p
  end

  def downcase_params(p)
    p.each do |key, v|
      if v.respond_to? :downcase
        p[key] = v.downcase
      end
    end
    p
  end

end