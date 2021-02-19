flutter は Dart言語を使用しており、そもそもDartは変数宣言型。


\変数に種類
組み込み型、意図しない値が入ることを防ぐ型のもの？
・文字:        String
・数値:        number、 int、 double
・ブーリアン:   boolean
・列挙型:       List(Array)、Set、Map

他の型
・var:       最初に入れる値の型によって変数の型が決まる
    型を調べるには[変数.runtimeType]プロパティか、[変数 is (String)]のようにする
・dynamic:   どのような型の値でも変数に入れられるようにするにはdynamicを使うが、必要な場所以外はvarを使う。

違い > 一度変数に入れたものと同じ型しか再代入できるかできないかということ。
dynamicは文字列を入れた後に数値を入れることができるが、varは文字列を入れたら文字列しか再代入できない

void main() {
  dynamic moji = 'もじ';
  print(moji.runtimeType);      // String
  print(moji is String);        // true
}

・final: 再代入不可能
・const: 再代入不可能

違い > constはコンパイル時に確定した値を定数として持つ。決まった係数やパラメータをコードに持たせたいときに使う


\変数の有効範囲(スコープ)
{} 中括弧内の範囲。クラスや関数の中で宣言した場合、そのクラスや関数内で利用でき、ループ内で宣言した場合はループ内でのみ有効。
グローバル変数は変数の型を指定し、ローカル変数は型を指定しない原則。

bool topLevel = true;
void main() {
  var insideMain = true;
  void myFunction() {
    var insideFunction = true;
    void nestedFunction() {
      var insideNestedFunction = true;
      // ここでtopLevelにアクセス可能
    }
  }
  // ここでinsideFunctionにアクセス不可
}}  // 多分 { が1個足りないのはすでに関数かクラス内だからだと思う
  
  
無名関数
通常の関数は名前をつけて宣言した後に関数呼び出しをして処理を実行するが
無名関数は、関数呼び出しを行う場所で関数の宣言を行い、実行させることができる
メリット > ループ処理や非同期処理などでコード量の削減や可読性の向上を達成できる。

void main() {
  var list = ['apples', 'lemons', 'bananas'];
  list.forEach((item){
    print('${list.indexOf(item)}: $item');
  });
}
0: apples
1: lemons
2: bananas
(item){...}が無名関数となり、forEachはlistの要素を順にパラメータとして渡すメソッド
