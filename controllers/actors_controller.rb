require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/actor' )
require_relative( '../models/casting')
also_reload( '../models/*' )

get '/actors' do
  @actors = Actor.all
  erb( :"actors/index")
end

get '/actors/:id' do
  @actor = Actor.find(params[:id].to_i)
  @actor_films = @actor.films
  erb( :"actors/show")
end

post '/actors/:actor_id/:film_id/delete' do
  Casting.delete_by_actor_film_id(params[:actor_id].to_i, params[:film_id].to_i)
  redirect to("/actors/#{params[:actor_id].to_i}")
end

post '/actors/:actor_id/delete' do
  Actor.delete(params[:actor_id].to_i)
  redirect to("/actors")
end
