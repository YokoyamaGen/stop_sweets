アプリ概要
---
お菓子を食べることを止めたいと考えている方をサポートするためのアプリです。

- お菓子を止めた成果の可視化(止めた日数、止めたことによる節約金額、ランキング機能)
- 日々の積み上げを投稿したり、他のユーザの投稿を閲覧・検索・いいね・コメントできる機能
- お菓子を止めるためのノウハウを提供
<br>

URL
---

https://stop-sweets.work
<br><br>

このアプリを作った背景
---

**自分が困った経験から、同様の悩みを持っている人の力になりたいと思ったからです。**　2年前までお菓子、ジュースなどを毎日飲食しており、その習慣を続けたことによって、虫歯や肌荒れなどになってしまいました。
虫歯で食べたいものを食べたい時に食べれないことや肌荒れで見た目に自信が持てなかった経験を通して、 **健康の大切さを痛感し、生活習慣を改めようと思い、改善に取り組みました。** 改善に取り組んでみて、苦労した点は以下です。
- **モチベーションの維持**
- **お菓子を止める方法の情報収集に時間がかかってしまう**

上記のような点を解決できるアプリがあれば、もっと効率的に同様の悩みを抱えている人の役に立つと思い、アプリを開発しました。<br><br>


工夫した点
---

### ①アプリを後から利用開始したユーザに対してもモチベーション維持に配慮した点です。

オリジナルアプリを作成するにあたり、既存の習慣化サービスを使用してみて感じたことは、 **ランキング機能の上位を占めていたのは昔からサービスを使用しているユーザでした。そのため、後からサービスを利用するユーザのモチベーション維持には繋がらないのでは、と思いました。** 既存サービスのランキングを決める基準がサービス利用開始から現在までのサービス利用日数のため、後からサービスを利用開始するユーザもランキングで上位になる可能性が十分にあるようにしたいと思い、以下の点を他のサービスと差別化しました。

- **1ヶ月単位でお菓子を止めた日数を元にランキングを表示** <br><br>
![demo](https://gyazo.com/5b2587e9e4a7872cbc8c679565ebe6c0/raw)
<br><br><br>

- **お菓子をユーザが食べてしまった日には食べてしまったことを申告できる機能を実装することで、ランキングに変動が発生**　　<br><br>
![demo](https://gyazo.com/715b46fb433d799f798803f9853a4471/raw)
<br>
今月にお菓子を食べてしまったトータル日数は翌月の月初にクリアする仕様になっております。クリアをするために、毎月の月初0時にお菓子を食べてしまった日数をクリアするスケジュール起動の処理をgem「whenever」を使用して、実装しております。
<br><br>

### ②ユーザがアプリを快適に操作できるように、N＋１問題を解消し、パフォーマンス改善をしたことです。
コードエディタのコンソール画面にて、アプリから発行されるSQLからN＋1問題が発生していないかを確認するだけでなく、gem「bullet」を導入することで、目視で発見することができなかった問題に対してもアプローチ致しました。具体的には、いいね機能にて、いいねの数を表示するために「count」を使用していた箇所を「size」に変更することで、パフォーマンスを改善致しました。

<br>

### ③アプリの品質を向上させるためにRspecを合計120ケース以上実施した点です。
モデルスペック、リクエストスペックを実装することで、アプリの品質を高めました。テストを実施する際に正常系、異常系、境界値を意識したことや自身でサービスを利用してみることでバグを発見して、改善することで品質を向上致しました。例えば、ユーザ情報の名前やメールアドレス、つぶやき機能における投稿において、規定した文字数以上の場合やブランクを禁止していた箇所にブランクで入力した場合、想定通りにエラーメッセージが出力されるようになっているかを確認致しました。また、他の方にもアプリを使用していただき、以下のようにユーザが存在しないURLを入力した場合でもエラーハンドリングするように致しました。
<br><br>
![Image from Gyazo](https://gyazo.com/7512965d3f81ad4f209ce2b54af7c72d.gif)

<br>

### ④ランキング機能をSQLで実装した点です。
全ユーザのお菓子を止めた日数でランキングを表示する機能を実装するにあたり、当初はActive Recordで実装しようとしましたが、ランキング機能を実装するのに必要なランキングづけや四則演算などが見当たらなかったため、SQLを用いて実装しました。実装したい内容をまずテキストに言語化して、言語化した内容を細かく分解して実装しやすい単位に致しました。また、機能を実装するために必要なコマンドをインターネットや書籍で調べた後、開発環境でSQL文を発行することでSQLの理解を深めました。結果として、ランキング機能を実装できました。実装の詳細は以下Qiitaにまとめております。<br>
[Rails + SQLでランキング機能を実装](https://qiita.com/gensan64311466/items/736f594192296bc5bc93)

<br>

苦労した点
---
### AWS(EC2)へのオリジナルアプリのデプロイがうまくいかなかった点です。

Capistranoを使用して、オリジナルアプリをEC2へデプロイが上手くいかず、ブラウザーにURLを入力しても上手くトップページが表示されない事象が発生致しました。エラーが発生した際に特に苦労したのが原因の切り分けに苦労しました。アプリが原因なのか、インフラ側が原因なのかを見極めるのに時間がかかりました。エラーを解決するために、デプロイログやサーバログを確認しましたが、ログメッセージには真因が出ていなかったため、出力されているメッセージを一つ一つ調べることによって、アプリ側が原因であることを突き止めることができ、エラーを解決することができました。この経験から、アプリに関する知識だけでなく、インフラに関する知識も必要であることを実感しました。<br>
今回対応したエラーの詳細につきましては以下Qiitaにまとめております。<br>
[AWSへのデプロイ後、ブラウザー上で「We're sorry, but something went wrong.」と表示された際の対処法](https://qiita.com/gensan64311466/items/304a08fb93ed2b6a900c)

<br><br>

機能一覧
---
Stop Sweetsに付けた全ての機能は以下の**19機能**です。

| No   |     機能      |      Gem      |
| --- | ----------- | ----------- |
| 1    | ログイン機能 | devise |
| 2    | ゲストログイン機能 | - |
| 3    | いいね機能(Ajax) | - |
| 4    | コメント機能(CRUD) | - |
| 5    | 検索機能 | ransack |
| 6    | ランキング機能 | - |
| 7    | アカウント登録機能 | devise |
| 8    | 管理者機能 | Active Admin |
| 9    | 画像アップロード機能 | carrierwave/mini_magick |
| 10    | つぶやき機能(CRUD) | - |
| 11    | マイページ機能 | - |
| 12    | ニュース機能 | redcarpet/rouge |
| 13    | ページネーション機能 | kaminari |
| 14    | お菓子を止めたことによる節約金額の算出機能 | - |
| 15    | お菓子を食べたことを申告する機能 | - |
| 16    | Rspecテスト実装 | rspec-rails/factory_bot_rails/faker |
| 17    | 月１回申告件数リセット機能 | whenever |
| 18    | Markdown機能 | redcarpet/rouge |
| 19    | CSVインポート機能 | - |

<br> 

ER 図
---
<br>
<img width="1105" alt="スクリーンショット 2021-07-30 18 36 40" src="https://user-images.githubusercontent.com/66200883/127634324-904f247a-b5f6-4443-87e9-765493726d2a.png">

<br> 

何ができるのか
---
### トップページ

![Image from Gyazo](https://gyazo.com/a33ab99e25a4e86056d7a0d46ba205df.gif)
<br>
- 最初にトップページへアクセスするとアプリの機能や使用方法、アプリを利用することによるメリットなどを記載<br>
- 「今すぐ始める」ボタンを押すとアカウント登録画面へ遷移<br>
- 「ゲストログイン」ボタンを押すとマイページに遷移<br>
- 画面左上のハンバーガーメニューを押すと、以下のように「アカウント登録」、「ログイン」、「ゲストログイン」ボタンなどが表示<br><br>

![Image from Gyazo](https://gyazo.com/d0c062863051294444e7cb8bf943de59.gif)
<br><br><br><br>

### ユーザー登録

![demo](https://gyazo.com/3d3bbfa7b6790bfc974cb6dc7eed2f3d/raw)

- ユーザ名、Eメール、Password、1日のお菓子にかかっている費用を入力して登録
- アカウント登録せずにサービスを利用したい場合は、ゲストログインボタンを押すことで、サービスを利用可能<br><br><br><br>

### ランキング

![Image from Gyazo](https://gyazo.com/08f1841073f6545669321734bebeaed1.gif)
<br>

- アカウント登録したユーザが1ヶ月間お菓子を止めた日数の順位が表示
- ランキングに表示可能なユーザは100名までとする。表示数を制限することにより、アプリのパフォーマンス低下を防ぐため
- ユーザ名をクリックするとユーザの詳細画面が表示
- 上位1位〜3位までは王冠が表示<br><br><br><br>

### つぶやき一覧

![Image from Gyazo](https://gyazo.com/dfe523d353a723d5349e6bc90c421666.gif)
<br>

- つぶやきたい内容を最大140字でつぶやき可能
- 他のユーザのつぶやきに対して、「いいね」や「コメント」を付けることも可能
- 画面右上の検索ボックスに検索したいキーワードを入力して、検索ボタンを押すと検索が可能
- ユーザ名やアイコンボタンを押すことで、ユーザの詳細画面へ遷移
- 以下のように削除、編集ボタンからつぶやいた内容を削除または編集が可能<br><br>

![Image from Gyazo](https://gyazo.com/4dcd2dd1b0c94d1f022140e157b0e2dd.gif)

<br><br><br><br>

### ニュース一覧

![Image from Gyazo](https://gyazo.com/5eabf4f1504b574a59d1e9bdc11f78df.gif)
<br>

- お菓子を止めるために効率的な方法を学ぶことが可能<br><br><br><br>


### マイページ

![Image from Gyazo](https://gyazo.com/ead3ad361acf489c6143a88f2224d753.gif)
<br>

- お菓子を止めた日数や節約金額などを確認可能
- 画面右上の「お菓子を食べた」ボタンを押すことで、お菓子を食べてしまったことを申告可能
- 編集ボタンを押すことで1日にお菓子にかかっている費用やユーザアイコンなどを変更可能。ただし、ゲストユーザは編集および削除できない仕様
- 削除ボタンでユーザを削除可能
- つぶやき一覧からユーザの全てのつぶやきを見ることができる
- プロフィールの入力・編集が可能

<br><br>

使用技術
---
- 言語：Ruby
- フレームワーク：Ruby on Rails
- RDBMS：PostgreSQL
- テスト：RSpec
- フロント：HTML、CSS、JavaScript(jQuery)、Bootstrap
- インフラ：AWS(EC2、RDS、Route53、ALB、VPC、S3、IAM、CloudFront、ACM）
- ソースコード管理：Github
- CI/CD：Circle　CI
- その他：Docker
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
$ docker-compose up -d
$ docker-compose exec web bash
$ rails db:create
$ rails db:migrate
$ rails db:seed
```
