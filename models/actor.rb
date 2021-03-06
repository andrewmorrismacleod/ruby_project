require_relative( '../db/sql_runner' )
require_relative( 'film' )

class Actor

  attr_reader :id, :first_name, :last_name

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def full_name()
    return "#{@first_name} #{@last_name}"
  end

  def save()
    sql = "INSERT INTO actors
    (
      first_name,
      last_name
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@first_name, @last_name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM actors"
    results = SqlRunner.run( sql )
    return results.map { |actor| Actor.new( actor ) }
  end

  def self.find(id)
    sql = "SELECT * FROM actors
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Actor.new( results.first )
  end

  def update
    sql = "UPDATE actors
            SET (first_name, last_name) = ($1, $2)
            WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM actors"
    SqlRunner.run( sql )
  end

  def self.delete(id)
    sql = "DELETE FROM actors
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def films
    sql = "SELECT films.* FROM films
    INNER JOIN castings
    ON films.id = castings.film_id
    WHERE castings.actor_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |film| Film.new( film ) }
  end

  def self.find_by_name(first_name, last_name)
    sql = "SELECT * FROM actors
    WHERE first_name = $1
    AND last_name = $2"
    values = [first_name, last_name]
    results = SqlRunner.run( sql, values )
    if results.first.nil?
      return nil
    else
      return Actor.new( results.first )
    end
  end

end
