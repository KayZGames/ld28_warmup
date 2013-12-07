library ld28_warmup;

import 'package:gamedev_helpers/gamedev_helpers.dart';
import 'package:ld28_warmup/client.dart';

void main() {
  new Game().start();
}

class Game extends GameBase {
  Game() : super.noAssets('ld28_warmup', 'canvas', 800, 800);


  void createEntities() {
    var figs = createFigures();
    figs.forEach((fig) => addEntity([fig]));
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
        new CanvasCleaningSystem(canvas),
        new RasterRenderingSystem(canvas),
        new FigureRenderingSystem(canvas),
        new FpsRenderingSystem(ctx)
    ];
  }

  void onInit() {
    // TODO: implement onInit
  }

  void onInitDone() {
    // TODO: implement onInitDone
  }
}