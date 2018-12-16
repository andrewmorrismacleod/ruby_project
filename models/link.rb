require_relative( '../db/sql_runner' )
require_relative( 'actor')
require_relative( 'film' )

class Link

  attr_reader :id, :current_vertex, :link, :next_vertex

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @current_vertex = Actor.find(options['current_vertex'].to_i)
    @link = Film.find(options['edge'].to_i)
    @next_vertex = Actor.find(options['next_vertex'].to_i)
  end

  def self.all()
    sql =
    "SELECT * FROM

    (SELECT left_table.actor_id as current_vertex, left_table.film_id as edge, right_table.actor_id as next_vertex FROM castings left_table
    	LEFT JOIN castings right_table
    	ON left_table.film_id = right_table.film_id) a

    WHERE a.current_vertex != a.next_vertex
    ORDER BY current_vertex ASC, next_vertex ASC"

    results = SqlRunner.run( sql )
    return results.map { |link| Link.new( link ) }
  end



end
