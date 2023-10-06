# frozen_string_literal: true
require_relative 'actions'
class Player
  include Actions
  attr_reader :name
  attr_accessor :bank, :cards, :count

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
    @count = 0
    validate!
  end

  def current_count(card)
    if card[0].include?('A')
      puts "Choose a value for the ace:\n1. 1\n2. 11"
      choice = gets.chomp.to_i
      @count +=
        if choice == 1
          1
        elsif choice == 2
          11
        else
          1
        end
    else
      @count += card[1]
    end
  end

  private
  def validate!
    raise 'Enter your name!' if @name.empty?
  end
end
