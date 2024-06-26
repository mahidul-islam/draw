import 'dart:math';
import 'dart:ui';

import 'package:drawing_apps/core/theme/app_color.dart';
import 'package:drawing_apps/feature/drawing_room/model/drawing_point.dart';
import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class DrawingRoomScreen extends StatefulWidget {
  const DrawingRoomScreen({super.key});

  @override
  State<DrawingRoomScreen> createState() => _DrawingRoomScreenState();
}

class _DrawingRoomScreenState extends State<DrawingRoomScreen> {
  List<Color> avaiableColor = [
    Colors.black,
    Colors.red,
    Colors.amber,
    Colors.blue,
    Colors.green,
    Colors.brown,
  ];

  List<SingleLineDrawingData> historyDrawingPoints = <SingleLineDrawingData>[];
  List<SingleLineDrawingData> drawingPoints = <SingleLineDrawingData>[];

  Color? selectedColor = Colors.black;
  double selectedWidth = 20.0;
  bool isEraser = false;

  SingleLineDrawingData? currentDrawingPoint;

  late Path penguinePath;

  @override
  void initState() {
    penguinePath = parseSvgPath(
        "M150.125 282.462C140.912 283.412 122.837 284.337 106.375 284.375C98.4781 284.457 90.5818 284.165 82.7125 283.5C79.6455 283.231 76.6034 282.73 73.6125 282C72.1463 281.636 70.7219 281.121 69.3625 280.462C67.2477 279.442 65.4693 277.837 64.2375 275.837C62.6874 273.271 62.0201 270.268 62.3375 267.287C62.6625 264.35 63.875 261.962 65.1625 260.175C67.5625 256.825 71.1125 254.4 74 252.712C75.275 251.975 76.625 251.287 77.9875 250.625C72.4056 243.812 67.9685 236.137 64.85 227.9C63.3604 229.773 61.7793 231.571 60.1125 233.287C58.6986 234.765 57.1362 236.093 55.45 237.25C54.1 238.137 50.8375 240.112 46.675 239.6C45.1258 239.386 43.6412 238.839 42.323 237.998C41.0048 237.156 39.884 236.04 39.0375 234.725C38.0701 233.224 37.3485 231.578 36.9 229.85C35.9938 226.138 35.6109 222.318 35.7625 218.5C35.925 209.5 37.9375 196.5 43.425 178.837C47.675 165.187 52.4125 153.437 58.7875 137.637L58.875 137.425L62.575 128.25C62.0875 99.275 67.825 71.675 81.6875 50.875C96.1375 29.2 118.937 15.6875 150.012 15.625H150.237C181.312 15.6875 204.112 29.2 218.562 50.875C232.412 71.675 238.162 99.275 237.687 128.25C238.975 131.487 240.2 134.525 241.375 137.425L241.462 137.65C247.837 153.437 252.587 165.187 256.825 178.837C262.312 196.487 264.325 209.487 264.487 218.5C264.575 222.95 264.2 226.787 263.362 229.85C262.937 231.35 262.3 233.1 261.212 234.725C260.366 236.04 259.245 237.156 257.927 237.998C256.609 238.839 255.124 239.386 253.575 239.6C249.412 240.1 246.15 238.137 244.8 237.25C243.114 236.093 241.551 234.765 240.137 233.287C238.471 231.571 236.889 229.773 235.4 227.9C232.286 236.136 227.853 243.811 222.275 250.625C223.625 251.275 224.962 251.975 226.237 252.712C229.137 254.4 232.675 256.837 235.087 260.187C236.375 261.962 237.587 264.35 237.912 267.275C238.25 270.35 237.512 273.287 236.012 275.837C234.781 277.837 233.003 279.442 230.887 280.462C229.529 281.125 228.104 281.645 226.637 282.012C223.646 282.738 220.604 283.235 217.537 283.5C210.9 284.15 202.462 284.387 193.875 284.375C177.412 284.35 159.337 283.412 150.125 282.462ZM81.35 129.712C80.6375 102.337 86 78.2375 97.2875 61.275C108.25 44.825 125.225 34.4 150.125 34.375C175.025 34.4125 192 44.825 202.962 61.275C214.25 78.2375 219.612 102.337 218.9 129.725C218.865 130.999 219.091 132.266 219.562 133.45L223.987 144.45C230.462 160.462 234.925 171.55 238.912 184.4C242.112 194.675 243.925 202.9 244.875 209.237C241.45 204.375 238.75 200.075 238.5 199.675C237.545 198.139 236.165 196.912 234.529 196.143C232.892 195.373 231.067 195.094 229.275 195.337H229.25C227.01 195.648 224.958 196.758 223.471 198.462C221.985 200.167 221.165 202.351 221.162 204.612C221.137 217.062 214.525 234.412 199.575 247.087C198.61 247.903 197.821 248.906 197.253 250.035C196.686 251.164 196.352 252.395 196.273 253.656C196.193 254.917 196.37 256.181 196.791 257.372C197.212 258.563 197.87 259.657 198.725 260.587C199.854 261.811 201.285 262.729 202.875 263.225C204.637 263.762 206.762 264.475 208.95 265.312C204.45 265.537 199.325 265.637 193.9 265.625C177.337 265.6 158.15 264.537 150.125 263.662C142.087 264.537 122.912 265.6 106.35 265.625C101.327 265.643 96.305 265.539 91.2875 265.312C93.293 264.55 95.3233 263.853 97.375 263.225C98.9625 262.732 100.39 261.826 101.512 260.6C102.483 259.541 103.21 258.274 103.613 256.896C104.016 255.517 104.097 254.065 103.85 252.65C103.475 250.485 102.351 248.508 100.675 247.087C85.725 234.412 79.1125 217.062 79.0875 204.612C79.0848 202.351 78.2647 200.167 76.7785 198.462C75.2923 196.758 73.24 195.648 71 195.337H70.975C69.1808 195.091 67.3536 195.369 65.7143 196.139C64.075 196.909 62.6938 198.137 61.7375 199.675C61.4875 200.075 58.8 204.375 55.375 209.237C56.7312 200.819 58.7244 192.516 61.3375 184.4C65.325 171.55 69.7875 160.475 76.2625 144.45L80.6875 133.45C81.1592 132.266 81.3846 130.999 81.35 129.725");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Canvas
          GestureDetector(
            onPanStart: (details) {
              setState(() {
                currentDrawingPoint = SingleLineDrawingData(
                  id: DateTime.now().microsecondsSinceEpoch,
                  offsets: [
                    details.localPosition,
                  ],
                  color: selectedColor ?? Colors.transparent,
                  width: selectedWidth,
                  eraser: isEraser,
                );

                if (currentDrawingPoint == null) return;
                drawingPoints.add(currentDrawingPoint!);
                historyDrawingPoints = List.of(drawingPoints);
              });
            },
            onPanUpdate: (details) {
              setState(() {
                if (currentDrawingPoint == null) return;

                currentDrawingPoint = currentDrawingPoint?.copyWith(
                  offsets: currentDrawingPoint!.offsets
                    ..add(details.localPosition),
                );
                drawingPoints.last = currentDrawingPoint!;
                historyDrawingPoints = List.of(drawingPoints);
              });
            },
            onPanEnd: (_) {
              currentDrawingPoint = null;
            },
            child: ColoredBox(
              color: Colors.white,
              child: CustomPaint(
                painter: DrawingPainter(
                  drawingPoints: drawingPoints,
                  svgPath: penguinePath,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ),

          /// color pallet
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 16,
            right: 16,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: avaiableColor.length + 1,
                separatorBuilder: (_, __) {
                  return const SizedBox(width: 8);
                },
                itemBuilder: (context, index) {
                  if (index == avaiableColor.length) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          isEraser = true;
                          selectedColor = null;
                        });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Colors.amberAccent,
                          shape: BoxShape.circle,
                        ),
                        foregroundDecoration: BoxDecoration(
                          border: isEraser == true
                              ? Border.all(
                                  color: AppColor.primaryColor, width: 4)
                              : null,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.delete_sweep_outlined),
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = avaiableColor[index];
                        isEraser = false;
                      });
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: avaiableColor[index],
                        shape: BoxShape.circle,
                      ),
                      foregroundDecoration: BoxDecoration(
                        border: selectedColor == avaiableColor[index]
                            ? Border.all(color: AppColor.primaryColor, width: 4)
                            : null,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          /// pencil size
          Positioned(
            top: MediaQuery.of(context).padding.top + 80,
            right: 0,
            bottom: 150,
            child: RotatedBox(
              quarterTurns: 3, // 270 degree
              child: Slider(
                value: pow(selectedWidth, 1 / 1.5).toDouble(),
                min: 1,
                max: 20,
                onChanged: (value) {
                  setState(() {
                    selectedWidth = pow(value, 1.5).toDouble();
                  });
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "Undo",
            onPressed: () {
              if (drawingPoints.isNotEmpty && historyDrawingPoints.isNotEmpty) {
                setState(() {
                  drawingPoints.removeLast();
                });
              }
            },
            child: const Icon(Icons.undo),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: "Redo",
            onPressed: () {
              setState(() {
                if (drawingPoints.length < historyDrawingPoints.length) {
                  // 6 length 7
                  final index = drawingPoints.length;
                  drawingPoints.add(historyDrawingPoints[index]);
                }
              });
            },
            child: const Icon(Icons.redo),
          ),
        ],
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<SingleLineDrawingData> drawingPoints;
  final Path svgPath;

  DrawingPainter({required this.drawingPoints, required this.svgPath});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate((size.width / 2) - 150, (size.height / 2) - 150);
    canvas.clipPath(svgPath);
    canvas.drawPath(
      svgPath,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.black
        ..isAntiAlias = true
        ..strokeWidth = 5,
    );
    canvas.translate(-((size.width / 2) - 150), -((size.height / 2) - 150));

    // canvas.drawColor(Colors.amberAccent.withOpacity(0.5), BlendMode.srcOver);
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    for (var drawingPoint in drawingPoints) {
      final paint = Paint()
        ..color = drawingPoint.color
        ..isAntiAlias = true
        ..strokeWidth = drawingPoint.width
        ..strokeCap = StrokeCap.round
        ..blendMode = drawingPoint.eraser ? BlendMode.clear : BlendMode.srcOver;

      for (var i = 0; i < drawingPoint.offsets.length; i++) {
        var notLastOffset = i != drawingPoint.offsets.length - 1;

        if (notLastOffset) {
          final current = drawingPoint.offsets[i];
          final next = drawingPoint.offsets[i + 1];
          canvas.drawLine(current, next, paint);
        } else {
          canvas.drawPoints(PointMode.points, drawingPoint.offsets, paint);
        }
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
