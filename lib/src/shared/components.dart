part of shared;

class Figure extends Component {
  static int _nextId = 0;
  static const int _dist = 100;
  final int id;
  final Point p1, p2, p3, p4, center;
  final List<Point> cp;
  final int h;
  final double s, l;
  bool hover = false;
  Figure(this.center, this.p1, this.p2, this.p3, this.p4, this.cp)
      : id = _nextId++,
        h = random.nextInt(360),
        s = 15 + 70 * random.nextDouble(),
        l = 15 + 70 * random.nextDouble();
  factory Figure.random(int x, int y, {Figure left, Figure above}) {
    Point p1, p2, p3, p4;
    var cp = new List<Point>(8);
    if (left == null) {
      if (above == null) {
        p1 = new Point(x - random.nextInt(_dist), y - random.nextInt(_dist));
      } else {
        p1 = above.p2;
      }
      p2 = new Point(x - random.nextInt(_dist), y + random.nextInt(_dist));
      cp[0] = p1;
      cp[1] = p1;
    } else {
      p1 = left.p4;
      p2 = left.p3;
      cp[0] = left.cp[5];
      cp[1] = left.cp[4];
    }
    p3 = new Point(x + random.nextInt(_dist), y + random.nextInt(_dist));
    if (above == null) {
      p4 = new Point(x + random.nextInt(_dist), y - random.nextInt(_dist));
      cp[6] = p4;
      cp[7] = p4;
    } else {
      p4 = above.p3;
      cp[6] = above.cp[3];
      cp[7] = above.cp[2];
    }
    var diffX = p3.x - p2.x;
    cp[2] = new Point(
        p2.x + random.nextInt(diffX ~/ 2), p2.y - 40 + random.nextInt(80));
    cp[3] = new Point(
        p3.x - random.nextInt(diffX ~/ 2), p3.y - 40 + random.nextInt(80));
    var diffY = p3.y - p4.y;
    cp[4] = new Point(
        p3.x - 40 + random.nextInt(80), p3.y - random.nextInt(diffY ~/ 2));
    cp[5] = new Point(
        p4.x - 40 + random.nextInt(80), p4.y + random.nextInt(diffY ~/ 2));
    return new Figure(new Point(
            (p1.x + p2.x + p3.x + p4.x) / 4, (p1.y + p2.y + p3.y + p4.y) / 4),
        p1, p2, p3, p4, cp);
  }
}

class Render extends Component {}

abstract class Status extends Component {
  int x, y;
  double timer = 1.0;
  Status(this.x, this.y);
  String get text;
}
class Success extends Status {
  Success(int x, int y) : super(x, y);
  String get text => '+1';
}
class Failure extends Status {
  Failure(int x, int y) : super(x, y);
  String get text => '-1';
}

String randomColor() =>
    'rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})';
