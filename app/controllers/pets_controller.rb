class PetsController < ApplicationController

  get '/pets/new' do
    if session[:owner_id]==nil
        redirect "/login"
      else
        erb :"/pets/new"
      end
  end

  post '/pets' do

        if params[:pets] != nil
          params[:pets].each do |pet|
            @pet = Pet.find_by(name: pet[:name])
            @pet.owner_id = session[:owner_id]
            @pet.save
          end
        end
          if params[:pet_name]!=""
            @pet = Pet.find_or_create_by(:name => params[:pet_name], :owner_id => session[:owner_id])
            @pet.save
          end

          redirect "/owners/#{session[:owner_id]}"

    end
end
