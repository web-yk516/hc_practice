# frozen_string_literal: true

# Groupクラスを作成
class Group
  def random
    # ランダムな数字を返す
    group = %w[A B C D E F]
    # 配列を2~4人の長さに分割
    sliced_groups = group.each_slice(rand(2..4)).to_a
    # 分割された配列を改行ありで表示
    sliced_groups.each { |sub_group| p sub_group }
  end
end

group = Group.new
group.random
