# frozen_string_literal: true

require_relative './juice'
require_relative './suica'

# VendingMachineクラスを作成
class VendingMachine
  def initialize
    initialize_juice_stock
    initialize_juice_quantity
    initialize_sales_amount
  end

  # 自動販売機の在庫
  def stock
    @juice_quantity.map { |name, quantity| "#{name}: #{quantity}" }.join(', ')
  end

  # 購入可能かどうか
  def purchase_available?(juice_name, suica)
    juice = @juice_stock[juice_name]
    quantity = @juice_quantity[juice_name]

    # チャージ残高が足りないもしくは在庫がない
    return false if juice.nil? || quantity.nil?

    suica.current_balance >= juice.price && quantity.positive?
  end

  # 購入処理
  def purchase(juice_name, suica)
    juice = @juice_stock[juice_name]

    raise '指定されたジュースは購入できません' unless purchase_available?(juice_name, suica)

    # juiceの個数を減らす
    @juice_quantity[juice_name] -= 1
    # 売上を増やす
    @sales_amount += juice.price
    # チャージ残高をjuice分減らす
    suica.reduce_balance(juice.price)
  end

  # 購入可能なドリンクのリスト
  def available_drinks
    @juice_stock.select { |name| purchase_available?(name, Suica.new) }.keys.join(', ')
  end

  # 在庫を補充
  def refill(juice_name, quantity)
    raise '指定されたジュースは存在しません' unless @juice_stock.key?(juice_name)

    @juice_quantity[juice_name] += quantity
  end

  # 売上金額
  def revenue
    @sales_amount
  end

  def initialize_juice_stock
    # juiceの在庫
    @juice_stock = {
      'ペプシ' => Juice.new('ペプシ', 150),
      'モンスター' => Juice.new('モンスター', 230),
      'いろはす' => Juice.new('いろはす', 120)
    }
  end

  def initialize_juice_quantity
    # juiceの在庫数
    @juice_quantity = {
      'ペプシ' => 5, 'モンスター' => 5, 'いろはす' => 5
    }
  end

  private

  def initialize_sales_amount
    # 売上
    @sales_amount = 0
  end

  attr_reader :sales_amount
end

suica = Suica.new
vending_machine = VendingMachine.new
puts "初期Suica残高: #{suica.current_balance}円"
puts "初期ジュース在庫: #{vending_machine.stock}"
juice_name = 'ペプシ'
if vending_machine.purchase_available?(juice_name, suica)
  vending_machine.purchase(juice_name, suica)
  puts "#{juice_name}を購入しました。"
else
  puts "#{juice_name}は購入できません。"
end

puts "現在のSuica残高: #{suica.current_balance}円"
puts "現在のジュース在庫: #{vending_machine.stock}"
puts "売上金額: #{vending_machine.revenue}円"
puts "購入可能なドリンクのリスト: #{vending_machine.available_drinks}"

vending_machine.refill('モンスター', 10)
puts "現在のジュース在庫: #{vending_machine.stock}"

