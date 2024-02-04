# frozen_string_literal: true

require 'date'
require 'optparse'

# Calendarクラスを作成
class Calendar
  def initialize(year, month)
    @year = year
    @month = month
  end

  # カレンダーの表示
  def display_calendar
    # 月初日と月末日を取得
    first_day = Date.new(@year, @month, 1)
    last_day = Date.new(@year, @month, -1)
    firstday_wday = first_day.wday
    lastday_date = last_day.day
    wday = firstday_wday
    # カレンダーの見出しを表示
    puts "#{@month}月 #{@year}".center(20)
    # 曜日の作成
    puts '日 月 火 水 木 金 土'
    # 1日までの空白を出力
    print '   ' * firstday_wday
    print_date(lastday_date, wday)
  end

  def validate_month(month)
    month_num = month.to_i
    return month_num if (1..12).include?(month_num)

    raise ArgumentError, "#{month} is neither a month number (1..12) nor a name"
  end

  def print_date(lastday_date, wday)
    # 日付を表示
    (1..lastday_date).each do |date|
      # 1~最終日まで繰り返し
      print "#{date.to_s.rjust(2)} "
      wday = (wday + 1) % 7
      # 土曜日まで表示したら改行
      puts if wday.zero?
    end
    # 最後の日の曜日が0でない場合に改行
    puts unless wday.zero?
  end
end

params = {}
opt = OptionParser.new
opt.on('-m mon') { |v| params[:mon] = v }
opt.parse!(ARGV)

current_year = Date.today.year
month = params[:mon] || Date.today.month
calendar = Calendar.new(current_year, month)
begin
  month = calendar.validate_month(month)
  calendar = Calendar.new(current_year, month)
  calendar.display_calendar
rescue ArgumentError => e
  puts e.message
end
