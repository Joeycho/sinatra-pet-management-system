class PetsController < ApplicationController

  get '/pets/new' do
    if session[:owner_id]==nil
        redirect "/login"
      else
        erb :"/pets/new"
      end
  end

  post '/pets' do

          params[:pets].all.each do |pet|
            @pet = Pet.find_by(name: pet[:name])
            @pet.owner_id = session[:owner_id]
            @pet.save
          end

          if params[:pet_name]!=""
            @pet = Pet.create(:name => params[:pet_name], :owner_id => session[:owner_id])
            @pet.save
          end

          redirect "/owners/#{Owner.find(session[:owner_id])}"

    end
end
