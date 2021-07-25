アプリ概要
---

このアプリを作った背景
---

URL
---

機能一覧
---
Stop Sweetsに付けた全ての機能は以下の**14機能**です。

| No   |     機能      |
| --- | ----------- |
| 1    | ログイン機能 |
| 2    | ゲストログイン機能 |
| 3    | いいね機能(Ajax) |
| 4    | コメント機能(CRUD) |
| 5    | 検索機能 |
| 6    | ランキング機能 |
| 7    | アカウント登録機能 |
| 8    | 管理者機能 |
| 9    | 画像アップロード機能 |
| 10    | つぶやき機能(CRUD) |
| 11    | マイページ機能 |
| 12    | ニュース機能 |
| 13    | ページネーション機能 |
| 14    | お菓子を食べたことを申告する機能 |
<br> 

何ができるのか
---


工夫した点
---

苦労した点
---

ER 図
---
<br>
<img width="983" alt="スクリーンショット 2021-07-25 17 01 50" src="https://user-images.githubusercontent.com/66200883/126892172-51c2ef14-38eb-4c55-9c11-3fdb39faf0d7.png">


使用技術
---
- 言語：Ruby
- フレームワーク：Ruby on Rails
- テスト：RSpec
- フロント：HTML、CSS、JavaScript(jQuery)、Bootstrap
- ソースコード管理：GitHub
<br>

開発環境
---
- Ruby 2.7.2
- Rails 6.1.3.1
- PostgreSQL 13.2
<br>

ローカル環境へのインストール方法
---
```
$ git clone https://github.com/YokoyamaGen/stop_sweets.git
$ cd stop_sweets
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails db:seed
```
