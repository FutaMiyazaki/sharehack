# Sharehack

## URL：[Sharehack](https://share-hack.com)

ゲストユーザーとしてログインが可能です。アカウント情報の変更や削除、投稿削除以外の機能は利用可能となっています。

<br>

## トップページ

![スクリーンショット 2021-07-26 22 09 28](https://user-images.githubusercontent.com/74496398/126994183-8ccb32fb-9aa4-4adf-9692-dabec20f5acf.png)

## レスポンシブ対応

![スクリーンショット 2021-07-26 22 27 30](https://user-images.githubusercontent.com/74496398/126996824-263b9a69-6e13-4c27-bc08-49273a795d60.png)

<br>

# 制作の背景

去年の 4 月からひとり暮らしを始めるにあたって、何が必要なのか、何を買っておくべきか、わからないことだらけで苦労しました。その際、ひとり暮らしを初めた人向けのライフハックや便利グッズをまとめた SNS の投稿や、YouTube の動画がとてもためになりました。買ってよかったもの、QOL が上がるもの、便利ガジェットなどが一つにまとっている他、そういった知恵を共有することもできるサイトがあれば、という思いからこのサービスを制作しました。

<br>

# 使用した技術

## フロント

- HTML / CSS
- Javascript
- Nuxt.js 2.15.4 (SPA モード)
- Vuetify (UI フレームワーク)
- Jest (テスト)
- ESLint (静的コード解析ツール)
- Prettier (コードフォーマッター)

<br>

## バックエンド

- Ruby 2.7.2
- Ruby on Rails 6.0.3 (API モード)
- Rspec (テスト)
- Rubocop (静的コード解析ツール)

<br>

## インフラ

| 名称            | 説明                      |
| --------------- | ------------------------- |
| ECS Fargate     | コンテナ基盤              |
| ECR             | Docker コンテナレジストリ |
| VPC             | AWS 内のネットワーク構築  |
| S3              | 画像ファイルの保存        |
| Route53         | ドメイン取得              |
| ALB             | ロードバランサー          |
| RDS             | 本番環境用 DB (MySQL)     |
| ACM             | SSL 証明書発行            |
| Systems Manager | 環境変数管理              |

<br>

## AWS 構成図

![sharehack_aws](https://user-images.githubusercontent.com/74496398/126989102-f749a463-1441-4ad9-90a2-2772d7a4e204.png)

<br>

## 開発環境

- Docker
- Docker-Compose version 3

<br>

# ER 図

![sharehackER](https://user-images.githubusercontent.com/74496398/126988431-50e3b036-6ccf-4221-8790-f3a70ed3cf65.png)

<br>

# 機能一覧

- 基本機能
  - ユーザー認証機能
    - フロントエンド：Auth Module
    - バックエンド：gem「devise_token_auth」
    - Vuex Store (localStorage) による認証情報の管理
  - 投稿 (アイテム・トピック) 一覧表示
    - 各種コンテンツに応じた一覧表示
    - ソート機能 (投稿日時順、いいね数の多い順)
    - ページネーションにて実装
      - フロントエンド：Vuetify
      - バックエンド：Kaminari
  - 検索機能
    - アイテム (投稿)、トピック、タグのキーワード検索
  - 各ユーザーのマイページにて下記情報を参照可能
    - 投稿アイテム
    - いいねした投稿
    - 投稿トピック
    - フォロー
    - フォロワー
- ログイン後に利用可能な機能
  - アイテム投稿 (CRUD) 機能
    - 画像のプレビュー機能
    - フロント側のバリデーション機能
    - タグの新規作成およびリストからの選択が可能
  - タグ機能
    - アイテムにタグを登録可能
    - フロント側のバリデーション機能
    - タグをタップすることで、タグを含むアイテムを一覧表示
  - アイテムへのコメント機能
    - 非同期処理にて実装
    - フロント側のバリデーション機能
    - 未ログインの場合はダイアログにてログイン誘導
  - アイテムへのいいね機能
    - 非同期処理にて実装
    - 未ログインの場合はダイアログにてログイン誘導
    - いいねしたアイテム投稿は、マイページにて確認可能
  - トピック投稿 (CRUD) 機能
    - 掲示板のような効果を目的
    - 投稿したトピックは、マイページにて確認可能
    - フロント側のバリデーション機能
  - ユーザー登録情報の設定
    - プロフィール画像の変更
    - ユーザー名の変更
    - メールアドレスの変更
    - パスワードの変更
    - アカウント削除
  - ユーザーフォロー機能
    - 非同期処理にて実装
    - 未ログインの場合はダイアログにてログイン誘導
  - タイムライン機能
    - フォローしているユーザーのアイテム投稿一覧を表示
