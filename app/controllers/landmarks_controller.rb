class LandmarksController < ApplicationController
   configure do
    set :public_folder, 'public'
    set :views, 'app/views/landmarks'
  end

  get '/' do 
    redirect '/landmarks'
  end

  get '/landmarks' do 
    @landmarks = Landmark.all
    erb :index
  end

  post '/landmarks' do 
    Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["name"])
    redirect '/landmarks'
  end

  get '/landmarks/new' do 
    erb :new
  end


  get '/landmarks/:id' do 
    landmark_id = params[:id].to_i
    if Landmark.pluck(:id).include?(landmark_id)
      @landmark = Landmark.find(params[:id])
      erb :show
    else
      erb :'404'
    end
  end 

  get '/landmarks/:id/edit' do 
    @landmark = Landmark.find_by(id: params[:id])
    erb :edit
  end

   patch '/landmarks/:id' do 
    @landmark = Landmark.find_by(id: params[:id])
    @landmark.update(name: params["landmark"]["name"])
    @landmark.update(year_completed: params["landmark"]["year_completed"])
    erb :show
  end




end
