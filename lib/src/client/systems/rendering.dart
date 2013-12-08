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

  FigureRenderingSystem(CanvasElement canvas) : ctx = canvas.context2D, super(Aspect.getAspectForAllOf([Figure, Render]));

  void initialize() {
    fm = new ComponentMapper<Figure>(Figure, world);
  }

  void processEntity(Entity entity) {
    var f = fm.get(entity);
    ctx.beginPath();
    if (f.hover) {
      var grd = ctx.createRadialGradient(f.center.x, f.center.y, 25, f.center.x, f.center.y, 75);
      grd.addColorStop(0, 'hsl(${f.h}, ${f.s + 15}%, ${f.l + 15}%)');
      grd.addColorStop(1, 'hsl(${f.h}, ${f.s}%, ${f.l}%)');
      ctx.fillStyle = grd;
    } else {
      ctx.setFillColorHsl(f.h, f.s, f.l);
    }

    ctx..moveTo(f.p1.x, f.p1.y)
       ..setStrokeColorHsl(f.h, f.s, f.l)
//       ..setStrokeColorHsl(f.h, f.hover ? f.s + 15 : f.s, f.hover ? f.l + 15 : f.l)
//       ..setFillColorHsl(f.h, f.hover ? f.s + 15 : f.s, f.hover ? f.l + 15 : f.l)
       ..bezierCurveTo(f.cp[0].x, f.cp[0].y, f.cp[1].x, f.cp[1].y, f.p2.x, f.p2.y)
       ..bezierCurveTo(f.cp[2].x, f.cp[2].y, f.cp[3].x, f.cp[3].y, f.p3.x, f.p3.y)
       ..bezierCurveTo(f.cp[4].x, f.cp[4].y, f.cp[5].x, f.cp[5].y, f.p4.x, f.p4.y)
       ..bezierCurveTo(f.cp[6].x, f.cp[6].y, f.cp[7].x, f.cp[7].y, f.p1.x, f.p1.y)
       ..fill()
       ..stroke();
    entity.removeComponent(Render);
    entity.changedInWorld();
  }
}

class InformationRenderer extends VoidEntitySystem {
  CanvasQuery ctx;
  int width, height;
  int startFrame = 0;
  String text = 'Click on a figure to start';
  InformationRenderer(CanvasElement canvas) : ctx = cq(canvas),
                                              width = canvas.width,
                                              height = canvas.height;


  void processSystem() {
    int displayCount = world.frame - startFrame;
    if (displayCount < 300) {
      ctx.save();
      ctx.globalAlpha = ease.outCubic((300 - displayCount)/300, 1, 0);
      ctx.font = '30px Verdana';
      var bounds = ctx.textBoundaries(text, width * 0.8);
      var textWidth = min(bounds.width, ctx.measureText(text).width);
      ctx.wrappedText(text, (width - textWidth) ~/ 2, (height - bounds.height) ~/ 2, width * 0.8);

      ctx.restore();
    }
  }

  void start() {
    startFrame = world.frame;
    text = 'Follow the light';
  }
}

class ScoreRenderer extends VoidEntitySystem {
  int _score = 0;
  int errors = 0;
  CanvasRenderingContext2D ctx;
  PathCreator pathCreator;
  ScoreRenderer(this.ctx);

  void initialize() {
    pathCreator = world.getSystem(PathCreator);
  }

  void processSystem() {
    ctx.save();
    ctx.font = '20px Verdana';
    ctx.fillText('Score: $_score', 680, 10);
    ctx.fillText('Errors: $errors', 680, 40);
    ctx.restore();
  }

  void set score(int value) {
    _score = value;
    if (_score % 10 == 0) {
      pathCreator.time *= 0.9;
    }
  }

  int get score => _score;
}