require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/film' )
require_relative( '../models/casting')
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

post '/films/:film_id/delete' do
  Film.delete(params[:film_id].to_i)
  redirect to("/films")
end

post '/films/create' do
  actor = Film.new(params)
  actor.save
  redirect to("/films")
end

post "/films/:film_id/actor/add" do
  actor = Actor.find_by_name(params[:first_name], params[:last_name])
  if actor.nil?
    actor = Actor.new(params)
    actor.save
  end
  film = Film.find(params[:film_id].to_i)

  casting = Casting.find_by_actor_film({'actor_id' => actor.id, 'film_id' => film.id})

  if casting.nil?
    casting = Casting.new({'actor_id' => actor.id, 'film_id' => film.id})
    casting.save
  end

  redirect to("/films/#{params[:film_id]}")
end
