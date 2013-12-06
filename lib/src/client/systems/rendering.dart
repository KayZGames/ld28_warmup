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
  int maxCount = 13 + 11 + 10 + 8 + 1;

  RandomFigureDrawer(CanvasElement canvas) : ctx = canvas.context2D,
                                             width = canvas.width,
                                             height = canvas.height;

  void initialize() {
    for (int i = 0; i < 13; i++) {
      coords.add(new Point(700-(i~/2)*100 + random.nextInt(100), 600 + ((i+1) % 2)*100+random.nextInt(100)));
      colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
    }
    for (int i = 0; i < 11; i++) {
      coords.add(new Point(100*((i+1)%2) + random.nextInt(100), 600 - ((i+1)~/2)*100 + random.nextInt(100)));
      colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
    }
    for (int i = 0; i < 10; i++) {
      coords.add(new Point(200 + ((i)~/2)*100 + random.nextInt(100), 100 * (i%2) + random.nextInt(100)));
      colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
    }
    for (int i = 0; i < 8; i++) {
      coords.add(new Point(600 + ((i+1)%2)*100 + random.nextInt(100), 200 + ((i)~/2) * 100 + random.nextInt(100)));
      colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
    }
    coords.add(coords[1]);
    colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
//    for (int i = 0; i < 4; i++) {
//      coords.add(coords[i*2+3]);
//      colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
//      coords.add(new Point(500- i * 100 + random.nextInt(100), 500 + random.nextInt(100)));
//      colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
//    }


//    for (int i = 0; i < 13; i++) {
//      coords.add(new Point(700-(i~/2)*100 + random.nextInt(100), 600 + ((i+1) % 2)*100+random.nextInt(100)));
//      colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
//    }

//    coords.add(new Point(100 + random.nextInt(100), 600 + random.nextInt(100)));
//    colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
//
//    coords.add(new Point(random.nextInt(100), 500 + random.nextInt(100)));
//    colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
//    coords.add(new Point(100 + random.nextInt(100), 500 + random.nextInt(100)));
//    colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
//
//    coords.add(new Point(random.nextInt(100), 400 + random.nextInt(100)));
//    colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
//    coords.add(new Point(100 + random.nextInt(100), 400 + random.nextInt(100)));
//    colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');

//    for (int i = 0; i < 7; i++) {
//      coords.add(new Point(100 + i * 100 + random.nextInt(100), (i%2)*100+random.nextInt(100)));
//      colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
//    }
//    for (int i = 0; i < 4; i++) {
//      coords.add(new Point(700-((i+1) % 2)*100 + random.nextInt(100), 200+i*100+random.nextInt(100)));
//      colors.add('rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})');
//    }

  }

  void processSystem() {
    var pLast = null;
    for (int i = 0; i < maxCount-2; i++) {
//    int i = 0;
      ctx.fillStyle = colors[i];
      ctx.beginPath();
      var p1 = coords[i];
      var p2 = coords[(i+1)%maxCount];
      var p3 = coords[(i+2)%maxCount];
      var p4 = coords[(i+3)%maxCount];
      var p5 = coords[(i+4)%maxCount];
      var p6 = coords[(i+5)%maxCount];
      ctx.moveTo(p1.x, p1.y);
      ctx.bezierCurveTo(p2.x, p2.y, p2.x, p2.y, p2.x, p2.y);
      ctx.bezierCurveTo(p3.x, p3.y, p3.x, p3.y, p3.x, p3.y);
      ctx.bezierCurveTo(p1.x, p1.y, p1.x, p1.y, p1.x, p1.y);

//      if (null == pLast) {
//        ctx.bezierCurveTo(p1.x, p1.y, p1.x, p1.y, p2.x, p2.y);
//      } else {
//        ctx.bezierCurveTo(pLast.x, pLast.y, p1.x, p1.y, p2.x, p2.y);
//      }
//      ctx.bezierCurveTo(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
//      ctx.bezierCurveTo(p3.x, p3.y, p2.x, p2.y, p1.x, p1.y);
      ctx.fill();
      pLast = p1;
    }
  }
}