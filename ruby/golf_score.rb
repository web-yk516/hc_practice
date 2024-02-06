# frozen_string_literal: true

# Groupクラスを作成
class Golf
  def initialize(par_values, player_values)
    @par_values = par_values
    @player_values = player_values
  end

  def calculate_score(par_score, player_score)
    return 'コンドル' if condor?(par_score, player_score)
    return 'ホールインワン' if hole_in_one?(par_score, player_score)
    return 'アルバトロス' if albatross?(par_score, player_score)

    score_judgement(par_score, player_score)
  end

  def condor?(par_score, player_score)
    par_score == 5 && player_score == 1
  end

  def hole_in_one?(par_score, player_score)
    player_score == 1 && (3..4).cover?(par_score)
  end

  def albatross?(par_score, player_score)
    par_score == 5 && player_score == 2
  end

  def score_judgement(par_score, player_score)
    scores = {
      -4 => 'コンドル', -3 => 'アルバトロス', -2 => 'イーグル', -1 => 'バーディ',
      0 => 'パー', 1 => 'ボギー', 2 => '2ボギー', 3 => '3ボギー'
    }
    # スコアを算出
    score = player_score - par_score
    scores[score] || "#{score}ボギー"
  end

  def golf_score
    par_array = @par_values.split(',').map(&:to_i)
    player_array = @player_values.split(',').map(&:to_i)

    result = []

    (0..17).each do |i|
      calculated_score = calculate_score(par_array[i], player_array[i])
      result.push(calculated_score)
    end
    puts result.join(',')
  end
end
# 標準入力から18ホールの規定打数を受け取る
par_values = gets.chomp

# 標準入力からプレイヤーの打数を受け取る
player_values = gets.chomp

# ゴルフスコアを計算して出力
golf = Golf.new(par_values, player_values)
golf.golf_score
