![Discordで集まろう (1)](https://github.com/ys1227/link_discord/assets/132570742/711e1f67-b71d-4ce3-8770-602e414acee9)

<br />

## 🚀サービスのURL🚀
ゲストログイン機能を実装いたしましたので、RUNTEQスクール生以外でもお試しでお使いいただくことができます。  
https://link-disco.onrender.com/

<br />

## 🚀サービスへの想い🚀
私はRUNTEQというプログラミングスクールに通っています。  
RUNTEQではカリキュラムなどで分からない問題があったときや、就職活動等の話を受講生同士で相談し合いたい時に、ビデオ通話・音声通話でのコミュニケーションツールであるDiscordを用いることがよくあります。  
その際に私は2つの不便を感じていました。  
1. オンラインスクールであるため、気軽にDiscrodで集まる人を募集するハードルが高いという問題  
2. Xなどで投稿を通じで募集を行う人が多かったが、SNSのコメント欄などで、日程調整をすることが手間になるという問題

これらの問題を解決し、受講生同士が気軽に学習や就職活動の相談を行うことができればと思い、  
Discordに集まる日程や時間を調整できる日程調整アプリとして「Link_Disco」を作成しました。  

<br />  

## 🚀アプリケーションのイメージ🚀

<br /> 
<br />

![demo](https://raw.github.com/wiki/ys1227/link_discord/images/way_of_use.gif)

<br />  
<br />  

## 機能一覧
| トップ画面 |　ログイン画面 |
| ---- | ---- |
| ![Top画面](https://raw.github.com/wiki/ys1227/link_discord/images/01_top.png) | ![ログイン画面](https://raw.github.com/wiki/ys1227/link_discord/images/02_login_discord.png) |
| 登録せずにサービスをお試しいただくためのゲストログイン機能を実装しました。 | Discordによる外部認証機能を実装しました。 |

| ログイン制限 |　ゲストログイン機能 |
| ---- | ---- |
| ![ログイン制限画面](https://raw.github.com/wiki/ys1227/link_discord/images/failure_login.png) | ![ゲストログイン画面](https://raw.github.com/wiki/ys1227/link_discord/images/15_guest_login.png) |
| RUNTEQ生のみにログインを制限しました。 | ゲストログイン機能でRUNTEQ生以外でも投稿などの機能をお試しいただけます。 |


| 募集作成画面 |　募集作成画面 |
| ---- | ---- |
| ![募集作成(カテゴリ設定)画面](https://raw.github.com/wiki/ys1227/link_discord/images/05_post.png) | ![募集作成作成画面](https://raw.github.com/wiki/ys1227/link_discord/images/06_post.png) |
| 投稿時に募集するテーマに沿ったカテゴリを設定することができます。 | 募集を行う際のタイトルや内容などを設定できます。 |

| 募集時間投稿画面 |　優先順位設定画面 |
| ---- | ---- |
| ![募集時間投稿細画面](https://raw.github.com/wiki/ys1227/link_discord/images/07_reservations.png) | ![　優先順位設定画面](https://raw.github.com/wiki/ys1227/link_discord/images/08_rank_posts.png) |
| 募集時間を第三希望まで設定できます。 | 希望時間に対して優先順位を設定できます。 |

| 投稿確認画面 |　投稿一覧画面 |
| ---- | ---- |
| ![投稿確認画面](https://raw.github.com/wiki/ys1227/link_discord/images/09_confirmanation.png) | ![　投稿一覧画面](https://raw.github.com/wiki/ys1227/link_discord/images/10_post.png) |
| 時間と優先順位に関して最終確認を行うことができます。 | 投稿一覧画面から受講生が募集しているテーマを探しに行くことができます。 |


| 投票画面 |　集合時間確認画面 |
| ---- | ---- |
| ![投票画面](https://raw.github.com/wiki/ys1227/link_discord/images/11_reservations.png) | ![　集合時間確認画面](https://raw.github.com/wiki/ys1227/link_discord/images/12_matching_time.png) |
| 受講生が参加したい時間に対して投票できるようになっています。 | アプリケーションで決定した集合時間を確認することができます。 |

| チャット画面|　DiscordへのDM送信画面 |
| ---- | ---- |
| ![チャット画面](https://raw.github.com/wiki/ys1227/link_discord/images/14_chat.png) | ![　DiscordへのDM送信画面](https://raw.github.com/wiki/ys1227/link_discord/images/Discord.png) |
| チャットを行うことができます。 | 集合時間が決定するとDiscordのDMでお知らせを行います。 |

<br />

## 🚀サービスの利用イメージ🚀

### 1. 募集を行う側の操作
![demo](https://raw.github.com/wiki/ys1227/link_discord/images/how_to_use_01.png)

### 2. 参加したい側の操作
![demo](https://raw.github.com/wiki/ys1227/link_discord/images/how_to_use_02.png)

### 3. 締め切り時間到来後の流れ
![demo](https://raw.github.com/wiki/ys1227/link_discord/images/how_to_use_03.png)


## 🚀使用技術🚀

### バックエンド
* Ruby 3.1.4
* Ruby on Rails 7.0.8
* Action Cable
* Sidekiq
* Sidekiq-cron
* Redis

### フロントエンド
* JavaScript
* Tailwind CSS
* Daisy UI

### 外部API
* Discord API

### インフラ
* Render

### データベース
* PostgreSQL
* Redis(バックグラウンド処理とActionCableのアダプタに使用)

### 開発環境
* Docker

<br />

## 🚀ER図🚀
![ER図](https://raw.github.com/wiki/ys1227/link_discord/images/db.svg)

<br />

## 🚀インフラ構成図🚀

![インフラ構成図](https://raw.github.com/wiki/ys1227/link_discord/images/structure.drawio.png)

<br />

### 🚀画面遷移図🚀
Figmaのリンクは[こちら](https://www.figma.com/file/BQ9l33fGotPvEgNMRJQPXY/Link_discord?type=design&node-id=0%3A1&mode=design&t=5bwJwazwzBgvfln8-1)
をご覧ください。

<br />

