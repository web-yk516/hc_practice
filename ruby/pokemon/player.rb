# frozen_string_literal: true

require_relative './name_service'
# Playerクラスを作成
class Player
  include NameService
end

player = Player.new
player.change_name('サトシ')
puts player.get_name
