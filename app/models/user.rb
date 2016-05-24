class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :rememberable, :trackable, :onliner, :omniauth_providers => [:facebook, :google_oauth2, :twitter, :github]

  class << self
    def from_omniauth(auth)
      puts "-" * 50
      puts auth.to_json
      puts "-" * 50
      provider = auth.provider
      uid = auth.uid
      info = auth.info.symbolize_keys!
      email = "real_#{Time.now.to_i}#{rand(99)}@example.com"
      if !info.email.nil?
        email = info.email
      end
      user = User.find_or_initialize_by(uid: uid, provider: provider, email: email)
      user.name = info.name
      user.save!
      user
    end
  end
end
