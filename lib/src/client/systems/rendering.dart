part of client;

class RasterRenderingSystem extends VoidEntitySystem {
  CanvasRenderingContext2D ctx;
  int width, height;

  RasterRenderingSystem(CanvasElement canvas) : ctx = canvas.context2D,
                                                width = canvas.width,
                                                height = canvas.height;

  void processSystem() {
    ctx.strokeStyle = 'black';
    for (int i = 0; i < width; i+=100) {
      for (int j = 0; j < height; j+=100) {
        ctx.strokeRect(i, j, 100, 100);
      }
    }
  }
}


class RandomFigureDrawer extends VoidEntitySystem {
  var coords = new List<Point>();
  var colors = new List<String>();
  CanvasRenderingContext2D ctx;
  int width, height;
  int verticesPerRow = 20;
  int rows = 9;

  RandomFigureDrawer(CanvasElement canvas) : ctx = canvas.context2D,
                                             width = canvas.width,
                                             height = canvas.height;

  void initialize() {
    for (int row = 0; row < rows ~/ 2 + 1; row++) {
      for (int i = 0; i < verticesPerRow; i++) {
        coords.add(new Point((i~/2)*100 - random.nextInt(100), 200 * row + (((i+1)%4)~/2)*100 - random.nextInt(100)));
        colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
      }
    }
    for (int row = 0; row < rows ~/ 2; row++) {
      for (int i = 0; i < verticesPerRow; i++) {
        int c = i%2 == 0 ? 1 : -1;
        coords.add(coords[i+c + verticesPerRow*(row + ((i+1)%4)~/2)]);
        colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
      }
    }
  }

  void processSystem() {
    var pLast = null;
    for (int row = 0; row < rows; row++) {
      for (int i = 0; i < verticesPerRow-3; i+=2) {
        ctx.fillStyle = colors[verticesPerRow*row+i];
        ctx.strokeStyle = colors[verticesPerRow*row+i];
        ctx.beginPath();
        var p1 = coords[verticesPerRow*row+i];
        var p2 = coords[verticesPerRow*row+(i+1)%verticesPerRow];
        var p3 = coords[verticesPerRow*row+(i+2)%verticesPerRow];
        var p4 = coords[verticesPerRow*row+(i+3)%verticesPerRow];
        ctx.moveTo(p1.x, p1.y);
        ctx.bezierCurveTo(p2.x, p2.y, p2.x, p2.y, p2.x, p2.y);
        ctx.bezierCurveTo(p3.x, p3.y, p3.x, p3.y, p3.x, p3.y);
        ctx.bezierCurveTo(p4.x, p4.y, p4.x, p4.y, p4.x, p4.y);
        ctx.bezierCurveTo(p1.x, p1.y, p1.x, p1.y, p1.x, p1.y);

  //      if (null == pLast) {
  //        ctx.bezierCurveTo(p1.x, p1.y, p1.x, p1.y, p2.x, p2.y);
  //      } else {
  //        ctx.bezierCurveTo(pLast.x, pLast.y, p1.x, p1.y, p2.x, p2.y);
  //      }
  //      ctx.bezierCurveTo(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
  //      ctx.bezierCurveTo(p3.x, p3.y, p2.x, p2.y, p1.x, p1.y);
        ctx.fill();
        ctx.stroke();
        pLast = p1;
      }
    }
  }
}