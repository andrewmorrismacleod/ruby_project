require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/actor.rb' )
also_reload( '../models/*' )

get '/actors' do
  @actors = Actor.all
  erb( :"actors/index")
end

get '/actors/:id' do
  @actor = Actor.find(params['id'].to_i)
  erb( :"actors/show")
end
