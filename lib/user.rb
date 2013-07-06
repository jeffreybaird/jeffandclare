class User < ActiveRecord::Base

  def self.authenticate(params)
    user = User.where(:user_name => params[:user][:user_name]).first
    if user
      if user.password == params[:user][:password]
        user
      else
        nil
      end
    else
      nil
    end
  end

end