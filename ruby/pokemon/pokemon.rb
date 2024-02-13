# frozen_string_literal: true

require_relative 'name_service'
# Pokemonクラスを作成
class Pokemon
  include NameService

  def initialize(name, type1, type2, hitpoint)
    @name = name
    @type1 = type1
    @type2 = type2
    @hp = hitpoint
  end

  attr_reader :type1, :type2, :hp

  def attack
    puts "#{@name}のこうげき！"
  end
end
