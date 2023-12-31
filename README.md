# RANDOM NOTES
​
[![Image from Gyazo](https://i.gyazo.com/c00ee939f5571f4f3ccf6169d61dea92.png)](https://gyazo.com/c00ee939f5571f4f3ccf6169d61dea92)
## サイト概要
### サイトテーマ
日々の学習の記録やアウトプット、備忘録などを投稿できる学習アプリです。   

### テーマを選んだ理由
これまで日記をつけたりすることもなく、過去に学習事を忘れてしまう事が増えてきました。
学習したことのアウトプットや、備忘録などを投稿し過去の振り返りができれば便利だと考えました。
様々なユーザーの投稿で課題の解決のヒントになったり、困っている人の助けになると考えテーマにしました。
​
### ターゲットユーザ
- 自身の振り返りをしたい人
- 何かの課題に困っている人

### 主な利用シーン
- 学習したことのアウトプット、振り返り、復習時
- 日記や備忘録として利用

[![Image from Gyazo](https://i.gyazo.com/04bfed211eb1201d9cb96892ead9a86f.png)](https://gyazo.com/04bfed211eb1201d9cb96892ead9a86f)
[![Image from Gyazo](https://i.gyazo.com/6603084d922917e7befad677556e4341.png)](https://gyazo.com/6603084d922917e7befad677556e4341)
​
## 設計書

### AWS構成図

[![Image from Gyazo](https://i.gyazo.com/39c3e655bebf20c1d2de42ee78515d4e.png)](https://gyazo.com/39c3e655bebf20c1d2de42ee78515d4e)

## ER図

[![Image from Gyazo](https://i.gyazo.com/02bc4101c3ba74c04b93b76cccefb3ce.png)](https://gyazo.com/02bc4101c3ba74c04b93b76cccefb3ce)
​
### 機能一覧

- User側
　
    - ゲストログイン機能
    - 会員機能
    - 投稿機能
        - マークダウン記法
    - 投稿検索機能（キーワード）
    - いいね機能
    - いいね一覧機能
    - コメント機能
        - マークダウン記法
    - フォロー機能
    - ユーザー検索機能
    - 通知機能

- 管理者側
　　
    - ユーザー管理機能
    - ユーザーコメント管理

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
​

