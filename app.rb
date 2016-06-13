require 'sinatra/base'
require './lib/game'
require './lib/startup'
require './lib/player'
require './lib/attack'

class RPSApp < Sinatra::Base
  before do
    @game = Game.instance
  end

  get '/' do
    @weapons = Startup::WEAPONS
    Game.create(@weapons)
    erb(:index, :layout => :layout)
  end

  post '/enter-name' do
    weapon = Startup.get_weapon_by_name(params[:weapon])
    Game.setup(params[:name], weapon)
    redirect to '/play'
  end

  get '/play' do
    @attack = Attack.new(@game)
    @attack.attack
    erb(:play, layout: :layout)
  end

  run! if app_file == $PROGRAM_NAME
end
