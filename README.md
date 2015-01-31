# 横浜技術書朗読会 読書メモ
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

## 2015年1月10日（土）

- 過去に行った読書ログを追加

