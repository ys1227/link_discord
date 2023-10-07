# link_discord

## サービス概要
このサービスはDiscordで集まる人を募集し、集まる時間を調整するためのマッチングアプリです。  
集まる人を募集したいユーザーは主に質問や雑談といった集まる目的を設定し、集まることができる時間を投稿して、Discordで集まる人を探すことができます。  
投稿を見たユーザーは予約システムの機能を使ってスムーズにDiscordに集まる時間調整を行うことができます。

## このサービスへの思い・作りたい理由
このサービスを思いつく原体験となるエピソードは2つあります。  
1つ目にRUNTEQで学習時にオンラインなので実際に会ったことがない人も多く、質問したい、雑談したいと思ってもMattermostやXなどでリプを送りお誘いすることにハードルを感じていました。  
また、CREDOなどの行動指針やプログラミング学習において、質問に答えて言語化したり受講生同士で交流することは大切だということはわかっていましたが、質問があり困っている人などを見つけることがあまりできずにいました。  
以上の理由から気軽にDiscord上で受講生同士でマッチできるサービスを作りたいと思いました。  
2つ目の理由として日常生活において日程調整をLINEやTwitterでテキストでのやり取りを通して時間を調整するのが手間だと思っていました。  
そのためテキストでのやり取りを通じでのストレスを極力感じることなく日程調整ができるサービスを作りたいと思っていました。  
この主に２つの原体験から予約機能とマッチング機能を持ったサービスを作りたいと感じるようになりました。  

## ユーザー層について
ユーザー層はRUNTEQ生です。  
具体的には、
* プログラミング学習でエラーなどがでて受講生に質問や相談がしたい方
* 雑談をしたい方
* 面接対策を行いたい方
などがユーザーとして設定できるかなと思っています。  
私自身プログラミング学習中にもっと交流しておけばよかったなと感じることも多かったので、受講生に使っていただきたいという思いがありサービスのユーザー層に設定させていただきました。


## サービスの利用イメージ
以下のようなサービスの利用イメージを考えています。  
Discordで集まる人を募集したいユーザーAは以下の項目を設定。　　
1. 集まるテーマの内容
2. 集まることが可能な時間帯
3. 募集期限  

集まる人を探している別のユーザーBは投稿一覧画面から気になるテーマの投稿を選び、"気になる"などボタンを押すと予定調整画面へ移動。  
予定調整システムによって集まる時間を調整。  
予定時間が決まったらLINE通知機能などの通知システムで通知を行い、同時に投稿をクローズする。  

## ユーザーの獲得について
XやMattermostで宣伝することを考えています。  
また募集者と応募者の予定調整が完了したらXなどに"〜時から,このテーマで集まります"といった投稿を行う機能をつけることで、サービスの宣伝になるのではないかと考えています。  

## サービスの差別化ポイント・推しポイント
類似サービスは存在しませんでした。  
このサービスの強みとしては、テキストメッセージで予定を調整するのではなく予約システムを活用してスムーズに予定を調整できる点が強みだと感じています。  

## 機能候補
### MVPリリース
1. ユーザー新規登録機能
2. ログイン機能
3. パスワードリセット機能
4. 投稿機能(index/show/create/update/edit/destroy/new)
5. マッチング機能(1対複数人で時間を調整できる機能を今のところ考えています)
6. LINE通知機能
7. フォロー/ フォロワー機能
8. カテゴリ設定機能
9. カテゴリ検索機能
10. 利用規約
11. プライバシーポリシー

### 本リリース
1. WebSocket/ActionCaboleなどでチャット機能導入
2. LINE通知機能でマッチングが成立した際にLINEで通知が届くように設定。
3. 投稿一覧画面についてフォローしている人の投稿が上位に表示されるようにアルゴリズムなどを設定。


### マッチング機能の詳細
ユーザーは募集期限と集まりたいテーマ(質問や雑談など)の内容と集まることが可能な時間(3日間ほど)、を設定しマッチできる人を募集します。  　
別のユーザーBは"気になる"などのボタンで時間を設定します。  
ユーザーAの投稿に対してユーザーBが時間を選択するときはユーザーAが選んだ時間帯が表示されそこからBが選択できるようにします。  
もしユーザAとBの時間調整後ユーザーCが現れたらAとBで調整した時間から選択できるようにしようと考えています。  
同時にBとCがユーザーAの投稿に対して時間設定をしようとした場合についてですが、以下の方法で対策を考えています。  
1. ActiveRecordのロック機能(オプティミスティックロックや悲観的ロックを使い実装)
2. WebSocketを使ったリアルタイムでの情報共有  

最終的に募集期限までユーザー募集し期限に達したら質問をクローズします。(人数が集まらなかった場合は再度オープンするかクローズするかの選択をユーザーが選択できるようにします。)  


## 使用予定の技術
### フロントエンド
* JavaScript
* React (実装するかは未定。一旦Railsで実装して、Reactキャッチアップ後開発にかかる時間やレベルの面できそうなら使用したいと思っています。)
### バックエンド
* Rails: 7.0.7
* Ruby: 3.1.2
* データベース: PostgreSQL
### インフラ
* Render
* AWS S3
### その他使用予定の技術
* LINE通知: LINE Messaging API
* チャット機能: WebSocket(ActionCable)
* 予約システム: simple_calendar(gem)