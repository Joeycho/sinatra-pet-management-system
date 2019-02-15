
class OwnersController < ApplicationController


    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "password_security"
    end

    get "/owners" do
      redirect_if_not_logged_in
        erb :"/owners/index"
    end

    get "/owners/:id" do
      redirect_if_not_logged_in
           if current_owner.id == params[:id].to_i
            @owner = Owner.find(current_owner.id)
            erb :"/owners/show"
          else
            flash[:message] = "You are accessing other owner's page!!"
            redirect "/owners/#{current_owner.id}"
          end
    end

end
