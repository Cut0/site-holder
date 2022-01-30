## 概要
ブックマークするほどではないけど、後で読んでおきたいようなサイトを気軽に登録できるアプリケーションです。

## 利用方法
- グループ画面
  
  <details>
  <summary>イメージ</summary>
  
  ![IMG_0004](https://user-images.githubusercontent.com/59341902/151720648-c7b9f148-73d9-4f67-896c-d0ee6571df73.png)
  </details>
  - サイトをまとめるグループを作成するページ

- サイト一覧画面

  <details>
  <summary>イメージ</summary>
  
　![IMG_0003](https://user-images.githubusercontent.com/59341902/151720749-ddfb922c-7711-4204-b6cb-81a0868f99d2.png)
  </details>
  - アイテムをクリックすることでサイトに飛べる。
  - アイテムを長押しすることでシェアできる。
  - textBoxにURLを入力することでサイトを登録できる。(一部取得できないサイトも有るため、今後修正する必要がある。)

## 使用した技術
- `Swift UI` :
  宣言的UIにより、開発効率を向上させるために採用
- `OpenGraph`(https://github.com/satoshi-takano/OpenGraph) :
  指定したURLからOGPを取得するために採用

## 反省点
- ユーザの登録したサイトをどのデバイスからもアクセスできるようにサーバーに保持しようと思ったが時間の都合上難しかった。
- 各ビジネスロジックに関してテストコードを書きたかったが技量と時間が足りなかった。
- UIをFigmaで設計してから開発したかった。

## 今後の展望
- ログイン機能とマルチデバイス対応の開発
  - `Firebase Authentication`と`Firebase FireStore`を検討中(金銭的なコストも開発的なコストも低いため)
- UIの改善
