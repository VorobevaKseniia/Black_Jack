# frozen_string_literal: true
require_relative 'cards'
require_relative 'player'
require_relative 'dealer'
require_relative 'actions'

class Menu
  include Actions
  PL = 0
  DL = 1
  BET = 10
  attr_accessor :bank, :players

  def initialize
    @players = []
    @total = 0
  end

  def start
    loop do
      puts "1. Start a new game!\n0. Exit"
      choice = gets.chomp.to_i
      greeting if choice == 1
      break if choice.zero?
    end
  end

  def continue
    delete_cards
    loop do
      puts "1. New round!\n0. Exit"
      choice = gets.chomp.to_i
      start_game if choice == 1
      break if choice.zero?
    end
  end

  def start_game
    puts "Cards have been dealt!"
    2. times {add_card(PL) && add_card(DL)}
    puts "Your cards\n#{show_cards(PL)}\nYour count: #{players[PL].count}"
    puts "Dealer's card\n🂠 🂠"
    place_bet
    p @players
    next_step
  end

  def next_step
    if players[PL].cards.size == 3 && players[DL].cards.size == 3
      open_the_cards
    else
      puts "1. Skip\n2. Add a card\n3. Open the cards"
      choice = gets.chomp.to_i
      dealers_move if choice == 1
      add_a_card if choice == 2
      open_the_cards if choice == 3
    end
  end

  def dealers_move
    puts "The move goes to the dealer"
    sleep(3)
    if players[DL].count >= 17 && players[DL].count < 22
      puts "The dealer misses a move"
      next_step
    else
      add_card(DL)
      if players[DL].count == 21
        you_lose
      elsif players[DL].count < 21
        puts "Dealer took a card\n🂠 🂠 🂠"
        players[PL].cards.size == 3 ? open_the_cards : next_step
      else
        you_won
      end
    end
  end

  def add_a_card
    add_card(PL)
    puts "Player's cards: #{show_cards(PL)}"
    if players[PL].count == 21
      you_won
    elsif players[PL].count > 21
      you_lose
    else
      dealers_move
    end
  end

  def open_the_cards
    if players[DL].count < players[PL].count
      you_won
    elsif players[DL].count == players[PL].count
      puts "You have the same number of points!"
      refresh_count
      return_bet
      sleep(3)
      continue
    else
      you_lose
    end
  end

  private

  def greeting
    puts "Enter your name: "
    name = Player.new(gets.chomp.capitalize!)
  rescue StandardError => e
    puts e.message
    retry
  else
    @players << name << Dealer.new(Dealer)
    puts "Welcome to the game #{name.name}!"
    start_game
  end

  def add_card(who)
    card =  Cards.new.take_card
    players[who].cards << card && players[who].current_count(card)
  end

  def show_cards(num)
    players[num].cards.map {|card| card[0]}
  end

  def delete_cards
    players[PL].cards.shift until players[PL].cards.empty?
    players[DL].cards.shift until players[DL].cards.empty?
  end

  def you_lose
    puts "Player's cards: #{show_cards(PL)}"
    puts "Player's points: #{players[PL].count}"
    puts "Dealer's cards: #{show_cards(DL)}"
    puts "Dealer's points: #{players[DL].count}"
    puts "You lose!"
    refresh_count
    lose_bet
    sleep(3)
    continue
  end

  def you_won
    puts "Player's cards: #{show_cards(PL)}"
    puts "Player's points: #{players[PL].count}"
    puts "Dealer's cards: #{show_cards(DL)}"
    puts "Dealer's points: #{players[DL].count}"
    puts "Congratulations, you've won!"
    refresh_count
    won_bet
    sleep(3)
    continue
  end

  def place_bet
    players[PL].increase_bank(-BET)
    players[DL].increase_bank(-BET)
    puts "Amount won: #{@total += BET*2}"
  end

  def won_bet
    players[PL].increase_bank(@total)
    @total = 0
    puts "Your bank: #{players[PL].bank}\nDealer's bank: #{players[DL].bank}"
  end

  def lose_bet
    players[DL].increase_bank(@total)
    @total = 0
    puts "Your bank: #{players[PL].bank}\nDealer's bank: #{players[DL].bank}"
  end

  def return_bet
    players[PL].increase_bank(BET)
    players[DL].increase_bank(BET)
    @total = 0
    puts "Your bank: #{players[PL].bank}\nDealer's bank: #{players[DL].bank}"
  end

  def refresh_count
    players[PL].count = 0
    players[DL].count = 0
  end
end

Menu.new.start