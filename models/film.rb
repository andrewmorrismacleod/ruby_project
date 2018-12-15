require_relative( '../db/sql_runner' )
require_relative ('actor')

class Film

  attr_reader :id, :title

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
  end

  def save()
    sql = "INSERT INTO films
    (title)

      VALUES

      ($1)
    RETURNING id"
    values = [@title]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    results = SqlRunner.run( sql )
    return results.map { |film| Film.new( film ) }
  end

  def self.find(id)
    sql = "SELECT * FROM films
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Film.new( results.first )
  end

  def update
    sql = "UPDATE films
            SET title = $1
            WHERE id = $2"
    values = [@title, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run( sql )
  end

  def self.delete(id)
    sql = "DELETE FROM films
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def actors
    sql = "SELECT actors.* FROM actors
    INNER JOIN castings
    ON actors.id = castings.actor_id
    WHERE castings.film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |actor| Actor.new( actor ) }
  end

end
