# frozen_string_literal: true

# Juiceクラスを作成
class Juice
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
