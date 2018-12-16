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
  p @links[0]
  @game_run = true
  @path = optimiser_brute_force(@links, params[:first_name], params[:last_name])
  erb(:index)
  #redirect to('/')
end
