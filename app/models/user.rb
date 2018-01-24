class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.allowed_to_login?(access_token)
    data = access_token.info
    # Change this if you need further logic to determine who can login.
    LOGIN_DOMAIN_WHITELIST.include? data['email'].split('@')[1]
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])

    user ||= User.create(
      email: data['email'],
      password: Devise.friendly_token[0, 20]
    )

    user
  end
end
