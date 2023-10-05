# frozen_string_literal: true

module Actions
  def current_count_player
    self.count = cards.each.reduce(0) do |sum, card|
      if card[0].include?('A')
        puts "Choose a value for the ace:\n1. 1\n2. 11"
        choice = gets.chomp.to_i
        if choice == 1
          sum += 1
          sum
        elsif choice == 2
          sum += 11
          sum
        end
      else
        sum += card[1]
        sum
      end
    end
  end

  def current_count_dealer
    self.count = cards.each.reduce(0) do |sum, card|
      if card[0].include?('A')
        choice = rand(1..2)
        if choice == 1
          sum += 1
        elsif choice == 2
          sum += 11
        end
      else
        sum += card[1]
      end
    end
  end

  def current_count_player_new
    if cards.last.include?('A')
      puts "Choose a value for the ace:\n1. 1\n2. 11"
      choice = gets.chomp.to_i
      self.count +=
        if choice == 1
          1
        elsif choice == 2
          11
        end
    else
      self.count += cards.last[1]
    end
  end

  def current_count_dealer_new
    if cards.last.include?('A')
      if self.count <= 10
        self.count += 11
      else
        self.count += 1
      end
    else
      self.count += cards.last[1]
    end
  end

  def increase_bank(var)
    self.bank += var
  end
end
