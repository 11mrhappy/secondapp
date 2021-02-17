import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<SharedPreferences> _prefs
    = SharedPreferences.getInstance();  //インスタンス作成

  Future<int> _getCount() async {
    SharedPreferences prefs = await _prefs;
    return (prefs.getInt('counter'));
  }

  void _incrementCounter() async {
    SharedPreferences prefs = await _prefs; //非同期処理実行
    setState(() {  //getIntメソッドで、'counter'をkey名とし、バリューを取り出す。カウントアップした後、setIntメソッドで値を保管してる
      _counter = (prefs.getInt('counter') ?? 0) + 1;  // ??演算子は左のパラメータがnullのとき右の値を返すという動きをする。つまりここでは、値を取り出したときに値が保管されていなかった場合に0として扱うという意味
    });  //shared_preferencesはアンインストールなどによって保管された値が消える可能性があるので、常にnullが返る可能性を考えてコードを書く。
    await prefs.setInt('counter', _counter);
  }

  @override
  Widget build(BuildContext context) {
    _getCount().then((value){  // futureオブジェクトのthenメソッドを使って、値を_counterに入れている。
      setState(() {
        _counter = value;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
