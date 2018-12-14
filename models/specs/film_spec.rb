require('minitest/autorun')
require('minitest/rg')
require_relative('../film')

class FilmTest < Minitest::Test

  def setup
    film1_hash = {'title' => "Tree of Life"}
    @film1 = Film.new(film1_hash)
  end

  def test_film_has_title
    assert_equal("Tree of Life", @film1.title)
  end

end
