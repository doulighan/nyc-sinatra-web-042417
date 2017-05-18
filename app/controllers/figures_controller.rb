class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  get '/figures/:id' do 
    figure_id = params[:id].to_i
    if Figure.pluck(:id).include?(figure_id)
      @figure = Figure.find(params[:id])
      erb :'/figures/show'
    else
      erb :'404'
    end
  end 





  get '/figures/:id/edit' do 
    @figure = Figure.find_by(id: params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do 
    @figure = Figure.find_by(id: params[:id])
    @figure.update(params["figure"])

    @figure.titles.destroy_all
    @figure.landmarks.delete(Landmark.find(@figure.id))
    binding.pry

    if !params["figure"]["title_ids"].nil?
      params["figure"]["title_ids"].each do |id|
        figure.titles << Title.find_by(id: id)
      end
    end
    if !params["figure"]["landmark_ids"].nil?
      params["figure"]["landmark_ids"].each do |id|
        figure.landmarks << Landmark.find_by(id: id)
      end
    end
    
    if !params["title"]["name"].empty?
      title = Title.create(name: params["title"]["name"])
      figure.titles << title
    end

    if !params["landmark"]["name"].empty?
      landmark = Landmark.create(name: params["landmark"]["name"])
      figure.landmarks << landmark
    end

    erb :'/figures/show'
  end








  post '/figures' do
    figure = Figure.create(params["figure"])

    if !params["figure"]["title_ids"].nil?
      params["figure"]["title_ids"].each do |id|
        figure.titles << Title.find_by(id: id)
      end
    end
    
    if !params["figure"]["landmark_ids"].nil?
      params["figure"]["landmark_ids"].each do |id|
        figure.landmarks << Landmark.find_by(id: id)
      end
    end
    
    if !params["title"]["name"].empty?
      title = Title.create(name: params["title"]["name"])
      figure.titles << title
    end

    if !params["landmark"]["name"].empty?
      landmark = Landmark.create(name: params["landmark"]["name"])
      figure.landmarks << landmark
    end

    redirect '/figures'

  end

end
