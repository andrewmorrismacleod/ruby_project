require_relative( '../db/sql_runner' )
require_relative( 'actor' )
require_relative( 'casting')
require_relative( 'film' )

def optimiser_brute_force(network, first_name, last_name)

  #Define start and end vertices
  start_vertex = Actor.find_by_name(first_name, last_name).id
  final_vertex = Actor.find_by_name("Kevin", "Bacon").id

  #Set the initial value of the current vertex to be equal to the starting vertex
  #Add the initial value to the path array
  current_vertex = start_vertex
  path = [start_vertex]
  chain = []

  current_link = []


  counter = 0
  previous_vertex = 0

  #Do while the final vertex hasn't been reached
  while current_vertex != final_vertex do

    counter += 1

    #Initially state that the next vertex hasn't been found
    next_vertex_found = false

    #For each vertex pair
    network.each do |link|

      current_link = link

      #If the current link has a vertex that matches
      if link.current_vertex.id == current_vertex && !path.include?(current_link.next_vertex.id)

        path.push(link.next_vertex.id)  #Add the next vertex to the final path array
        chain.push(link)
        next_vertex_found = true  #Flag that we have found the next vertex
        current_vertex = link.next_vertex.id  #Update the current vertex for the next pass
        previous_vertex = link.current_vertex.id
        break
      elsif path.include?(current_link.next_vertex.id)
        network.delete(current_link)
      end

    end

    #If the next vertex couldn't be found
    if !next_vertex_found
      path.pop
      chain.pop
      current_vertex = previous_vertex
    end

    if counter == 100000 #Break if in an infinite loop
      break
    end

  end

  if counter == 100000 #If the algorith was caught in an infinite loop then return an error otherwise return the set of connections
    return "Error"
  elsif counter == 0 #Start = end
    return "#{first_name} #{last_name}"
  else
    return chain
  end
end
