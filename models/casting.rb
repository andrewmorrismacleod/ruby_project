require_relative( '../db/sql_runner' )

class Casting

  attr_reader :id, :actor_id, :film_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @actor_id = options['actor_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO castings
    (
      actor_id, film_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@actor_id, @film_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM castings"
    results = SqlRunner.run( sql )
    return results.map { |casting| Casting.new( casting ) }
  end

  def self.find(id)
    sql = "SELECT * FROM castings
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Casting.new( results.first )
  end

  def update
    sql = "UPDATE castings
            SET (actor_id, film_id) = ($1, $2)
            WHERE id = $3"
    values = [@actor_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM castings"
    SqlRunner.run( sql )
  end

  def self.delete(id)
    sql = "DELETE FROM castings
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.delete_by_actor_film_id(actor_id, film_id)
    sql = "DELETE FROM castings
    WHERE actor_id = $1
    AND film_id = $2"
    values = [actor_id, film_id]
    SqlRunner.run( sql, values )
  end

  def self.find_by_actor_film(options)
    sql = "DELETE FROM castings
    WHERE actor_id = $1
    AND film_id = $2"
    values = [options['actor_id'].to_i, options['film_id'].to_i]
    SqlRunner.run( sql, values )
    results = SqlRunner.run(sql, values)
    if results.first.nil?
      return nil
    else
      return Casting.new( results.first )
    end
  end

end
