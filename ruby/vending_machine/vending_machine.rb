# frozen_string_literal: true

require_relative './juice'
require_relative './suica'

# VendingMachineクラスを作成
class VendingMachine
  def initialize
    initialize_juice_stock
    initialize_sales_amount
  end

  # 自動販売機の在庫
  def stock
    @juice_stock.map { |juice_info| "#{juice_info[:juice].name}: #{juice_info[:quantity]}" }.join(', ')
  end

  # 購入可能かどうか
  def purchase_available?(juice_name, suica)
    juice_info = find_juice_info_by_name(juice_name)

    # チャージ残高が足りないもしくは在庫がない
    return false if juice_info.nil?

    suica.current_balance >= juice_info[:juice].price && juice_info[:quantity].positive?
  end

  # 購入処理
  def purchase(juice_name, suica)
    juice_info = find_juice_info_by_name(juice_name)

    raise '指定されたジュースは購入できません' unless purchase_available?(juice_name, suica)

    # juiceの個数を減らす
    juice_info[:quantity] -= 1
    # 売上を増やす
    @sales_amount += juice_info[:juice].price
    # チャージ残高をjuice分減らす
    suica.reduce_balance(juice_info[:juice].price)
  end

  # 購入可能なドリンクのリスト
  def available_drinks(suica)
    @juice_stock.select { |info| purchase_available?(info[:juice].name, suica) }.map  { |info| info[:juice].name }.join(', ')
  end

  # 在庫を補充
  def refill(juice_name, quantity)
    juice_info = find_juice_info_by_name(juice_name)
    raise '指定されたジュースは存在しません' unless juice_info

    juice_info[:quantity] += quantity
  end

  # 売上金額
  def revenue
    @sales_amount
  end

  def initialize_juice_stock
    # juiceの在庫
    @juice_stock = [
      { juice: Juice.new('ペプシ', 150), quantity: 5 },
      { juice: Juice.new('モンスター', 230), quantity: 5 },
      { juice: Juice.new('いろはす', 120), quantity: 5 }
    ]
  end

  private

  def initialize_sales_amount
    # 売上
    @sales_amount = 0
  end

  def find_juice_info_by_name(juice_name)
    @juice_stock.find { |info| info[:juice].name == juice_name }
  end

  attr_reader :sales_amount
end
