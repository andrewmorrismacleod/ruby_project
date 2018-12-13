### Bacon Number Generator

Most people are aware of the concept of a Bacon number i.e. given a specified actor/actress what is the shortest sequence of actors/actresses that links that specified actor/actress to Kevin Bacon. Any pair of actors/actresses contribute 1 to a chain if they have starred in the same film together. The number of links in that chain is the Bacon Number.

From a technical viewpoint a Bacon Number is defined as follows (definition borrowed from Wikipedia)

Bacon numbers
The Bacon number of an actor is the number of degrees of separation he or she has from Bacon, as defined above. The higher the Bacon number, the greater the separation from Kevin Bacon the actor is.

The computation of a Bacon number for actor X is a "shortest path" algorithm, applied to the co-stardom network:

Kevin Bacon himself has a Bacon number of 0.
Those actors who have worked directly with Kevin Bacon have a Bacon number of 1.
If the lowest Bacon number of any actor with whom X has appeared in any movie is N, X's Bacon number is N+1.

#### MVP:
* The app should be able to produce:
*   - a list (not necessarily the most efficient) of films/actors that connects a specified actor/actress with Kevin Bacon.
*   - the length of this list
* It should be possible to add (or delete) actors/films to (from) the database via a web interface.
* There should be full CRUD functionality for the following tables: films, actors and castings (linking films and actors)

#### Possible Extensions:
* Implement Dijkstra's algorithm so that the list produced in point 1 is the shortest possible list and return that number.

* Make the program work so that the length between any two actors can be computed i.e. not just an actor/actress with Kevin Bacon.

#### Possible Further Extensions
* Add additional information that would allow a person's Erdos number to be computed and use this in conjunction with the MVP to find a person's Erdos-Bacon number.
