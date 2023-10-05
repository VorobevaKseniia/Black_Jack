# frozen_string_literal: true

class Dealer
  include Actions
  attr_reader :name
  attr_accessor :bank, :cards, :count

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
    @count = 0
  end

end
