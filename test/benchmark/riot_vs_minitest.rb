$:.concat ['./lib']
require 'benchmark'

#
# Model

class Room
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

#
# Riot

require 'riot'
Riot.silently!

context "a room" do
  setup { Room.new("bed") }

  asserts("name") { topic.name }.equals("bed")
end # a room

#
# MiniTest::Unit

require 'rubygems'
require 'minitest/unit'

class RoomTest < MiniTest::Unit::TestCase
  def setup
    @room = Room.new("bed")
  end

  def test_room_should_be_named_bed
    assert_equal "bed", @room.name
  end
end

#
# Benchmarking

n = 100 * 100

Benchmark.bmbm do |x|
  x.report("Riot") do
    n.times do
      Riot.run
    end
  end

  x.report("MiniTest") do
    n.times { RoomTest.new("Blah").run(MiniTest::Unit.new) }
  end
end

