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

class FigureRenderingSystem extends EntityProcessingSystem {
  CanvasRenderingContext2D ctx;

  ComponentMapper<Figure> fm;

  FigureRenderingSystem(CanvasElement canvas) : ctx = canvas.context2D, super(Aspect.getAspectForAllOf([Figure]));

  void initialize() {
    fm = new ComponentMapper<Figure>(Figure, world);
  }

  void processEntity(Entity entity) {
    var f = fm.get(entity);
    ctx..beginPath()
       ..moveTo(f.p1.x, f.p1.y)
       ..strokeStyle = f.color
       ..fillStyle = f.color
       ..bezierCurveTo(f.cp[0].x, f.cp[0].y, f.cp[1].x, f.cp[1].y, f.p2.x, f.p2.y)
       ..bezierCurveTo(f.cp[2].x, f.cp[2].y, f.cp[3].x, f.cp[3].y, f.p3.x, f.p3.y)
       ..bezierCurveTo(f.cp[4].x, f.cp[4].y, f.cp[5].x, f.cp[5].y, f.p4.x, f.p4.y)
       ..bezierCurveTo(f.cp[6].x, f.cp[6].y, f.cp[7].x, f.cp[7].y, f.p1.x, f.p1.y)
       ..fill()
       ..stroke();
  }
}