require_relative( '../models/actor' )
require_relative( '../models/casting' )
require_relative( "../models/film" )
require("pry-byebug")

actor_hash_array = []
actor_class_array = []

actor_hash_array.push({'first_name' => 'Troy', 'last_name' => 'McLure'})
actor_hash_array.push({'first_name' => 'Sylvester', 'last_name' => 'Stallone'})
actor_hash_array.push({'first_name' => 'Halle', 'last_name' => 'Berry'})
actor_hash_array.push({'first_name' => 'Samuel L.', 'last_name' => 'Jackson'})
actor_hash_array.push({'first_name' => 'Kevin', 'last_name' => 'Bacon'})
actor_hash_array.push({'first_name' => 'Nicholas', 'last_name' => 'Cage'})
actor_hash_array.push({'first_name' => 'Arnold', 'last_name' => 'Schwartzenegger'})
actor_hash_array.push({'first_name' => 'Denise', 'last_name' => 'Richards'})

actor_hash_array.each{ |actor_hash| actor_class_array.push(Actor.new(actor_hash))}
actor_class_array.each{ |actor| actor.save}

film_hash_array = []
film_class_array = []

film_hash_array.push({'title' => 'David vs Super Goliath'})
film_hash_array.push({'title' => 'The Erotic Adventures of Hercules'})
film_hash_array.push({'title' => "Look Who's Still Oinking"})
film_hash_array.push({'title' => 'Leper in the Backfield'})
film_hash_array.push({'title' => 'Today We Kill, Tomorrow We Die'})
film_hash_array.push({'title' => "The President's Neck is Missing"})
film_hash_array.push({'title' => 'Catwoman 2: I am the Paw'})
film_hash_array.push({'title' => 'Jonathan Frakes on a Train'})
film_hash_array.push({'title' => "We've Been in Everything"})
film_hash_array.push({'title' => 'Mystic River'})
film_hash_array.push({'title' => 'Apollo 13'})
film_hash_array.push({'title' => 'Poor Payday Action Film'})
film_hash_array.push({'title' => 'Starship Toopers 5: Attack of the Bees'})
film_hash_array.push({'title' => 'Jingle all to the way to the Bank'})

film_hash_array.each{ |film_hash| film_class_array.push(Film.new(film_hash))}
film_class_array.each{ |film| film.save}

casting_hash_array = []
casting_class_array = []

casting_hash_array.push({'actor_id'=>actor_class_array[0].id,'film_id'=>film_class_array[0].id})
casting_hash_array.push({'actor_id'=>actor_class_array[0].id,'film_id'=>film_class_array[1].id})
casting_hash_array.push({'actor_id'=>actor_class_array[0].id,'film_id'=>film_class_array[2].id})
casting_hash_array.push({'actor_id'=>actor_class_array[0].id,'film_id'=>film_class_array[3].id})
casting_hash_array.push({'actor_id'=>actor_class_array[0].id,'film_id'=>film_class_array[4].id})
casting_hash_array.push({'actor_id'=>actor_class_array[0].id,'film_id'=>film_class_array[5].id})

casting_hash_array.push({'actor_id'=>actor_class_array[1].id,'film_id'=>film_class_array[1].id})
casting_hash_array.push({'actor_id'=>actor_class_array[1].id,'film_id'=>film_class_array[6].id})

casting_hash_array.push({'actor_id'=>actor_class_array[2].id,'film_id'=>film_class_array[6].id})
casting_hash_array.push({'actor_id'=>actor_class_array[2].id,'film_id'=>film_class_array[3].id})
casting_hash_array.push({'actor_id'=>actor_class_array[2].id,'film_id'=>film_class_array[7].id})

casting_hash_array.push({'actor_id'=>actor_class_array[3].id,'film_id'=>film_class_array[7].id})
casting_hash_array.push({'actor_id'=>actor_class_array[3].id,'film_id'=>film_class_array[8].id})

casting_hash_array.push({'actor_id'=>actor_class_array[4].id,'film_id'=>film_class_array[8].id})
casting_hash_array.push({'actor_id'=>actor_class_array[4].id,'film_id'=>film_class_array[9].id})
casting_hash_array.push({'actor_id'=>actor_class_array[4].id,'film_id'=>film_class_array[10].id})
casting_hash_array.push({'actor_id'=>actor_class_array[4].id,'film_id'=>film_class_array[11].id})

casting_hash_array.push({'actor_id'=>actor_class_array[5].id,'film_id'=>film_class_array[4].id})
casting_hash_array.push({'actor_id'=>actor_class_array[5].id,'film_id'=>film_class_array[12].id})

casting_hash_array.push({'actor_id'=>actor_class_array[6].id,'film_id'=>film_class_array[11].id})
casting_hash_array.push({'actor_id'=>actor_class_array[6].id,'film_id'=>film_class_array[5].id})
casting_hash_array.push({'actor_id'=>actor_class_array[6].id,'film_id'=>film_class_array[13].id})

casting_hash_array.push({'actor_id'=>actor_class_array[7].id,'film_id'=>film_class_array[12].id})

casting_hash_array.each{ |casting_hash| casting_class_array.push(Casting.new(casting_hash))}
casting_class_array.each{ |casting| casting.save}
