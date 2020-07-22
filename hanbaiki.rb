class Drink
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

class VendingMachine

  attr_reader :slot_money, :sale_amount, :drinks

  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @drinks = [{ drink: Drink.new('cola', 120), count: 5 }]
    @slot_money = 0
    @sale_amount = 0
  end

  def current_slot_money
    @slot_money
  end

  def current_sale_amount
    @sale_amount
  end

  def slot_money(money)
    return false unless MONEY.include?(money)
    @slot_money += money
  end

  def select_drink(drink_name)
    @drinks.find do |drink|
      drink[:drink].name == drink_name
    end
  end

  def add_drink(name, price, count)
    if @drinks.none? { |drink| drink[:drink].name == name}
    @drinks << {drink: Drink.new(name, price), count: count}
  else
    drink = select_drink(name)
    drink[:count] += count
    end
  end

  def purchase(drink_name)
    drink = select_drink(drink_name)
    if @slot_money >= drink[:drink].price
       @slot_money -= drink[:drink].price
       @sale_amount += drink[:drink].price
      drink[:count] -= 1
    end
  end

  def purchasable_drinks_list
    purchasable_drinks.map do |drink|
     drink[:drink].name
    end
  end

  def purchasable_drinks
    drinks.select do |drink|
      drink[:drink].price <= @slot_money && drink[:count] > 0
    end
  end
  def return_money
    puts @slot_money
    @slot_money = 0
  end
end
