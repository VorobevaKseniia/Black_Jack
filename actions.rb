# frozen_string_literal: true

module Actions
  def current_count
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

  def increase_bank(var)
    self.bank += var
  end
end
