require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/actor' )
require_relative( '../models/casting')
require_relative( '../models/film')
also_reload( './*' )

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

post '/actors/create' do
  p actor = Actor.find_by_name(params[:first_name], params[:last_name])
  if actor.nil?
    actor = Actor.new(params)
    actor.save
  end
  redirect to("/actors")
end

post "/actors/:actor_id/film/add" do
  film = Film.find_by_title(params[:title])
  if film.nil?
    film = Film.new(params)
    film.save
  end
  actor = Actor.find(params[:actor_id].to_i)

  casting = Casting.find_by_actor_film({'actor_id' => actor.id, 'film_id' => film.id})

  if casting.nil?
    casting = Casting.new({'actor_id' => actor.id, 'film_id' => film.id})
    casting.save
  end

  redirect to("/actors/#{params[:actor_id]}")
end
