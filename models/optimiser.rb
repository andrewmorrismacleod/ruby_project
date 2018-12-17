require_relative( '../db/sql_runner' )
require_relative( 'actor' )
require_relative( 'casting')
require_relative( 'film' )

def optimiser_brute_force(network, first_name, last_name)

  #Define start and end vertices
  p start_vertex = Actor.find_by_name(first_name, last_name).id
  p final_vertex = Actor.find_by_name("Kevin", "Bacon").id

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
        p link
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

    if counter == 10 #Break if in an infinite loop
      break
    end

  end

  if counter == 10 #If the algorith was caught in an infinite loop then return an error otherwise return the set of connections
    return p "Error"
  elsif counter == 0 #Start = end
    return "#{first_name} #{last_name}"
  else
    return chain
  end
end

def optimiser_dijkstra(network, first_name, last_name)
# function Dijkstra(Graph, source):
#  2
#  3      create vertex set Q

  count = 0

  #Find the number of the vertex which represents the source actor
  source_id = Actor.find_by_name(first_name,last_name).id

  #Find the number of the vertex which represents the destination actor
  destination_id = Actor.find_by_name("Kevin", "Bacon").id

  distance = {}
  queue = {}
  visited = {}

  actors = Actor.all

  actors.each do |actor|

    #Only consider those actors who are linked to other actors
    distance[actor.id.to_s.to_sym] = 9999999999999
    if actor.id == source_id
      distance[actor.id.to_s.to_sym] = 0
    end

    queue[actor.id.to_s.to_sym] = distance[actor.id.to_s.to_sym]

  end
  output_network = []

  parent_vertex = []

  while !queue.empty? && (count < 1000)

    count += 1
    minimum_node = queue.min_by { |key, value| value }
    queue.delete(minimum_node[0])

    network.each do |link|

      #Cycle through all of the connections in the network
      #For any that match the current minimum node we need to update the dsitance (count) functions
      if link.current_vertex.id.to_s.to_sym == minimum_node[0]
        if distance[link.current_vertex.id.to_s.to_sym] + 1 < distance[link.next_vertex.id.to_s.to_sym]
          distance[link.next_vertex.id.to_s.to_sym] = distance[link.current_vertex.id.to_s.to_sym] + 1
          queue[link.next_vertex.id.to_s.to_sym] = distance[link.next_vertex.id.to_s.to_sym]
          parent_vertex[link.next_vertex.id] = link.current_vertex.id
        end
      end
    end
  end


  p parent_vertex
  current_vertex = destination_id
  while current_vertex != source_id
    count += 1
    p "#{current_vertex}    #{parent_vertex[current_vertex]}"

    p path = network.select{ |link| (link.current_vertex.id == parent_vertex[current_vertex] && link.next_vertex.id == current_vertex) }
    output_network.push(path[0])
    current_vertex = parent_vertex[current_vertex]
    if count == 100
      break
    end
  end

  output_network.reverse!

# output_network.each do |link|
#   p link
# end

  p output_network
return output_network
 #At this point the distance hash contains



end

# def generate_path(network, first_name, last_name)
#
#
#
#   start_vertex = Actor.find_by_name(first_name, last_name).id
#   final_vertex = Actor.find_by_name("Kevin", "Bacon").id
#
#   current_vertex = start_vertex
#
#   previous_vertex = 0
#
#   bacon_path = [start_vertex]
#
#   current_link = 0
#
#   count = 0
#
#   while current_vertex != final_vertex && count < 20 do
#
#     count += 1
#     bacon_path = []
#     next_vertex_found = false
#     network.each do |link|
#
#
#       #If the current link has a vertex that matches
#       if link.current_vertex.id == current_vertex && !bacon_path.include?(current_link.next_vertex.id)
#         p link
#         bacon_path.push(link)
#         next_vertex_found = true  #Flag that we have found the next vertex
#         current_vertex = link.next_vertex.id  #Update the current vertex for the next pass
#         previous_vertex = link.current_vertex.id
#         break
#       end
#
#     end
#
#     #If the next vertex couldn't be found
#     if !next_vertex_found
#       current_vertex = previous_vertex
#       network.delete(current_link)
#     end
#
#   end
#
#   return bacon_path
#
# end
