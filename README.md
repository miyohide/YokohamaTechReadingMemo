# 横浜技術書朗読会 読書メモ
## 2015年2月21日（土） Growing Rails Applications In Practice P44 - P54

- modelの肥大化について。関係のあるものをまとめて、サブディレクトリにおいておくという手法を紹介している。
- このリファクタリングしたら、「テーブル名変わるやん」という指摘。
  - `self.table_name =`で指定する必要あり。
- 実際には、サブディレクトリに関連するモデルを置くというのは結構大変な気がする。例えば、複数のモデルから参照されている場合、どこのサブディレクトリに配置するとか。
  - システムにもよるけど、アクセス回数が多いとか、意味合いが似ているとか、ってなぐらいでその場での判断ってケースになりそう。
- P50からはいきなりスタイルシートの話。スタイルシートってやっぱりカオスだよね。

## 2015年2月14日（土） Growing Rails Applications In Practice P33 - P43

- P35で書かれている`User`モデルを修正するのがこの章のテーマ。
- 修正後のソースは、`User`モデルを継承する形で`User::AsSignUp`というモデルを作る
- `User`モデルに`email`を残すのはすべての処理でメールアドレスは共通的にValidationする必要があるからってことかな
- `User::AsSignUp`だけに`password`を持っていくのは、サインアップの時だけパスワードの確認が必要だからってこと
- `acceptance`はチェックボックスのチェックが入っているかどうかをチェックするValidation。
- 継承する方法とは別に、ActiveSupport::Concernでincludeする方法がある。
  - それだとコード量は減るけど、modelのサイズとしては太ったまま。
- 継承する方法で出てくる問題は、P38の箇条書きの部分。
- その問題を解決するのが`ActiveType`。解決方法は継承元を`ActiceType::Record[User]`にするとよい。
- service objectについて。ActiveRecordには無関係なものを取り出して、PlainなRubyのクラスを作る。
- P41に記されたコードをservice objectを使って書き換えたのがP42。
  - 確かにSQL文の組み立てとかは外に出せている。これによってテストがしやすくなってい...る？
- この著者は、modelsの下に新しくディレクトリを作ることが好みっぽいけど、複数のモデルを扱うことを考えたら、servicesディレクトリの中においた方がいいような気がする。

## 2015年2月7日（土） Growing Rails Applications In Practice P22 - P33
- controllerのリファクタリングについて。
- P23に書かれている責務をリファクタリング前では全てコントローラ内で実装している。
- P24ではViewについて。Viewもform_tagを使っていたり、ActiveRecordのメソッドを呼び出したりしていて汚い。
- P25ではActiveTypeを使った場合のViewのリファクタリング結果を表示している。
  - [ActiveType](https://github.com/makandra/active_type)は前回習ったGem。
  - これを使った実装例はこのあと（P26）に出てくる。
  - Viewのリファクタリングでは`form_for`を使って実装できており、項目ごとに繰り返しているだけ。大変シンプル。
- P26ではcontrollerの実装。
  - この人のcontrollerの書き方は、極力同じコードをひとつに纏める感じ。例えば、`build_merge`メソッド。
  - この方針は読書会の中ではあまり評判が良くなかった。
- P26からP27ではActiveTypeを使った実装例。P23で記した責務を一つ一つCallbackとして定義している。
  - Callbackではなく、サービスクラスのように別に分けることもできるけど、この本では1つのソースで。
  - サービスクラスについては、[Qiitaに記事](http://qiita.com/okuramasafumi/items/9d892845c3b135a5593e)があったので、あとで見ておく。
- P30からはFat modelに対する対処について。
- まずは、Fat model自身に対する解説を記している。
- 第6章からはその対策？

## 2015年1月31日（土） Growing Rails Applications In Practice P13 - P22

- Growing Rails Applications In PracticeのP13 Understanding the ActiveRecord lifecycle
- 例に書かれている`accept!`を回避する方法はたくさんある。
- これらの方法を防ぐためには、Avdi Grim著のObjects on Railsのように悪いメソッドを隠蔽してしまう方法がある。が、今回はこの方法を取らない。
- 今回は、P14のコードにあるように、validationとcallbackで実装する。
- callbackについてはP15の囲み記事にあるようにevilと捉えられることもある。このことについては、のちほどの章で対策を記すとのこと。
- P14のコードだけでも、すでに「みにくい」という声が上がった。
  - 前のコードでもそうだが、`Invite`の中で、他のモデルのインスタンスを生成したり操作するというのは違和感があるとのこと。
- P18で突如として出てきた`SignIn`モデルの継承元である`PlainModel`はP21で出てくる。
- だが、[ActiveType](https://github.com/makandra/active_type)というGemを使えば、`SignIn`モデルをP22に書かれるように実装できる。
- [ActiveType](https://github.com/makandra/active_type)と似たようなものに[Virtus](https://github.com/solnic/virtus)というGemがあるようだ。読書会ではこっちを使う人が多かった。
  - 個人的にはどっちも知らなかった。そもそもの使いドコロがピンときていないので、ちゃんと復習しておく。
  - 検索したら、[Railsでフォームオブジェクトを使った検索を簡単に実装する方法](http://techracho.bpsinc.jp/morimorihoge/2013_07_26/12552)が引っかかった。これはわかりやすい。
  - Qiitaに[joker1007さんの記事](http://qiita.com/joker1007/items/90bb12070d9db6f1dc1e)があった。これは似たようなことをやっているGemの比較。

## 2015年1月10日（土）

- 過去に行った読書ログを追加

