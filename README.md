# HASH

<img width="1440" alt="トップ画面" src="https://user-images.githubusercontent.com/72389074/100235525-e2548f80-2f6f-11eb-9a5c-e6b268724936.png">



## ◆アプリケーションURL
[https://hash-app-3869.herokuapp.com/](https://hash-app-3869.herokuapp.com/)



## ◆テストアカウント
nickname: ゲスト
email: test@test
password: test1234



## ◆概要(このアプリでできることを書いて下さい)
ノート（メモ帳）アプリでユーザーの情報を管理する手助けをします。
・ノートにタグをつけた管理機能
・ノートは公開/非公開を選ぶことで他のユーザーへの共有を選択



## ◆制作背景(意図)
仕事上やプログラミングを学習する上で様々な情報を調べたり、得た情報をまとめていた時にこのアプリの着想を得ました。
ブックマークや通常のメモ帳などでは情報を整理しにくく、一部の情報を他人にも共有したい時などチャットやメールを介して情報を送ることが手間だと感じていました。
これらの問題を解決したいと考え、情報の管理がしやすいノートアプリを作りたいと思ったことが制作背景となります。



## ◆DEMO

### ・トップ画面
<img width="1440" alt="トップ画面" src="https://user-images.githubusercontent.com/72389074/100235525-e2548f80-2f6f-11eb-9a5c-e6b268724936.png">


### ・新規登録画面
<img width="1440" alt="新規登録画面" src="https://user-images.githubusercontent.com/72389074/100235464-d10b8300-2f6f-11eb-886e-75ba7b75c1e4.png">


### ・ログイン画面
<img width="1440" alt="ログイン画面" src="https://user-images.githubusercontent.com/72389074/100235485-d5d03700-2f6f-11eb-9998-a351051c8c9c.png">


### ・ユーザー情報編集画面
<img width="1440" alt="ユーザー情報編集画面" src="https://user-images.githubusercontent.com/72389074/100235497-d8329100-2f6f-11eb-8a70-b1e2ba4663d3.png">


### ・ノート編集画面
<img width="1440" alt="ノート編集画面" src="https://user-images.githubusercontent.com/72389074/100235565-ef717e80-2f6f-11eb-85a2-5c85602d508f.png">


### ・タイトル検索結果(ユーザーページ)
<img width="1440" alt="タイトル検索結果(ユーザーページ)" src="https://user-images.githubusercontent.com/72389074/100235640-044e1200-2f70-11eb-8776-6f7adcb55d79.png">


### ・テキスト検索結果(ユーザーページ)
<img width="1440" alt="テキスト検索結果(ユーザーページ)" src="https://user-images.githubusercontent.com/72389074/100235682-1039d400-2f70-11eb-9129-ed001e47df84.png">


### ・タグ検索結果(ユーザーページ)
<img width="1440" alt="タグ検索結果(ユーザーページ)" src="https://user-images.githubusercontent.com/72389074/100235659-0c0db680-2f70-11eb-99b7-f573efb723f5.png">


### ・公開ノート一覧画面
<img width="1440" alt="公開ノート一覧画面" src="https://user-images.githubusercontent.com/72389074/100235610-fac4aa00-2f6f-11eb-820d-433e2ef43ad7.png">


### ・公開ノート詳細画面
<img width="1440" alt="公開ノート詳細画面" src="https://user-images.githubusercontent.com/72389074/100235618-fd270400-2f6f-11eb-9c85-4af4defab367.png">


### ・タイトル検索結果(公開ノート)
<img width="1440" alt="タイトル検索結果(公開ノート)" src="https://user-images.githubusercontent.com/72389074/100235651-09ab5c80-2f70-11eb-93bc-b49edacca383.png">


### ・テキスト検索結果(公開ノート)
<img width="1440" alt="テキスト検索結果(公開ノート)" src="https://user-images.githubusercontent.com/72389074/100235695-129c2e00-2f70-11eb-9763-48b64e2b749e.png">


### ・タグ検索結果(公開ノート)
<img width="1440" alt="タグ検索結果(公開ノート)" src="https://user-images.githubusercontent.com/72389074/100235667-0dd77a00-2f70-11eb-88ac-d3a570da7e59.png">



## ◆工夫したポイント
なるべくシンプルにして使いやすくしたいと考え、各ページの画面変化が少ないように構成しています。
ユーザーがノートを整理しやすいように各ノートはいくつもタグを持つことができるよう設定し、ノートの検索がしやすいよう検索機能をタイトル、テキスト、タグそれぞれで検索できるようにしています。
様々なデバイスから操作できるようスマートフォンやタブレットにもレスポンシブ対応しました。



## ◆開発環境
MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)
macOS Catalina 10.15.7
VSCode



## ◆使用技術
Ruby 2.6.5
Rails 6.0.0
JavaScript
MySQL2
Rubocop / Rspec 
GitHub / GitHubDesktop



## ◆ローカルでの動作方法
ターミナルより以下の操作となります。
% git clone https://github.com/shimon3104/hash_app.git
% cd hash_app
% bundle install
% rails db:create
% rails db:migrate



## ◆課題や今後実装したい機能
よりユーザーが使いやすくなるように各コンテンツの配置やデザインの見直しを行いUI/UXの向上を図りたいと考えています。
また、本番環境へのアクセススピードの向上を図るためAWS(EC２)などのインフラ技術を導入していきます。



## ◆DB設計

### ・ER図
![hash drawio](https://user-images.githubusercontent.com/72389074/100239893-49c10e00-2f75-11eb-9d84-ea5142ee3f7f.png)


### ・users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |


#### Association
- has_many :notes



### ・notes テーブル

| Column  | Type       | Options                           |
| ------- | ---------- | --------------------------------- |
| title   | string     | null: false                       |
| text    | text       | null: false                       |
| status  | integer    | default: 1, null: false, limit: 1 |
| user    | references | null: false, foreign_key: true    |


#### Association
- belongs_to :user
- has_many :note_tag_relations
- has_many :tags, through: note_tag_relations



### ・tags テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| name    | string     | null: false, uniqueness: true  |


#### Association
- has_many :note_tag_relations
- has_many :notes, through: note_tag_relations



### ・note_tag_relations テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| note   | references | null: false, foreign_key: true |
| tag    | references | null: false, foreign_key: true |


#### Association
- belongs_to :note
- belongs_to :tag