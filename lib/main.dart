import 'dart:math';

import 'package:first_flutter_app/bean/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  // runApp 函数会持有传入的 Widget，并使它成为 widget 树中的根节点
  // 框架会强制让根 widget 铺满整个屏幕
  runApp(
      MaterialApp(
        title: 'Flutter Tutorial',
        home: SquareBoardLayout(),
      )
  );
}

class SquareBoardLayout extends StatefulWidget {
  @override
  _SquareBoardLayoutState createState() => _SquareBoardLayoutState();
}

class _SquareBoardLayoutState extends State<SquareBoardLayout> {
  final fruits = [
    "001-lemon.png",
    "002-apple.png",
    "003-guava.png",
    "004-mangosteen.png",
    "005-coconut.png",
    "006-papaya.png",
    "007-pineapple.png",
    "008-kiwi.png",
    "009-star fruit.png",
    "010-dragon fruit.png",
  ].map((e) => 'images/$e').toList();
  SquareBoard squareBoard;



  @override
  Future<void> initState() {
    squareBoard = SquareBoard(10, 10, fruits);
  }

  @override
  Widget build(BuildContext context) {
    var rows = squareBoard.currentBoard.map((e) => Row(
      mainAxisSize: MainAxisSize.min,
      children: e.map((e) => Expanded(
          flex: 1,
          child: RandomImageWidget(e))).toList(),
    )).toList();
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: rows,
      ),
    );
  }
}

class RandomImageWidget extends StatefulWidget {
  final Square square;

  RandomImageWidget(this.square);

  @override
  State<StatefulWidget> createState() {
    return _ImageState();
  }
}

class _ImageState extends State<RandomImageWidget> {
  void _handleTap() {
    setState(() {
      widget.square.visible = !widget.square.visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 0.5),
            color: Colors.white
        ),
        child: AnimatedOpacity(
          opacity: widget.square.visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 1000),
          child: Image(
              image: AssetImage(widget.square.image)
          ),
        ),
      ),
    );
  }
  
}


class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);
  final List<Product> products;

  @override
  State createState() {
    return _ShoppingListState();
  }
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    // 为了通知框架它改变了它的内部状态，需要调用 setState()
    setState(() {
      if (!inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  /// 重写 initState 来完成只需要发生一次的工作
  void initState() {
    super.initState();
    Fluttertoast.showToast(msg: 'ShoppingListState init.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    // 这个消息已经看不到了，应该是因为资源已经被回收掉了
    Fluttertoast.showToast(msg: 'ShoppingListState dispose.');
    super.dispose();
  }
}

class Product {
  const Product({this.name});
  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({this.product, this.inCart, this.onCartChanged});
  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context),),
    );
  }
}

// Widget 和 State 的生命周期不一样，所以需要分开
// Widget 是临时对象，而 State 在调用 build() 之间是持久的，以此来存储信息
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(onPressed: _increment, child: Text('Increment')),
        ElevatedButton(onPressed: _reset, child: Text('Reset')),
        Text('Count: $_counter'),
      ],
    );
  }
}

class MyButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // 下面的 IconButton 和 FloatingActionButton 都只有 onPress
    // 要处理复杂的手势，需要使用 GestureDetector
    return GestureDetector(
      // 点击
      onTap: () {
        Fluttertoast.showToast(
            msg: 'MyButton was tapped!'
        );
      },
      // 缩放
      onScaleEnd: (details) {
        Fluttertoast.showToast(
            msg: 'onScaleEnd'
        );
      },
      // 长按
      onLongPress: () {
        Fluttertoast.showToast(
            msg: 'onLongPress'
        );
      },
      child: Container(
        height: 96.0,
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
        child: Counter(),
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
