require 'sinatra/base'
require './lib/player'
require './lib/game'

class RockPaperScissors < Sinatra::Base

  enable :sessions

  get '/' do
    erb :index
  end

  get '/new-game' do
  	erb :new_player
  end

  post '/register' do 
    session[:name] = params[:name] if params[:name]
  	erb :play	
  end

  post "/play" do
  	player = Player.new(params[:name])
  	player.picks = params[:pick]
  	computer = generate_computer
  	@game = Game.new(player, computer)
  	erb :outcome
  end

  def generate_computer
  	choice = ["Rock","Paper","Scissors"].sample
  	comp = Player.new("computer")
  	comp.picks = choice
  	comp
  end

configure :production do
  require 'newrelic_rpm'
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
