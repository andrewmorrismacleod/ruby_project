require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/film' )
also_reload( '../models/*' )

get '/films' do
  @films = Film.all
  erb( :"films/index")
end

get '/films/:id' do
  @film = Film.find(params['id'].to_i)
  erb( :"films/show")
end
