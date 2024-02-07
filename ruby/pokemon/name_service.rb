# frozen_string_literal: true

# NameServiceモジュールを作成
module NameService
  def change_name(new_name)
    # 不適切な名前はエラー
    if new_name == 'うんこ'
      puts '不適切な名前です'
      return
    end
    @name = new_name
  end

  def name
    @name
  end
end
