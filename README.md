![Discordで集まろう (1)](https://github.com/ys1227/link_discord/assets/132570742/711e1f67-b71d-4ce3-8770-602e414acee9)

<br />

## 🚀サービスのURL🚀
ゲストログイン機能を実装いたしましたので、RUNTEQスクール生以外でもお使いいただくことができます。  
https://link-disco.onrender.com/

<br />

## 🚀サービスへの想い🚀
私はRUNTEQというプログラミングスクールに通っています。  
RUNTEQではカリキュラムなどで分からない問題があったときや、就職活動等の話を受講生同士で相談し合いたい時に、  
ビデオ通話・音声通話でのコミュニケーションツールであるDiscordを用いることがよくあります。  
その際に下記の2つの不便を感じていました。  
1. オンラインスクールであるため、気軽にDiscrodで集まる人を募集するハードルが高いという問題  
2. Xなどで投稿を通じで募集を行う人が多かったが、SNSのコメント欄などで、日程調整をすることが手間になるという問題

これらの問題を解決し、受講生同士が気軽に学習や就職活動の相談を行うことができればと思い、  
Discordに集まる日程や時間を調整できる日程調整アプリとして「Link_Disco」を作成しました。  

<br />  

## 🚀アプリケーションのイメージ🚀

![demo](https://raw.github.com/wiki/ys1227/link_discord/images/way_of_use.gif)

### 🤖RUNTEQ生のみにログインを限定しています。🤖  
(※RUNTEQ生以外の方でもゲストログイン機能を使ってお試しいただけます。)
 
![demo](https://raw.github.com/wiki/ys1227/link_discord/images/failure_login.png)

### 🤖集合時間が決定したらDiscordのDMにお知らせが届きます。🤖
![demo](https://raw.github.com/wiki/ys1227/link_discord/images/13_send_dm.png)

<br />

## 機能一覧
| トップ画面 |　ログイン画面 |
| ---- | ---- |
| ![Top画面](https://raw.github.com/wiki/ys1227/link_discord/images/01_top.png) | ![ログイン画面](https://raw.github.com/wiki/ys1227/link_discord/images/02_login_discord.png) |
| 登録せずにサービスをお試しいただくためのトライアル機能を実装しました。 | ログインIDとパスワードでの認証機能を実装しました。 |

| 募集作成画面 |　募集作成画面 |
| ---- | ---- |
| ![事業者選択画面](https://raw.github.com/wiki/ys1227/link_discord/images/05_post.png) | ![請求書作成画面](https://raw.github.com/wiki/ys1227/link_discord/images/06_post.png) |
| 登録済みの複数の事業者の中から、請求書を作成したい事業者を選択する機能を実装しました。 | 請求書の作成機能・マスタデータの呼び出し機能・税率変更機能・税率別内訳の計算機能、合計金額の計算機能を実装しました。 |

| 予約時間投稿画面 |　優先順位設定画面 |
| ---- | ---- |
| ![請求書詳細画面](https://raw.github.com/wiki/ys1227/link_discord/images/07_reservations.png) | ![　PDF出力画面](https://raw.github.com/wiki/ys1227/link_discord/images/08_rank_posts.png) |
| 請求書データの表示機能を実装しました。 | PDFでの請求書発行機能を実装しました。 |

|  |　マスタの登録画面 |
| ---- | ---- |
| ![請求書詳細画面](/docs/img/app-view/select-master_1.1.png) | ![　PDF出力画面](/docs/img/app-view/master-register-form_1.1.png) |
| 事業者情報と備考欄情報のマスタ登録機能を実装しました。 | マスタ情報の登録をすることで、請求書の作成時にデータを呼び出すことができます。 |

<br />
## 🚀サービスの利用イメージ🚀
以下のようなサービスの利用イメージを考えています。  
Discordで集まる人を募集したいユーザーAは以下の項目を設定。　　
1. 集まるテーマのカテゴリとカテゴリに対するおおまかな内容
2. 集まることが可能な時間帯(第三希望まで)
3. 予約時間の希望順位

集まる人を探している別のユーザーBは投稿一覧画面から気になるテーマの投稿を選び、"参加できる"ボタンを押します。  
締め切り時間が来たら予定調整システムによって集まる時間を調整し。  
予定時間が決まったらDiscordのDMで通知を行います。 

## 🚀ユーザーの獲得について🚀
XやMattermostで宣伝することを考えています。  
また募集者と応募者の予定調整が完了したらXなどに"〜時から,このテーマで集まります"といった投稿を行う機能をつけることで、サービスの宣伝になるのではないかと考えています。  

## 🚀サービスの差別化ポイント・推しポイント🚀
類似サービスは存在しませんでした。  
このサービスの強みとしては、テキストメッセージで予定を調整するのではなく予約システムを活用してスムーズに予定を調整できる点が強みだと感じています。  

## 🚀機能一覧🚀
1. ユーザー新規登録機能
2. ログイン機能
3. 投稿機能(index/show/create/update/edit/destroy/new)
4. 予約機能
5. 投票機能
6. RedisとSidekiqで非同期処理
7. SidekiqーcronでJobを設定する機能
8. カテゴリ設定機能
9. カテゴリ検索機能
10. Discord通知機能でマッチングが成立した際にDMで通知が届くように設定。
11. 利用規約
12. プライバシーポリシー
13. WebSocket/ActionCaboleでチャット機能導入


### 🚀マッチング機能の詳細🚀
ユーザーは募集期限と集まりたいテーマ(質問や雑談など)の内容と集まることが可能な時間帯(第三希望まで)を設定しマッチできる人を募集します。  　
募集が開始されたら希望時間の中から一番速い時間の12時間前まに募集締め切り時間が自動で設定されます。
別のユーザーBは"参加できる"ボタンで集まることが可能な時間を設定し投票します。  
締め切り時間がきたら1番投票人数が多かった時間帯で集合時間が決定し
集合時間を参加者と募集社にDiscordのDMでお知らせします。

## 🚀使用予定の技術🚀
### フロントエンド
* JavaScript
* React (実装するかは未定。一旦Railsで実装して、Reactキャッチアップ後開発にかかる時間やレベルの面できそうなら使用したいと思っています。)
### バックエンド
* Rails: 7.0.7
* Ruby: 3.1.2
* データベース: PostgreSQL
* Redis
### インフラ
* Render
### その他使用予定の技術
* Discord通知: LINE Messaging API
* チャット機能: WebSocket(ActionCable)


### 🚀画面遷移図🚀
https://www.figma.com/file/BQ9l33fGotPvEgNMRJQPXY/Link_discord?type=design&node-id=0%3A1&mode=design&t=aKdGn3DPRintsHKm-1

### 🚀ER図🚀
![ER図](./link_discord.svg)
