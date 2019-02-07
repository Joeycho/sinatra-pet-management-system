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

    if session[:owner_id]==nil
      erb :signup
    else
      flash[:message] = "You're already logged in. Please log out first to signup as new owner."
      redirect :"/owners/#{session[:owner_id]}"
    end
  end

  post '/signup' do
      if params[:ownername]!="" && params[:o_type]!="" && params[:password]!=""
        owner = Owner.new(:name => params[:ownername],:o_type => params[:type], :password => params[:password])
        owner.save
        session[:owner_id] = owner.id
        redirect "/owners/#{owner.id}"
      else
        flash[:message] = "Please fill in the input box with anything. Don't leave it as blank"
        redirect "/signup"
      end
  end

  get "/login" do
    if session[:owner_id]==nil
      erb :login
    else
      flash[:message] = "You're already logged in. Please log out first to login as the other owner."
      redirect :"/owners/#{session[:owner_id]}"
    end
  end

  post '/login' do
    owner = Owner.find_by(:name => params[:ownername])

    if owner && owner.authenticate(params[:password])
      session[:owner_id] = owner.id
      redirect "/owners/#{session[:owner_id]}"
    else
      redirect "/login"
    end
  end

  get "/logout" do
   session.clear
   redirect "/login"
  end

end
