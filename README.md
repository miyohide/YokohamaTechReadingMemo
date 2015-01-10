# これは何か？

* このページは横浜タネマキさんで毎週土曜日の朝に開催している『Objects on Rails』読書会の私的なメモです。
* また、ソースコードはRails 3.2でサンプルアプリの実装例です。

# 読書会メモ
## 2014年6月14日（土）第24回読書会
### 実施範囲

* P170のBring it all back homeからP178まで（最後まで）

### 所感

* 全体的にViewにロジックを書きすぎている状況から脱しようという気持ちはわかる。
  * その気持ちはわかるんだけど、途中かなりやりすぎな感がある。
  * 例えば、exhibitの導入はいいと思うんだけど、ActiveRecordの各種メソッドを見えなくするのはちょっとどうかと。
* テストの独立化と高速化についても印象深かった。ちょっと試してみたい気はする。

## 2014年6月7日（土）第23回読書会
### 実施範囲

* P161のListing 184からP170のBringing it all back homeまで

### 所感

* eachを再実装したんだけど、selectとかメソッドチェーンなどの形で使う場合は各要素にexhibitを当てることは使い勝手が悪い。
* そのため、`exhibit_enum`マクロを作って、`select`や`grep`などのメソッドに適用することで回避している。
  * すごい無理矢理感がする。ここまでしなくても・・・という思いがある。
* 更には`group_by`や`partition`に至っては再実装している。
  * これも無理矢理感が漂う。
* P166でRails 3.2で導入されているAPIの話が出ているけど、それが分かっているんだったら、このサンプルアプリも3.2に対応して欲しかった。
* P166とP167にtypoが多い気がする。
  * P166の4行目。「we add a a method」は「we add a method」では？
  * P166にある「Otherwise, we munge the model's」の「munge」ってなに？
  * P167の「Entry collection, render thyself」の「thyself」ってなに？「themself」？

## 2014年5月31日（土）第22回読書会
### 実施範囲

* P154のExhibiting the blog objectからP161のListing 184の直後まで

### 所感

* 今回の問題について整理。
  * blogの下にpost1,post2,post3,...といった感じでpostがぶら下がっている。これをobject treeと表現している。
  * exhibitを適用するために、exhibit_queryマクロを作った
  * これだと、collectionの各要素に対してはexhibitが適用されないので、それを適用するようにする。そのテストがListing 184。

## 2014年5月17日（土）第21回読書会
### 実施範囲

* P149のlibrary.borrow_book('161293031X', library_card)からP154のExhibiting the blog objectの前まで

### 所感

* P149の`library.borrow_book`はメソッド名の名前がおかしいのではないか。`library.lent_book`が適切では？
  * 図書館（library）は本を貸す（lent）なので。
* 結局、`has_many`や`belongs_to`などで生成されるメソッドをそのまま使うよりも、仲介メソッド（mediator）を使うほうが良いというのがこの人の主張。
* P151からは、Listing 170の部分テンプレートが動くように各種リファクタリングを行うというお話。

## 2014年5月10日（土）第20回読書会
### 実施範囲

* P141のListing 161からP149のlibray.borrow_book('161293031X', library_card)まで

## 2014年4月26日（土）第19回読書会
### 実施範囲

* P134のListing 146からP141のListing 161まで

## 2014年4月12日（土）第18回読書会
### 実施範囲

* P126からP134のListing 146まで

## 2014年4月5日（土）第17回読書会
### 実施範囲

* P116からP125まで

### 所感

* P121にて、TagListメソッドがprivateなのはなぜ？
* P121にて、==メソッドの定義があるが、そこで`other.to_a`としないのはなぜだろう。
  * otherがStringのインスタンスだと、`to_a`で落ちてしまうからかと。

## 2014年3月22日（土）第16回読書会
### 実施範囲

* P109からP115まで

### 所感

* 最近、次のプロダクトが気になって試している。
  * [errbit](https://github.com/errbit/errbit)
  * [focuslight](https://github.com/focuslight/focuslight)
* バージョン番号の比較をするためには？
  * [Gem::Version](http://rubygems.rubyforge.org/rubygems-update/Gem/Version.html)を使うと良いかと。
  * るりまの内容とはちょっと異なっていてハマった。
  * 報告すると良いかと。
  * 検索すると、[versionomy](https://github.com/dazuma/versionomy)というGemも見つけた。
* P110に書かれているけど、HTMLのリンクタイプというものがあることをはじめて知った。
  * 例えば、[ここのページ](http://www.kanzaki.com/docs/html/link.html)とか。
* P110に書かれているけど、JSONにも同じように[仕様](http://tools.ietf.org/html/draft-zyp-json-schema-03#section-6)があることを知った。IETFが定めているみたい。
* P111のListing 111の`next_url`メソッドだけが`self.next`と書かれているのはなぜだろう。
* P116のListing 116で`blog_url`メソッドを`application_controller.rb`に書いているのが気になる。他に良い場所はないんだっけ。

## 2014年3月15日（土）第15回読書会
### 実施範囲

* P103のListing 102の直後からP108まで

### 所感

* [DataMapper](http://datamapper.org/)をすごい押している。あんまり使ったことはない。ActiveRecordの一人勝ちって感じ。
  * でも、開発が止まっている感じ。この本に書かれている2.0は一体いつに出るのやら。
  * [エンタープライズアプリケーションアーキテクチャパターン](http://www.seshop.com/product/detail/5885/)がまた出てきた。これは必読本かな。
* 昔、[ramaze](https://github.com/ramaze/ramaze)ってフレームワーク流行ったよね。
* ここでの実装はすごくRailsの内部実装に依存している感じ。
  * 実際、Listing 102のコードはRails 3.2では動かない。
  * 同じくListing 108のコードはフックにするべきだと思う。本の中では「hook使いすぎ」って書かれているけど、ちょっとやり過ぎ感がある。
  * P107の箇条書きの部分で引数をアスタリスク（*）にしている説明があるけど、ちょっとトリッキーすぎる気がする。

## 2014年3月8日（土）第14回読書会
### 実施範囲

* P98のListing 98の直後からP103のListing 102の直後まで

### 所感

* FigLeafとは？
  * 直訳すると、イチヂクの葉。用語として（見せるべきでないものを）覆い隠すためのものという意味があるようだ。
  * 以降の記述を読むと、publicメソッドをprivate化しているので覆い隠しているという意味でFigLeafと命名したのだろう。
  * 本の中では、「The code is fairly short」とあるが、全然短くない。結構難しい内容。
* Listing 102ではexpectでpublicのままにするものを載せているが、これではrake testで落ちるのでさらなる追加が必要。

## 2014年3月1日（土）第13回読書会
### 実施範囲

* P94の「Separating out integration tests」からP98のListing 98直後まで

### 所感

* Listing 93で、`teardown_database`メソッドにおいてDatabaseCleanerを使ってデータをCleanにしているんだけど、これはテストが始まる前にやるべきでは？
  * 最後でよいのでは？
  * 「実践テスト駆動開発」ではテストの最初にCleanしていたように思うが。
  * テストツールの違いからだろう。
* Listing 95で`@ar`を導入して、Listing 96で`@ar`を使ったテストの実装をしているんだけど、正直わかりにくい。
  * 例えば、`stub_ar_method(:valid?, @it)`ってな感じでメソッドを定義すればすっきりするんじゃないかな。
* NullDBがよく分からないな。そもそもどんな役割をするんだろう。誰も使っていない。

## 2014年2月22日（土）第12回読書会
### 実施範囲

* P88の「Moving on to Blog:」からP94の「Separating out integration tests」の前まで

### 所感

* P88にあるListing 87で`@entry_fetcher.()`という書き方があるけど、こんな書き方始めてみた。
* P89の後半から書かれている`spam_social_networks(entry)`について。
  * これはどこにメソッドをかけばいいかのサンプルとして書いているもの。今後の話には登場しない。
  * この`spam`って名前はジョークなのかなあ。
  * `Post`クラスに書くと、責務を複数持つことに成るため、あまり良くないという話。
  * 結果としては、`Blog`モデルに書くのが良いという話。
* Listing 91では、わざわざ内部に持つリストの要素の確認を行うのではなく、`entry`が保存することを確認するために、`mock`を使っている。これが本当のmockの使い方。
* P93のListing 92は以前、`model`のspecとして書いてある。
  * `model`のテストについては、P93のListing 92が通ったら削除するのが良いと思う。

## 2014年1月25日（土）第11回読書会
### 実施範囲

* P85からP88の「Moving on to Blog:」の前まで。

### 所感

* データの永続化のためにようやくActiveRecordの導入。
* Listing 86の修正で大分テストが通らなくなっている。対応が大変。というか、どう対応すれば分からない。
  * Railsの環境を読み込んでいないのが問題だと思うので、`spec_helper_lite.rb`に`config/environment`を読み込む処理や`RAILS_ENV`環境変数を設定すればよい。

## 2014年1月18日（土）第10回読書会
### 実施範囲

* P77の「Refactoring the exhibits」からP84まで。

### 所感

* P78の「[__getobj__](http://rurema.clear-code.com/2.1.0/method/Delegator/i/__getobj__.html)」は委譲先のオブジェクトを返す。
  * `Exhibit`クラスを継承する`PicturePostExhibit`などで`to_model`や`class`メソッドを実装する必要がある。
* P79で突然`ExhibitsHelper`のリファクタリングの話が出てきている。
  * 現状でも見やすい形だが、将来的なことを考えてリファクタリングをしている。
  * 必要に駆られていないので、あまりその重要性が分からないな。
* P80のListing 76で書かれている`inject`の処理内容がよく分からない。
* P82のListing 81では`exhibits`にハードコーディングで`exhibits`の種類をリスト化している。
  * P82にハードコーディングの説明があるが、ここで書かれてないものとして、順序が大事というものがある。
  * `LinkExhibit`が一番最初にあるとまずい。
* P83で書かれている`helper`について。あまり`helper`は好きではない。ここにも書かれているけど、ごちゃごちゃになりがち。
  * `model`に紐づくのは`exhibit`、`model`に紐付かないのは`helper`という使い道が良いのではないか。

## 2014年1月11日（土）第9回読書会
### 実施範囲

* P61からP77の「Refactoring the exhibits」の前まで。
* 今回は復習が中心。

### 所感

* RSpec3でallowingの取り扱いがmockからstubになっている。
* 雑談ですが、APIのドキュメントをRSpecのテストから書くgemとして[rspec_api_documentation](https://github.com/zipmark/rspec_api_documentation)が紹介。 

## 2014年1月4日（土）第8回読書会
### 実施範囲

* P71からP76の「Exhibit Object Characteristics」の前まで。

### 所感

* P71のListing 65のコードをP72のListing 66のコードを実装した後に実行すると、「wrong number of arguments(2 for 0)」でテストが落ちてしまう。
  * 検索すると、[このページ](https://groups.google.com/forum/#!searchin/objects-on-rails/exhibits_helper_spec/objects-on-rails/3272cyA23OY/w1J_GNV5ayMJ)に同件の記述がある。
  * 実際に実装してみると、David Burrows氏の内容でテストが動くようになった。
  * Adam Trepanier氏の内容で試してみたが、こちらはテストが通るようにはならなかった。
  * Ruby 1.9.2から1.9.3での非互換性の関係？
* P73のListing 69にある`helper`メソッドとは？
  * [API docのページの説明](http://apidock.com/rails/AbstractController/Helpers/ClassMethods/helper)。
  * helperメソッドはどこでも呼べるのでは？
  * Viewならどこでも呼べる。Controllerでは`include`する必要がある。
  * Rails 3.1でhelperメソッドの取り扱いが変わった。
  * `config.action_controller.include_all_helpers = false`と設定することで、コントローラに対応するヘルパーのみを読み込む。デフォルトはすべてのヘルパーメソッドを読み込む。
* P74の「What about Presenters?」からはPresenter Patternの説明と、今回導入したExhibit Patternの導入理由が書かれている。
  * Presenter Patternは複雑で読み手によってもいろんな受け取り方があるので用語を変えたというのが本質かな。

## 2013年12月28日（土）第7回読書会
### 実施範囲

* P61「Adding validation」からP70まで。

### 所感

* P61の「But we know that Rails needs more than ...」は、「独自でvalid?メソッドは実装できるけれども、Railsは値の検証以外に検証が失敗したことなどを分かりやすく表示させることも必要なので、ActiveModelを使って実装しよう」という話の流れ。
* P62でアプリケーション本体がActiveModelをrequireする必要がないというのは、起動時にRailsが関連ファイルを読み込むため。
* P63のListing 54にある`dont_allow`の意味は？
  * `RR`のメソッド。ここでは、`add_entry`メソッドが呼び出されないことを確認している。
* P65のListing 58にある`<figure />`は`</firure>`のtypo
* P66にあるListing 60のようなコードはよく書いてしまう。これぐらいなら書いてもいいかもしれない。
  * 似たようなロジックが2回以上出たらhelperとかの導入を考える。
* P66の「What's the point of using an OO language ... 」は反語的な言い方かと思う。オブジェクト指向言語なのにポリモフィズム使わないなんて・・・って意味合いだと思う。
* P67の`presentation-agnostic`は続けて書かれている`they shouldn't know ... `に説明が書かれている。
  * `they`が`The models in an MVC application`を指しているので、「MVCアプリケーション内のモデルはそれ自身がどのように表示されるかを知らないこと」
* P67の`such as the specific URLs for related resources`の意味がよく分からない。
  * その前に書かれている`some extra presentation-specific information`（「いくつかの追加されたプレゼンテーション情報」）で何となく分かる。
* `Exhibit Pattern`はこの本が作った造語っぽい。
* P68のListing 62にある`@context = stub!`は何を意味しているのだろう。処理内容がよく分からない。
  * Object.newと同じことと思われる。単にObjectのインスタンス生成。
* P69のListing 63に出てくる`SimpleDelegator`は本文中にも出てくるが、Rubyの標準ライブラリ。[Ruby 2.1.0のマニュアルはこちら。](http://docs.ruby-lang.org/ja/2.1.0/class/SimpleDelegator.html)

## 2013年12月21日（土）第6回読書会
### 実施範囲

* P55の第一段落「... while still having sensible built-in defaults for those dependencies.」からP60まで。

### 所感

* `publish`メソッドが引数に`clock`を取るようになったおかげで、過去日付や未来日付の`Post`も実装可能となった。
* Listing 47ではOpenStructを使ってモックの役割を果たすfixed_clockを作っている。
* Listing 48ではDelayClockというクラスを使って、遅延投稿機能を実装している。
* P56から始まる「Injecting only the dependencies we neeed」がよく分からない。
  * いきなり`@post_class`が出てくるんだけど、こいつは何者？
  * `@post_source`を導入した理由を述べているみたい。
    * `Post.new`をoverrideするのは他のテストへの影響が大きいため。
    * 理由2.が分からない・・・
  * `blog.post_source = -> { new_post }`で新しい`Post`のインスタンスを表すことができるのが楽ってことを言いたいのかな。
* P57では`post_source`はFactory patternのfactoryであると書かれている。ま、これはそうだよね、ということで納得。
* P60で`add_entry`では`entries`を`@entries`に変更している。
  * `entries`をメソッドとして定義したため。
  * もともとは`entries`は`attr_reader`で定義されたメソッドだったのだけれども、今回の修正で`@entries`を直接触るようになった。

## 2013年12月14日（土）第5回読書会
### 実施範囲

* P46の「Getting the tests running again」からP55の第一段落「... while still having sensible built-in defaults for those dependencies.」まで。

### 所感

* テストっていつ壊れたんだろう。
  * P40でPostクラスに対して、ActiveModel::Namingをextendして、ActiveModel::Conversionをincludeしているので、ここで落ちている。
* P46のListing 35ではからのActiveModel::NamingとActiveModel::Conversionを設定している。が、この本の主眼としてこの方法は取らずに、自分でstubをつくろうとするのがListing 36。
* P49ではタイムスタンプの導入。
* P50に書かれているが、MiniTestが標準で持っているモックは機能不足なので、今回はrrを導入することにした。
* P52のListing 43にて、beforeに対してたくさん事前準備が書かれている。P53にてそのことに言及されており、大体はTimecopなどの時間を上書きするライブラリを使うことになるのだが、この本では別のアプローチを取るようだ。
* P54からはDependency Injection。依存性の注入。言葉はよく聞くけど、よく分かっていない。コンポーネント間の依存関係を排除し、外部の設定ファイルから注入できるようにするってことらしい。今回は、時刻情報がそれなのかな。

## 2013年11月30日（土）第4回読書会
### 実施範囲

* P42の「Object Trees and Lone Wolves」からP46の「Getting the tests running again」

### 所感
* コードがなくて、技術の概念とか考え方について書かれている部分は、英語だと辛い。
* ここでは、Postクラスのインスタンスを直接操作するのではなく、木構造をベースにした設計をするとオブジェクト指向開発ではよいって事が言いたいのかなと。
* Postクラスのインスタンスを直接操作する方法（ここでは、Lone wolf（一人で行動するタイプ）って呼んでいる）方法だと、flight risk（逃亡のおそれ、今回の例だと、オブジェクトの親子関係がバラバラに成ってしまうってことか？）があるし、テストもスタブの生成など色々面倒くさいので、よろしくないって読み取った。

## 2013年11月16日（土）第3回読書会
### 実施範囲
* P29の「Aside: subject and let」からP42の「Object Trees and Lone Wolves」の前まで1

### 所感
* `subject`と`let`はRSpecから持ってきたもの。MiniTestの新しいバージョンか、Ruby 1.9.3から使える。
  * この本ではあまり`subject`と`let`を使っていない。
  * 本文中で「After I completed most of the examples in this text ...」とあるので、本のものはこのまんまにしているのかな。
* P30の Posts vs. Entriesの話。
  * Postには色々な種類がありえる（写真とかビデオとか）ので、それを満たすために、`blog.new_post`としたほうがよい。
  * idが分かってしまった場合、第三者のPostを更新出来てしまう。
  * ここの理論がよく分からない。
* P32のList12はちょっとやり過ぎな感がある。
* P33のpublishについて。実際に扱うドメインと合わせてメソッド名を決めるというものの好例。
* MiniTestのMockは書きにくい気がする。ゆとりで済みません。
* P40のActiveModel::NamingのextendとActiveModel::Conversionのincludeについて。Rails3においてはpersisted?はお約束的に書く必要があったが、Rails4からはinclude ActiveModel::Modelが出てきてこれだけでOKとなった。
* P42のListing 32でのグローバル変数の使い道はすごく違和感がある。気持ち悪い。

## 2013年11月9日（土）第2回読書会
### 実施範囲
* P19の「About the approach」からP29の「Aside: subject and let」の前まで。

### 所感
* Introductionは英語の文章に四苦八苦。とりあえず、前にわからない文章で止まるのではなく、前に進めていくことにする。
* この本のアプローチとしてはTDDで。しかしながら、Unitテストレベルまでで留めている。Cucumberを使った受け入れテストのようなものは付録Bを参照とのこと。
* 本文中に出ている"deluxe edition"はPDFでダウンロード出来る奴のもの。ソースコードもついているけど、コミット単位が本に記載のものとは違う感じ。
* P20に書かれているブロックの使い分け（ブレースとdo...end）について紹介されていた[エントリ](http://onestepback.org/index.cgi/Tech/Ruby/BraceVsDoEnd.rdoc)は非常に参考になる。
* P22からソースコードが出てきて、ちょっとホッとする。
* プロジェクト名が「bloog」になっている。これの説明が直後のNoteにかかれているけど、それは単にネーミングが悪いんじゃないだろうか。
  * →それについてはP30の「Posts vs. Entries」に書かれているような気がする。
* P23のBlogクラスについて。app/modelsの下に置いているけど、この時点ではActiveRecord::Baseを継承していない。
* P27にて突然出てきた#new_postメソッド。このメソッドをわざわざ作る意味がよく分からない。
  * →あとで説明があるんじゃないかな。P30の部分がそうかもしれない。
* P28の#new_postメソッドに対するテストコードについて。OpenStructを使ってスタブのようなものを作っているのが興味深い。
* P29の#new_postメソッドの実装はもう少し違う書き方ができるような気がする。

## 2013年10月19日（土）第1回読書会
### 実施範囲

* ContentsからIntroductionのWhat this is notまで

### 所感

* まだ本文には入っていないので、「こんなこと書かれているんだな。」と感触を覚えただけ。
* 英語のハードルが高いので、事前に予習をして丁寧に読んでいきたい。

