require 'minitest/autorun'
require 'pluckit'


class PluckItArrayTest < Minitest::Test


  def test_basic
    data = [
      [ 1, 2, 3 ],
      [ 4, 5, 6 ],
      [ 7, 8, 9 ],
    ]

    assert_equal(
      [ 1, 4, 7 ],
      data.pluck(0)
    )

    assert_equal(
      [ 3, 6, 9 ],
      data.pluck(:last)
    )

    assert_equal(
      [
        [ 1, 2 ],
        [ 4, 5 ],
        [ 7, 8 ],
      ],
      data.pluck(0, 1)
    )
  end


  def test_empty
    assert_equal(
      [],
      [].pluck(nil)
    )

    assert_equal(
      [],
      [].pluck(0)
    )
  end


  def test_hashes
    data = [
      { k: 1, v: 2 },
      { k: 2, v: 4 },
      { k: 3, v: 6 },
    ]

    assert_equal(
      [ 1, 2, 3 ],
      data.pluck(:k)
    )

    assert_equal(
      [ 2, 4, 6 ],
      data.pluck(:v)
    )
  end


  def test_missing
    assert_equal(
      [ nil, 2 ],
      [{ a: 1 }, { k: 2 }].pluck(:k)
    )
  end


  class ABC
    attr_accessor :val
    def initialize(v) self.val = v end
  end

  def test_obj
    assert_equal(
      [ 1, 2, 3 ],
      [
        ABC.new(1),
        ABC.new(2),
        ABC.new(3),
      ].pluck(:val)
    )
  end


  class MyArray < Array; end
  def test_clone
    data = MyArray.new [ 1, 2, 3 ]

    assert_equal(
      [ 1, 2, 3 ],
      data.pluck(:itself)
    )

    assert_equal(
      self.class.const_get(:MyArray),
      data.pluck(:itself).class
    )
  end


end
