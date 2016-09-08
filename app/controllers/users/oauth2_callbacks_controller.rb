class Users::Oauth2CallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    if User.allowed_to_login?(request.env["omniauth.auth"])
      @user = User.from_omniauth(request.env["omniauth.auth"])

      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = "Sorry, not a valid login"
      redirect_to root_path
    end
  end
end
