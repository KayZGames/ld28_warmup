library ld28_warmup;

import 'package:gamedev_helpers/gamedev_helpers.dart';
import 'package:dartemis/dartemis.dart';

void main() {
  new Game().start();
}

class Game extends GameBase {
  Game() : super.noAssets('ld28_warmup', 'canvas', 800, 800);


  void createEntities() {
    // TODO: implement createEntities
  }

  List<EntitySystem> getSystems() {
    return [
        new CanvasCleaningSystem(canvas),
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