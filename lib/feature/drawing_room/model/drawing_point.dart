import 'package:flutter/material.dart';

class SingleLineDrawingData {
  int id;
  List<Offset> offsets;
  Color color;
  double width;
  bool eraser = false;

  SingleLineDrawingData({
    this.id = -1,
    this.offsets = const [],
    this.color = Colors.black,
    this.width = 2,
    this.eraser = false,
  });

  SingleLineDrawingData copyWith({List<Offset>? offsets}) {
    return SingleLineDrawingData(
      id: id,
      color: color,
      width: width,
      offsets: offsets ?? this.offsets,
      eraser: eraser,
    );
  }
}
