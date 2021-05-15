# ポスケ！
https://posuke.net/
<img width="800" alt="TOP画面" src="https://user-images.githubusercontent.com/76721500/118369408-2dc22f00-b5de-11eb-9e97-4fa1a6b35142.png">


## サイト概要
スケジュールを発信する、企業向けコミュニケーションアプリ

## サイトテーマ
* 在宅勤務の支援
* 情報資産の保存・活用

## テーマを選んだ理由
前職で在宅勤務を行っている中で、以下３点の問題が有ると日々感じ、それを解消するにはどうすれば良いかを自分なりに考えたため

* `コミュニケーションが取りにくい`<br>
  社内で顔を合わせることにより、単純接触効果の影響もあり、同期、先輩、後輩問わず関係性を作りやすい状態であったが、
在宅勤務導入後、会うことが少なくなったことにより、コミュニケーションが取れず、関係性の構築が難しい。
* `管理者が部下の管理をしにくい`<br>
社内に全員がいる場合は、気軽に状況を確認できるため、管理がしやすかったが、
在宅勤務導入後、部下が現在なにの業務についているのかが把握しにくい。
また、電話などで確認をする場合、時間がかかる上に、部下が過度な管理をされていると感じてしまう可能性がある。
* `将来像の想像が難しくなっている`<br>
社内にいる際は、先輩社員の動きを見ながら、
数年後自分自身がどのような業務をこなしていないといけないかなどが想像できる状態であったが、
在宅勤務導入後、先輩社員が日々どのような動きをとっているかが把握できないため、キャリアプラン構築の妨げになっている

## ターゲットユーザ
在宅勤務を導入しているが、管理・コミュニケーションに課題のある企業様

## 主な利用シーン
就業中

## アプリ制作をする上で意識したこと
* `デザイン面`<br>
  企業向けのアプリであるため、誠実さを出すためにサイトのベースの色を青にし、直感的に分かりやすいサイトを実現するために、シンプルなデザインを心がけました。<br>
* `動作面`<br>
ページの遷移などでユーザーがストレスを感じないよう、一部ページにAjaxを取り入れ、ページ遷移速度の向上のためN+1問題に取り組み、ページネーション機能も導入しました。<br>
また、サイトとしてバグが無いことを心がけるため、rspecを用いたテストを作成し、Github Actionを用いて、デプロイ前にテストを実行させることで、バグがある状態でデプロイされる状況を極力減らす事を意識しました。

#### 制作する上で考慮した内容を一部Qiitaに記事としてあげております
- リファクタリング <br>
https://qiita.com/dym330/items/97f3f321ce15519f5fd4
- N+1問題への対応 <br>
https://qiita.com/dym330/items/6e7e221ab3554bae2338

## 開発環境
- ruby 2.5.7
- Rails 5.2.5

## 取り入れた技術
- ユーザー認証(管理者側：devise使用、従業員側：Railsセッション機能を用いて自作)
- いいね機能、コメント機能、検索機能の非同期通信(Ajax)
- 画像アップロード機能(Refile)
- ページネーション機能(kaminari)
- カレンダー機能(fullcalendar)
- メール送信機能
- レスポンシブ対応
- rspec(model,system)
- dockerを使用しての環境構築（開発環境、本番環境共に使用）
- CI/CD環境構築(Github Action)

## 設計書

### インフラ構成図
<img width="1080" alt="インフラ構成図" src="https://user-images.githubusercontent.com/76721500/118365341-5266d880-b5d7-11eb-9b09-35cd3c9ed8f4.png">

https://drive.google.com/file/d/1oKfXWnROmceo-OkS2OVpP-0TJ2FlFI4z/view?usp=sharing

### ER図
<img width="756" alt="ER図" src="https://user-images.githubusercontent.com/76721500/118365418-b38eac00-b5d7-11eb-9298-17df6c955c8c.png">

https://drive.google.com/file/d/1J083g5GhKvRl37RCvhBGV5qKi7dGFWV5/view?usp=sharing

### テーブル定義書
https://docs.google.com/spreadsheets/d/1CQJZ4Zn5sOrHoryQD-sE346YslO1_767vJN6K16OvDs/edit#gid=939253136

### アプリケーション詳細設計書
https://docs.google.com/spreadsheets/d/1OCWj2ysUtFc_c0q4hQxNEZFyLM_dIpf6iaH1GTgpnj4/edit#gid=839971944

## 使用素材
- ソコスト https://soco-st.com/
- ちょうどいいイラスト https://tyoudoii-illust.com/