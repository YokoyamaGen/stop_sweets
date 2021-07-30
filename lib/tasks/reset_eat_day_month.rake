namespace :reset_eat_day_month do
  desc "usersテーブルのeat_day_monthをリセットする"
  task reset: :environment do
    begin
      user = User.all
      user.update(eat_day_month: 0)
      puts "リセット完了"
    rescue StandardError => e
      # 例外が発生した場合の処理
      # リセットできなかった場合の例外処理
      puts "#{e.class}: #{e.message}"
      puts "-------------------------"
      puts e.backtrace # 例外が発生した位置情報
      puts "-------------------------"
      puts "リセットに失敗"
    end
  end
end
