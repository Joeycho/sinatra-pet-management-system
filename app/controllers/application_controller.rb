require 'pry'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
      set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do

    if !logged_in?
      erb :signup
    else
      flash[:message] = "You're already logged in. Please log out first to signup as new owner."
      redirect :"/"
    end
  end

  post '/signup' do
    if !logged_in?
        if params[:ownername]!="" && params[:o_type]!="" && params[:password]!=""
          owner = Owner.find_by(:name => params[:ownername],:o_type => params[:o_type])
              if owner == nil
                owner = Owner.create(:name => params[:ownername],:o_type => params[:o_type],:password => params[:password])
                owner.save
                  session[:owner_id] = owner.id
                  redirect "/owners/#{owner.id}"
              else
                flash[:message] = "You are already in our list, please try login with your password"
                redirect "/login"
              end
        else
          flash[:message] = "Please fill in the input box with anything. Don't leave it as blank"
          redirect "/signup"
        end
    else
      flash[:message] = "You're already logged in. Please log out first to signup as new owner."
      redirect :"/"
    end
  end

  get "/login" do
    if !logged_in?
      erb :login
    else
      flash[:message] = "You're already logged in. Please log out first to login as the other owner."
      redirect :"/owners/#{current_owner.id}"
    end
  end

  post '/login' do
    if !logged_in?
        owner = Owner.find_by(:name => params[:ownername])

        if owner && owner.authenticate(params[:password])
          session[:owner_id] = owner.id
          redirect "/owners/#{current_owner.id}"
        else
          flash[:message] = "Invalid login try, please try again with the valid one"
          redirect "/login"
        end
  else
    flash[:message] = "You're already logged in. Please log out first to login as the other owner."
    redirect :"/owners/#{current_owner.id}"
  end

  end

  get "/logout" do
   session.clear
   redirect "/"
  end

  helpers do
      def logged_in?
        !!current_owner
      end

      def current_owner
        @current_owner ||= Owner.find_by(id: session[:owner_id]) if session[:owner_id]
      end

      def redirect_if_not_logged_in
        if !logged_in?
          flash[:message] = "Something is wrong, login again"
          redirect "/login"
        end
      end
  end


end
