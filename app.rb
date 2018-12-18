require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/actors_controller')
require_relative('controllers/films_controller')
require_relative('controllers/generators_controller')
also_reload( './*' )

get '/' do
  erb( :index )
end
