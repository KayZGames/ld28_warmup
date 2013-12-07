part of shared;

class Figure extends Component {
  static int _nextId = 0;
  static const int _dist = 100;
  final int id;
  final Point p1, p2, p3, p4;
  final String color;
  Figure(this.p1, this.p2, this.p3, this.p4) : id = _nextId++,
                                               color = randomColor();
  factory Figure.random(int x, int y, {Figure left, Figure above}) {
    Point p1, p2, p3, p4;
    if (left == null) {
      if (above == null) {
        p1 = new Point(x - random.nextInt(_dist), y - random.nextInt(_dist));
      } else {
        p1 = above.p2;
      }
      p2 = new Point(x - random.nextInt(_dist), y + random.nextInt(_dist));
    } else {
      p1 = left.p4;
      p2 = left.p3;
    }
    p3 = new Point(x + random.nextInt(_dist), y + random.nextInt(_dist));
    if (above == null) {
      p4 = new Point(x + random.nextInt(_dist), y - random.nextInt(_dist));
    } else {
      p4 = above.p3;
    }
    return new Figure(p1, p2, p3, p4);
  }

}

String randomColor() => 'rgb(${random.nextInt(256)}, ${random.nextInt(256)}, ${random.nextInt(256)})';