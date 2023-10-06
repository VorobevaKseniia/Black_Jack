# frozen_string_literal: true

class Dealer
  attr_reader :name
  attr_accessor :bank, :cards, :count

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
    @count = 0
  end

  def current_count(card)
    if card[0].include?('A')
      puts "Choose a value for the ace:\n1. 1\n2. 11"
      choice = rand(1..2)
      @count +=
        if choice == 1
          1
        elsif choice == 2
          11
        end
    else
      @count += card[1]
    end
  end
end
