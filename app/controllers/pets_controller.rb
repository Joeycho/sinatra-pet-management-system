class PetsController < ApplicationController

  get '/pets/new' do
    if logged_in?
      erb :"/pets/new"
    else
      flash[:message] = "Something is wrong, login again"
      redirect "/login"
    end
  end

  post '/pets' do
      if logged_in?
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
      else
        flash[:message] = "Something is wrong, login again"
        redirect "/login"
      end
  end

    get "/pets/:id/edit" do
        if logged_in?
              if Pet.find(params[:id]) == nil
                flash[:message]="There is no information about this pet"
                redirect "/owners/#{current_owner.id}"
              elsif current_owner.id == Pet.find(params[:id]).owner.id
                @pet = Pet.find(params[:id])
                erb :"/pets/edit"
              else
                flash[:message]="You are not allowed to edit this pet's information"
                redirect "/owners/#{current_owner.id}"
              end
        else
          flash[:message] = "Something is wrong, login again"
          redirect "/login"
        end
  end

    patch '/pets/:id' do
      if logged_in?
          @pet = Pet.find_by_id(params[:id])
          if current_owner.id != @pet.owner_id
              flash[:message] = "It is not your pet!!"
              redirect "/owners/#{current_owner.id}"
          elsif params[:pet_name]!=""
            @pet.name = params[:pet_name]
            @pet.save
            redirect to "/owners/#{current_owner.id}"
          else
            flash[:message] = "Your input is not valid"
            redirect to "/pets/#{@pet.id}/edit"
          end
      else
        flash[:message] = "Something is wrong, login again"
        redirect "/login"
      end
    end

    patch '/pets/:id/bye' do

      if logged_in?
          @pet = Pet.find(params[:id])

          if current_owner.id == @pet.owner_id
            @pet.owner_id = params[:owner][:name]
            @pet.save
            redirect to "/owners/#{current_owner.id}"
          else
            flash[:message] = "This pet is not your pet!!"
            redirect to "/pets/#{@pet.id}/edit"
          end
      else
        flash[:message] = "Something is wrong, login again"
        redirect "/login"
      end
    end

    delete '/pets/:id' do
        if logged_in?
          @pet = Pet.find_by_id(params[:id])
          if current_owner.id == @pet.owner_id
            @pet.delete
          else
            flash[:message]="You are not allowed to delete this pet"
          end
            redirect to "/owners/#{current_owner.id}"
        else
          flash[:message] = "Something is wrong, login again"
          redirect "/login"
        end
    end


end
