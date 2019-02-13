class Owner < ActiveRecord::Base
  has_many :pets
  has_secure_password

  def logged_in?
    !!session[:owner_id]
  end
end
