library ld28_warmup;

import 'package:gamedev_helpers/gamedev_helpers.dart';
import 'package:ld28_warmup/client.dart';

void main() {
  new Game().start();
}

class Game extends GameBase {
  List<Figure> figures;
  CanvasElement figureBuffer;
  Queue<int> path = new Queue<int>();
  int maxX = 9, maxY = 9;
  int stepX = 100, stepY = 100;
  Game() : super.noAssets('ld28_warmup', 'canvas', 800, 800);


  void createEntities() {
    figures.forEach((fig) => addEntity([fig, new Render()]));
  }

  List<Figure> createFigures() {
    var lastFig = null;
    var figs = new List<Figure>();
    for (int y = 0; y < maxY * stepY; y+=stepY) {
      for (int x = 0; x < maxX * stepX; x+=stepX) {
        var fig;
        if (y == 0) {
          fig = new Figure.random(x, y, left: lastFig);
        } else {
          fig = new Figure.random(x, y, above: figs[figs.length - maxX], left: lastFig);
        }
        lastFig = fig;
        figs.add(fig);
      }
      lastFig = null;
    }
    return figs;
  }

  List<EntitySystem> getSystems() {
    return [
        new FigureEventListeningSystem(canvas, figures, path),
        new PathCreator(path, maxX, maxY),
        new FigureHighlightingSystem(figures),
        new CanvasCleaningSystem(canvas),
//        new RasterRenderingSystem(canvas),
        new FigureRenderingSystem(figureBuffer),
        new BufferToCanvasRenderingSystem(figureBuffer, ctx),
        new InformationRenderer(canvas),
        new ScoreRenderer(ctx, path),
        new SuccessRenderer(ctx),
        new FailureRenderer(ctx)
//        new FpsRenderingSystem(ctx)
    ];
  }

  void onInit() {
    figures = createFigures();
    figureBuffer = new CanvasElement(width: canvas.width, height: canvas.height);
  }

  void onInitDone() {
    // TODO: implement onInitDone
  }
}

class BufferToCanvasRenderingSystem extends VoidEntitySystem {
  CanvasRenderingContext2D ctx;
  CanvasElement buffer;
  BufferToCanvasRenderingSystem(this.buffer, this.ctx);

  void processSystem() => ctx.drawImage(buffer, 0, 0);
}