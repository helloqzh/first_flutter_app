import 'dart:collection';
import 'dart:math';

/// 一个显示图像的方块
class Square {
  int x, y;
  bool visible, activate;
  String image;

  Square(this.x, this.y, this.image) {
    visible = true;
    activate = false;
  }

  // 移动到新的位置(x, y)
  jumpTo(int x, int y) {
    this.x = x;
    this.y = y;
  }

  /// 消除两个方块
  removeWith(Square square) {
    visible = activate = false;
    square.visible = square.activate = false;
  }
}

/// 一个放置方块的矩形区域
class SquareBoard {
  final imageMaxCount = 10;
  int width, height;
  List<String> images;
  List<List<Square>> currentBoard;

  SquareBoard(this.width, this.height, this.images) {
    if (width % 2 == 1 && height % 2 == 1) {
      throw new ArgumentError("The product of width and height must be an even number.");
    }
    // 种类按 width * height * 10%
    // 每一种最多出现 10 对
    final list = List.from(images);
    list.shuffle();
    var validImages = list.take(min(images.length, (width * height * 0.1).toInt())).toList();
    var dict = new HashMap();
    var random = Random.secure();
    currentBoard = [];
    List<Square> imageArr = [];
    for (var i = 0; i < width * height / 2; i++) {
      var nextImg = validImages[random.nextInt(validImages.length)];
      while (dict.containsKey(nextImg) && dict[nextImg] > imageMaxCount) {
        nextImg = validImages[random.nextInt(validImages.length)];
      }
      dict[nextImg] = dict.containsKey(nextImg) ? dict[nextImg] + 1 : 1;
      imageArr.addAll([Square(0, 0, nextImg), Square(0, 0, nextImg)]);
    }
    imageArr.shuffle();
    for (var i = 0; i < height; i++) {
      currentBoard.add([]);
      for (var j = 0; j < width; j++) {
        var s = imageArr[i * height + j];
        s.x = j;
        s.y = i;
        currentBoard[i].add(s);
      }
    }
  }
}