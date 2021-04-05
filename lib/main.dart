import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  // runApp 函数会持有传入的 Widget，并使它成为 widget 树中的根节点
  // 框架会强制让根 widget 铺满整个屏幕
  runApp(
      MaterialApp(
        title: 'Flutter Tutorial',
        home: TutorialHome(),
      )
  );
}

class MyButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Fluttertoast.showToast(
            msg: 'MyButton was tapped!'
        );
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text('Engage'),
        ),
      ),
    );
  }
}

class TutorialHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null
        ),
        title: Text('Example title'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: null
          ),
        ],
      ),
      body: Center(
        child: MyButton(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    // Container: 可见的矩形元素，使用 decoration 属性配置样式
    return Container(
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row: 水平方向创建布局
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Navigation menu',
              onPressed: null
          ),
          // Expanded 会扩展以填充其它子 widget 未使用的可用空间
          Expanded(child: title),
          IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: null)
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      // Row: 垂直方向创建布局
      child: Column(
        children: <Widget>[
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.headline6,
            )
          ),
          Expanded(child: Center(
            child: Text('Hello, world!'),
          )),
        ],
      ),
    );
  }
}
