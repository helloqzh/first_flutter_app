import 'package:flutter/material.dart';

void main() {
  // runApp 函数会持有传入的 Widget，并使它成为 widget 树中的根节点
  // 框架会强制让根 widget 铺满整个屏幕
  runApp(
      Center(
        child: Text(
          'Hello, world!',
          textDirection: TextDirection.ltr,
        ),
      )
  );
}
