

class OwnersController < ApplicationController


    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "password_security"
    end

    get "/owners/:id" do

      if session[:owner_id].to_s == params[:id]
        @owner = Owner.find(session[:owner_id])
        erb :"/owners/show"
      else
        redirect '/login'
      end
    end

end
