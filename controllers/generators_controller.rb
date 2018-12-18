require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/actor' )
require_relative( '../models/casting')
require_relative( '../models/film')
require_relative( '../models/link')
require_relative( '../models/optimiser')
also_reload( '../models/*' )

post '/generator' do
  @links = Link.all
  @game_run = true
  # @path = optimiser_brute_force(@links, params[:first_name], params[:last_name])
  @path = optimiser_dijkstra(@links, params[:first_name], params[:last_name], params[:first_name_second_actor], params[:last_name_second_actor])

  @name_check = "Kevin Bacon"
  erb(:index)
  #redirect to('/')
end
