require('minitest/autorun')
require('minitest/rg')
require_relative('../casting')

class CastingTest < Minitest::Test

  def setup
    casting1_hash = {'actor_id' => 2, 'film_id' => 3}
    @casting1 = Casting.new(casting1_hash)
  end

  def test_casting_has_actor_id
    assert_equal(2, @casting1.actor_id)
  end

  def test_casting_has_film_id
    assert_equal(3, @casting1.film_id)
  end

end
