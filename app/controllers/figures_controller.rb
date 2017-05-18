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

  post '/figures' do
    # CREATE OUR NEW TITLE
    @title = params["title"] # has only name key/value
    # CREATE OUR NEW LANDMARK
    @landmark = params["landmark"] # has only name key/value
    figure = Figure.new(params["figure"])
    #ASSIGN OUR TITLE/LANDMARK IF NEW
    if figure.save
      redirect to '/figures'
    else
      redirect to '/figures/new'
    end
  end

end
