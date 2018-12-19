require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/actor' )
require_relative( '../models/casting')
require_relative( '../models/film')
require_relative( '../models/link')
require_relative( '../models/optimiser')
also_reload( './*' )

post '/generator' do
  @links = Link.all
  @game_run = true
  if Actor.find_by_name(params[:first_name],params[:last_name]) == nil
    @path = "Start actor is not in the database!"
  elsif Actor.find_by_name(params[:first_name_second_actor],params[:last_name_second_actor]) == nil
    @path = "End actor is not in the database!"
  else
    @path = optimiser_dijkstra(@links, params[:first_name], params[:last_name], params[:first_name_second_actor], params[:last_name_second_actor])
  end

  @name_check = "#{params[:first_name_second_actor]} #{params[:last_name_second_actor]}"
  erb(:index)
end
