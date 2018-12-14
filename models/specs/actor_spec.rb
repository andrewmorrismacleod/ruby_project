require('minitest/autorun')
require('minitest/rg')
require_relative('../actor')

class ActorTest < Minitest::Test

  def setup
    actor1_hash = {'first_name' => "Brad", 'last_name' => "Pitt"}
    @actor1 = Actor.new(actor1_hash)
  end

  def test_actor_has_first_name
    assert_equal("Brad", @actor1.first_name)
  end

  def test_actor_has_last_name
    assert_equal("Pitt", @actor1.last_name)
  end

  def test_full_name
    assert_equal("Brad Pitt", @actor1.full_name)
  end

end
