require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/actor' )
require_relative( '../models/casting')
require_relative( '../models/film')
require_relative( '../models/link')
also_reload( '../models/*' )

post '/generator' do
  @links = Link.all
  @game_run = true
  erb(:index)
  # redirect to('/')
end
