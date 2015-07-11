part of shared;

class PathCreator extends EntitySystem {
  bool started = false;
  double timeDelta = 1.0;
  double startTime;
  int currentId = null;
  int lastId = -1;
  Queue<int> path;
  int maxId, maxX;
  FigureHighlightingSystem highlighter;
  PathCreator(this.path, int maxX, int maxY)
      : maxId = maxX * maxY,
        maxX = maxX,
        super(Aspect.getEmpty());

  void initialize() {
    highlighter = world.getSystem(FigureHighlightingSystem);
  }

  void start(int id) {
    currentId = id;
    startTime = time;
    started = true;
  }

  void processEntities(_) {
    startTime = time;
    int nextId;
    var direction = getDirections();
    do {
      nextId = currentId + direction[random.nextInt(direction.length)];
    } while (nextId == lastId);
    path.add(nextId);
    lastId = currentId;
    currentId = nextId;
    highlighter.pathId = nextId;
  }

  List<int> getDirections() {
    var direction = [];
    if (currentId > maxX) {
      direction.add(-maxX);
    }
    if (currentId < maxId - maxX - 1) {
      direction.add(maxX);
    }
    if (currentId % maxX > 0) {
      direction.add(-1);
    }
    if (currentId % maxX < maxX - 1) {
      direction.add(1);
    }
    return direction;
  }

  bool checkProcessing() => started && time - (startTime + timeDelta) > 0;
}

class FigureHighlightingSystem extends EntityProcessingSystem {
  List<Figure> figures;
  Mapper<Figure> fm;
  int hoverId = null;
  int pathId = null;
  FigureHighlightingSystem(this.figures)
      : super(Aspect.getAspectForAllOf([Figure]));

  void initialize() {
    fm = new Mapper<Figure>(Figure, world);
  }

  void processEntity(Entity entity) {
    var f = fm[entity];
    if ((f.id == hoverId || f.id == pathId) && !f.hover) {
      f.hover = true;
      entity.addComponent(new Render());
      entity.changedInWorld();
    } else if (f.hover && f.id != hoverId && f.id != pathId) {
      f.hover = false;
      entity.addComponent(new Render());
      entity.changedInWorld();
    }
  }
}
