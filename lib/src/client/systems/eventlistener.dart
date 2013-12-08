part of client;


class FigureEventListeningSystem extends VoidEntitySystem {
  CanvasElement canvas;
  CanvasRenderingContext2D hiddenCtx;
  List<Figure> figures;
  InformationRenderer info;
  FigureHighlightingSystem highlighter;
  PathCreator pathCreator;
  FigureEventListeningSystem(this.canvas, this.figures);

  void initialize() {
    info = world.getSystem(InformationRenderer);
    highlighter = world.getSystem(FigureHighlightingSystem);
    pathCreator = world.getSystem(PathCreator);
    var hiddenCanvas = new CanvasElement(width: canvas.width, height: canvas.height);
    hiddenCtx = hiddenCanvas.context2D;
    figures.forEach((f) {
      hiddenCtx..beginPath()
               ..moveTo(f.p1.x, f.p1.y)
               ..setStrokeColorRgb(f.id, 0, 0, 1)
               ..setFillColorRgb(f.id, 0, 0, 1)
               ..bezierCurveTo(f.cp[0].x, f.cp[0].y, f.cp[1].x, f.cp[1].y, f.p2.x, f.p2.y)
               ..bezierCurveTo(f.cp[2].x, f.cp[2].y, f.cp[3].x, f.cp[3].y, f.p3.x, f.p3.y)
               ..bezierCurveTo(f.cp[4].x, f.cp[4].y, f.cp[5].x, f.cp[5].y, f.p4.x, f.p4.y)
               ..bezierCurveTo(f.cp[6].x, f.cp[6].y, f.cp[7].x, f.cp[7].y, f.p1.x, f.p1.y)
               ..fill()
               ..stroke();
    });
    canvas.onMouseMove.listen((event) {
      react(event, (id) => highlighter.hoverId = id);
    });
    StreamSubscription subscription;
    subscription = canvas.onClick.listen((event) {
      react(event, (id) => pathCreator.start(id));
      info.start();
      subscription.cancel();
    });
  }

  void react(MouseEvent event, void action(int id)) {
    var imageData = hiddenCtx.getImageData(event.offset.x-1, event.offset.y+1, 3, 3);
    var data = imageData.data;
    // there is some anti aliasing going on.. make sure the right color is selected
    // and check color of edges and center
    if (data[19] == 255 && data[0] == data[8] && data[20] == data[28] && data[16] == data[0] && data[16] == data[20]) {
      action(data[0]);
    }
  }

  void processSystem() {}
}