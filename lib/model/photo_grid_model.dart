class PhotoGridModel {
  final double width;
  final double height;
  final List<GridCoordinate> coordinates;

  PhotoGridModel({
    required this.width,
    required this.height,
    required this.coordinates,
  });
}

class GridCoordinate {
  final double x;
  final double y;

  GridCoordinate({
    required this.x,
    required this.y,
  });
}

// Define each grid type as a static instance of PhotoGridModel
class PhotoGridModels {
  static final square1 = PhotoGridModel(
    width: 306.36,
    height: 392.4375,
    coordinates: [
      GridCoordinate(x: 17.02, y: 30.1875),
    ],
  );

  static final square2x2 = PhotoGridModel(
    width: 145.88571428571427,
    height: 193.2,
    coordinates: [
      GridCoordinate(x: 16.209523809523812, y: 18.1125), // Top left
      GridCoordinate(x: 178.3047619047619, y: 18.1125),  // Top right
      GridCoordinate(x: 16.209523809523812, y: 229.425), // Bottom left
      GridCoordinate(x: 178.3047619047619, y: 229.425),  // Bottom right
    ],
  );

  static final stair2x2 = PhotoGridModel(
    width: 145.88571428571427,
    height: 193.2,
    coordinates: [
      GridCoordinate(x: 16.209523809523812, y: 18.1125),  // Top left
      GridCoordinate(x: 178.3047619047619, y: 60.375),    // Top right
      GridCoordinate(x: 16.209523809523812, y: 229.425),  // Bottom left
      GridCoordinate(x: 178.3047619047619, y: 271.6875),  // Bottom right
    ],
  );

  static final square2x3 = PhotoGridModel(
    width: 145.88571428571427,
    height: 120.75,
    coordinates: [
      GridCoordinate(x: 16.209523809523812, y: 20.125), // Top left
      GridCoordinate(x: 178.3047619047619, y: 20.125),  // Top right
      GridCoordinate(x: 16.209523809523812, y: 161.0),  // Middle left
      GridCoordinate(x: 178.3047619047619, y: 161.0),   // Middle right
      GridCoordinate(x: 16.209523809523812, y: 301.875),// Bottom left
      GridCoordinate(x: 178.3047619047619, y: 301.875), // Bottom right
    ],
  );

  static final circle1 = PhotoGridModel(
    width: 306.36,
    height: 306.36,
    coordinates: [
      GridCoordinate(x: 17.02, y: 30.1875),
    ],
  );

  static final circle2x3 = PhotoGridModel(
    width: 145.88571428571427,
    height: 145.88571428571427,
    coordinates: [
      GridCoordinate(x: 16.209523809523812, y: 11.335714285714275), // Top left
      GridCoordinate(x: 178.3047619047619, y: 11.335714285714275),  // Top right
      GridCoordinate(x: 16.209523809523812, y: 168.55714285714282), // Middle left
      GridCoordinate(x: 178.3047619047619, y: 168.55714285714282),  // Middle right
      GridCoordinate(x: 16.209523809523812, y: 325.77857142857135), // Bottom left
      GridCoordinate(x: 178.3047619047619, y: 325.77857142857135),  // Bottom right
    ],
  );
}
