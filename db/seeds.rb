EMAIL = 'test@example.com'
PASSWORD = 'password'
NAME = 'テストユーザ'

ADMIN_EMAIL = 'admin@example.com'
ADMIN_PASSWORD = 'password'

# テストユーザーが存在しないときだけ作成
User.find_or_create_by!(email: EMAIL) do |user|
  user.password = PASSWORD
  user.name = NAME
  puts 'ユーザーの初期データインポートに成功しました。'
end

# 管理者が存在しないときだけ作成
AdminUser.find_or_create_by!(email: ADMIN_EMAIL) do |user|
  user.password = ADMIN_PASSWORD
  puts '管理者の初期データインポートに成功しました。'
end

# ニューステーブルに初期データを投入
Information.destroy_all
ImportCsv.information_data