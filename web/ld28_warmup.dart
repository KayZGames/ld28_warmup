library ld28_warmup;

import 'package:gamedev_helpers/gamedev_helpers.dart';
import 'package:ld28_warmup/client.dart';

void main() {
  new Game().start();
}

class Game extends GameBase {
  List<Figure> figures;
  CanvasElement figureBuffer;
  Game() : super.noAssets('ld28_warmup', 'canvas', 800, 800);


  void createEntities() {
    figures.forEach((fig) => addEntity([fig, new Render()]));
  }

  List<Figure> createFigures() {
    var lastFig = null;
    var figs = new List<Figure>();
    for (int y = 0; y <= 800; y+=100) {
      for (int x = 0; x <= 800; x+=100) {
        var fig;
        if (y == 0) {
          fig = new Figure.random(x, y, left: lastFig);
        } else {
          fig = new Figure.random(x, y, above: figs[figs.length - 9], left: lastFig);
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
        new FigureHighlightingSystem(canvas, figures),
        new CanvasCleaningSystem(canvas),
        new RasterRenderingSystem(canvas),
        new FigureRenderingSystem(figureBuffer),
        new BufferToCanvasRenderingSystem(figureBuffer, ctx),
        new InformationRenderer(canvas),
        new FpsRenderingSystem(ctx)
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