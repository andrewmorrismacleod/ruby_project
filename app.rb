require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/actors_controller')
also_reload( '../models/*' )

get '/' do
  erb( :index )
end
