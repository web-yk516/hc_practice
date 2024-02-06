# frozen_string_literal: true

# Suicaクラスを作成
class Suica
  def initialize
    # デフォルトで500円チャージ
    @charge_balance = 500
  end

  def charge(amount)
    # 100円未満かをチェック
    raise '100円以上でチャージしてください。' if amount < 100

    @charge_balance += amount
  end

  def reduce_balance(amount)
    @charge_balance -= amount
  end

  # 残高を表示
  def current_balance
    @charge_balance
  end

  private

  attr_reader :charge_balance
end
