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
  @film_actors = @film.actors
  erb( :"films/show")
end

post '/films/:film_id/:actor_id/delete' do
  Casting.delete_by_actor_film_id(params[:actor_id].to_i, params[:film_id].to_i)
  redirect to("/films/#{params[:film_id].to_i}")
end
