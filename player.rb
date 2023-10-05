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

  private
  def validate!
    raise 'Enter your name!' if @name.empty?
  end
end
