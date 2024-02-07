# frozen_string_literal: true

require_relative './pokemon'
require_relative './name_service'

# Pikachuクラスを作成
class Pikachu < Pokemon
  include NameService

  def attack
    super
    print "#{@name}の10万ボルト"
  end
end

pika = Pikachu.new('ピカチュウ', 'でんき', '', 100)
puts pika.attack
pika.change_name('テキセツ')
puts pika.name
pika.change_name('うんこ')
puts pika.name
