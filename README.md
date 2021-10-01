アプリ概要
---
お菓子を止めたいと考えている方をサポートするためのアプリです。

- お菓子を止めた成果の可視化(止めた日数、止めたことによる節約金額、ランキング機能)
- 日々の積み上げを投稿したり、他のユーザの投稿を閲覧・検索・いいね・コメントできる機能
- お菓子を止めるためのノウハウを提供
<br>

このアプリを作った背景
---

**自分が困った経験から、同様の悩みを持っている人の力になりたいと思ったからです。**　2年前までストレス発散のため、お菓子、ジュースなどを毎日飲食しており、その習慣を続けたことによって、虫歯や肌荒れなどになってしまいました。
虫歯で食べたいものを食べたい時に食べれないことや肌荒れで見た目に自信が持てなかった経験を通して、 **健康の大切さを痛感し、生活習慣を改めようと思い、改善に取り組みました。** 改善に取り組んでみて、苦労した点は以下です。
- **モチベーションの維持**
- **お菓子を止める方法の情報収集に時間がかかってしまう**

上記のような点を解決できるアプリがあれば、もっと効率的に同様の悩みを抱えている人の役に立つと思い、アプリを開発しました。<br><br>


工夫した点
---

### ①アプリを後から利用開始したユーザに対してもモチベーション維持に配慮した点です。

オリジナルアプリを作成するにあたり、既存の習慣化サービスを使用してみて感じたことは、 **ランキング機能の上位を占めていたのは昔からサービスを使用しているユーザでしたため、それだと後からサービスを利用するユーザのモチベーション維持には繋がらないのでは、と思いました。** 既存サービスのランキングを決める基準がサービス利用開始から現在までのサービス利用日数のため、後からサービスを利用開始するユーザもランキングで上位になる可能性が十分にあるようにしたいと思い、以下の点を他のサービスと差別化しました。

- **1ヶ月単位でお菓子を止めた日数を元にランキングを表示** <br><br>
![demo](https://gyazo.com/5b2587e9e4a7872cbc8c679565ebe6c0/raw)
<br><br><br>

- **お菓子をユーザが食べてしまった日には食べてしまったことを申告できる機能を実装することで、ランキングに変動が発生**　　<br><br>
![demo](https://gyazo.com/715b46fb433d799f798803f9853a4471/raw)
<br>

### ②ユーザがアプリを快適に操作できるように、N＋１問題を解消し、パフォーマンス改善をしたことです。
コードエディタのコンソール画面にて、アプリから発行されるSQLからN＋1問題が発生していないかを確認するだけでなく、gem「bullet」を導入することで、目視で発見することができなかった問題に対してもアプローチ致しました。具体的には、いいね機能にて、いいねの数を表示するために「count」を使用していた箇所を「size」に変更することで、パフォーマンスを改善致しました。


### ③アプリの品質を向上させるためにRspecを合計110ケース実施した点です。
モデルスペック、リクエストスペックを実装することで、アプリの品質を向上するように致しました。テストを実施する際に境界値分析法を意識したことや自身でサービスを利用してみることでバグを発見して、改善することで品質を向上致しました。

<br>

苦労した点
---

### 月初にバッチ処理を稼働させてたいと考えていたが、Herokuのスケジューラーサービスになかったため、別の方法で実装したことです。

先月にユーザがお菓子を食べてしまった日数を月初にクリアする処理をバッチ処理で実装するようにいたしました。バッチ処理を実装するにあたり、Herokuではgem「whenever」が使用できなかったため、Heroku schedulerを使用することを検討しました。Heroku schedulerで設定可能なバッチ処理の起動タイミングは毎日１回で、月１回はございませんでしたが、**どうやったら実装できるかを諦めずに考えました。**　想定した実装方法がないかを情報収集していく中で、Heroku schedulerで毎日１回起動させるようにして、月初だったら、お菓子を食べてしまった日数をクリアする処理を動かすようにしました。**実装するにあたり、情報の正しさを検証するために、簡単なバッチ処理を実装して動かしてみることで、誤った情報による手戻りを防ぐことを致しました。また、実装するにあたり、なるべくタスクを分解して、実装できた箇所をこまめに動かすことで、エラーが発生した場合でも原因を特定しやすいように致しました。** 結果として、想定した通りに月初にお菓子を食べてしまった日数をクリアする処理を実装できました。この経験を通して、実装したい内容がサービスの仕様になかった場合でも他のやり方はないのかを考えて実装することの大切さを学びました。
<br><br>

URL
---

https://stop-sweets.herokuapp.com/
<br><br>

機能一覧
---
Stop Sweetsに付けた全ての機能は以下の**19機能**です。

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
| 14    | お菓子を止めたことによる節約金額の算出機能 |
| 15    | お菓子を食べたことを申告する機能 |
| 16    | Rspecテスト実装 |
| 17    | 月１回申告件数リセット機能 |
| 18    | Markdown機能 |
| 19    | CSVインポート機能 |

<br> 

ER 図
---
<br>
<img width="1105" alt="スクリーンショット 2021-07-30 18 36 40" src="https://user-images.githubusercontent.com/66200883/127634324-904f247a-b5f6-4443-87e9-765493726d2a.png">


使用技術
---
- 言語：Ruby
- フレームワーク：Ruby on Rails
- テスト：RSpec
- フロント：HTML、CSS、JavaScript(jQuery)、Bootstrap
- インフラ：Heroku、AWS(S3、IAM、CloudFront）
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
