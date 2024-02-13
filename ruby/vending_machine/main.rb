# frozen_string_literal: true

require_relative './juice'
require_relative './suica'
require_relative './vending_machine'

suica = Suica.new
vending_machine = VendingMachine.new
puts "初期Suica残高: #{suica.current_balance}円"
puts "初期ジュース在庫: #{vending_machine.stock}"
juice_names = %w[ペプシ モンスター いろはす]
juice_names.each do |juice_name|
  if vending_machine.purchase_available?(juice_name, suica)
    vending_machine.purchase(juice_name, suica)
    puts "#{juice_name}を購入しました。"
  else
    puts "#{juice_name}は購入できません。"
  end
end

puts "現在のSuica残高: #{suica.current_balance}円"
puts "現在のジュース在庫: #{vending_machine.stock}"
puts "売上金額: #{vending_machine.revenue}円"
puts "購入可能なドリンクのリスト: #{vending_machine.available_drinks(suica)}"

vending_machine.refill('モンスター', 10)
puts "現在のジュース在庫: #{vending_machine.stock}"
