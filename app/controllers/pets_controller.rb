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

    get "/pets/:id/edit" do
    if session[:owner_id]==nil
        redirect "/login"
    elsif session[:owner_id] != Pet.find(params[:id]).owner.id
        redirect "/login"
    else
      @pet = Pet.find(params[:id])
      erb :"/pets/edit"
    end
  end

    patch '/pets/:id' do
        @pet = Pet.find_by_id(params[:id])
      if params[:pet_name]!=""
        @pet.name = params[:pet_name]
        @pet.save
        redirect to "/owners/#{session[:owner_id]}"
      else
        redirect to "/pets/#{@pet.id}/edit"
      end
    end

    patch '/pets/:id/bye' do
        @pet = Pet.find(params[:id])
        @pet.owner_id = params[:owner][:name]
        @pet.save
        redirect to "/owners/#{session[:owner_id]}"

        redirect to "/pets/#{@pet.id}/edit"
    end

    delete '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    if session[:owner_id] == @pet.owner_id
      @pet.delete
    end
      redirect to "/owners/#{session[:owner_id]}"
  end


end
