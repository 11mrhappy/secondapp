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
  
  
\無名関数
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


\演算子
+   足し算
-   引き算
*   掛け算
/   割り算(double)
~/  割り算(int)
%   あまり(modulo)

インクリメント/デクリメント演算子
++var   1を加算して使用
var++   使用してから1を加算
--var   1を減算して使用
var--   使用してから1を減算

複合代入演算子
a += b  // a = a + b
a op= b // a = a op b (opは算術演算子)

割り当て演算子
a ??= b // aがnullであればbを代入
a ?? b  // aがnullであればbを実行

条件式演算子
x ? a : b   // xがtrueのとき、aを実行 // xがfalseのとき、bを実行

比較演算子
a == b  aとbが同値
a != b  aとbが異なる値
a > b   aがbより大きい
a < b   aがbより小さい
a >= b  aがb以上
a <= b  aがb以下

論理演算子
!   否定(not)
||  論理和(or)
&&  論理積(and)

型テスト演算子
is  指定した型をもつ
is! 指定した型をもたない
    obj is T の結果は指定されたTオブジェクトを実装している場合にtrueが返される
    if (person is Employee) {
      person.division = 'div no.1';
    }


\条件分岐
if-else, else if
if文の評価はboolean型でのみ行われる
if(isRaining()){
  you.bringRainCoat();
} else if (isSnowing()){
  you.wearJacket();
} else {
  car.putTopDown();
}

for 繰り返し
var message = StringBuffer('Dart is fun');
for (var i = 0; i < 5; i++){
  message.write('!');
}

for-in  listやmapなどのiterableな変数の内容に対するfor文はfor-inを使うことで無駄な変数を使わずに済む
var collection = [1, 2, 3];
for (var x in collection) {
  print(x);
}

forEach forEachで簡略化も可能
var candidates = [1, 2, 3];
candidates.forEach((candidate) => candidate.interview());

while, do-while
条件が成立している間ループを実行する場合にwhileを使う
while(!isDone()){
  doSomething();
}

条件の評価を後に行う場合にはdo-whileを使う
do{
  printLine();
}while(!atEndOfPage());

break、continue
for文やwhile文の中で、ループの途中でループをやめたい場合にはbreakを使う。
while(true) {
  if(shutDownRequested()) break;
  processIncomingRequests();
}

ループのイテレーションの処理を終了し、次のイテレーションに移りたい場合にはcontinueを使う
for(int i = 0; i < candidates.length; i++){
  var candidate = candidates[i];
  if(candidate.yearsExperience < 5){
    continue;
  }
  candidate.interview();
};

簡略化したものがこちら
candidates
  .where((c) => c.yearsExperience >= 5)
  .forEach((c) => c.interview());

switch-case
変数の内容によって複数の処理の分岐を行う場合にはswitchを使う
caseの内容と==演算子による評価が行われ、trueとなった場合に実行される
Dartではcase文の処理の終わりはbreakを使わないと次のcase文の後の処理まで実行されます
*この仕組を利用したフォールスルーは便利だが、言語によって動きが異なるためコメントを入れるなどをする
また、どのcase文にも当てはまらない場合にはdefault文以下のよりが実行されます
var command = 'OPEN';
switch(command){
  case 'OPEN':
    execOpen();
    break;
  case 'CLOSING':
  case 'CLOSED':
    execClosed();
    break;
  default:
    execUnknown();
}


\クラス
dartはオブジェクト指向言語。すべてのオブジェクトはなんらかのクラスを実体化したもの
dartではインスタンス化に使うnewは不必要(使ってもいい)
インスタンス化したオブジェクト内のメンバー(インスタンス内のメソッドやプロパティ)にアクセスするには「.」を使う
class Point {
  double x;
  double y;
  double z = 0;
}

var p1 = Point();
p1.x = 4;
p1.y = 1;
この例のp1にはPintクラスのインスタンス化されたオブジェクトが入る。

インスタンスの初期化
インスタンス化する際の初期化処理を行うコンストラクタはクラス名と同名のメソッドで宣言する
class Point {
  double x;
  double y;
  // 通常のコンストラクタ
  print(double x, double this.y){  // this??
    this.x = x;
    this.y = y;
  }
  // 名前付きのコンストラクタ
  Point.origin(){
    x = 0;
    y = 0;
  }
}
