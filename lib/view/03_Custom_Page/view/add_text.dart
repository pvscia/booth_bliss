import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:text_editor/text_editor.dart';

typedef PointMoveCallback = void Function(Offset offset, Key? key);
class ResizableText extends StatefulWidget {
  final VoidCallback onDragStart;
  final PointMoveCallback onDragEnd;
  final PointMoveCallback onDragUpdate;

  const ResizableText({super.key,
    required this.onDragStart,
    required this.onDragEnd,
    required this.onDragUpdate});

  @override
  ResizableTextState createState() => ResizableTextState();
}

class ResizableTextState extends State<ResizableText> {

  //todo edit fontnya jadi apa aja macemnya
  final fonts = [
    'OpenSans',
    'Billabong',
    'GrandHotel',
    'Oswald',
    'Quicksand',
    'BeautifulPeople',
    'BeautyMountains',
    'BiteChocolate',
    'BlackberryJam',
    'BunchBlossoms',
    'CinderelaRegular',
    'Countryside',
    'Halimun',
    'LemonJelly',
    'QuiteMagicalRegular',
    'Tomatoes',
    'TropicalAsianDemoRegular',
    'VeganStyle',
  ];

  List<Color> colors = [
    Color(0xFFFF0000), // Red
    Color(0xFF00FF00), // Lime
    Color(0xFF0000FF), // Blue
    Color(0xFFFFFF00), // Yellow
    Color(0xFFFFA500), // Orange
    Color(0xFF800080), // Purple
    Color(0xFF00FFFF), // Aqua
    Color(0xFF000000), // Black
    Color(0xFF808080), // Gray
    Color(0xFF800000), // Maroon
    Color(0xFF008000), // Green
    Color(0xFF000080), // Navy
    Color(0xFFFFC0CB), // Pink
    Color(0xFFFF6347), // Tomato
    Color(0xFFFFD700), // Gold
    Color(0xFFADFF2F), // GreenYellow
    Color(0xFF4682B4), // SteelBlue
    Color(0xFFD2691E), // Chocolate
    Color(0xFFA52A2A), // Brown
    Color(0xFF5F9EA0), // CadetBlue
    Color(0xFFBDB76B), // DarkKhaki
    Color(0xFF2E8B57), // SeaGreen
    Color(0xFFDDA0DD), // Plum
    Color(0xFF00FA9A), // MediumSpringGreen
    Color(0xFFFF7F50), // Coral
    Color(0xFFFF4500), // OrangeRed
    Color(0xFFDC143C), // Crimson
    Color(0xFF9ACD32), // YellowGreen
    Color(0xFF4B0082), // Indigo
    Color(0xFFB8860B), // DarkGoldenRod
    Color(0xFF2F4F4F), // DarkSlateGray
    Color(0xFF66CDAA), // MediumAquamarine
    Color(0xFF9932CC), // DarkOrchid
    Color(0xFF7FFFD4), // Aquamarine
    Color(0xFF8A2BE2), // BlueViolet
    Color(0xFF8B0000), // DarkRed
    Color(0xFFB22222), // FireBrick
    Color(0xFF8FBC8F), // DarkSeaGreen
    Color(0xFF556B2F), // DarkOliveGreen
    Color(0xFFDA70D6), // Orchid
    Color(0xFFCD5C5C), // IndianRed
    Color(0xFFF08080), // LightCoral
    Color(0xFFFA8072), // Salmon
    Color(0xFF90EE90), // LightGreen
    Color(0xFF20B2AA), // LightSeaGreen
    Color(0xFF778899), // LightSlateGray
    Color(0xFFB0C4DE), // LightSteelBlue
    Color(0xFF7CFC00), // LawnGreen
    Color(0xFF6495ED), // CornflowerBlue
    Color(0xFF00CED1), // DarkTurquoise
    Color(0xFF1E90FF), // DodgerBlue
    Color(0xFF3CB371), // MediumSeaGreen
    Color(0xFFF4A460), // SandyBrown
    Color(0xFF8B4513), // SaddleBrown
    Color(0xFFDAA520), // GoldenRod
    Color(0xFF32CD32), // LimeGreen
    Color(0xFF9400D3), // DarkViolet
    Color(0xFF6A5ACD), // SlateBlue
    Color(0xFFFF69B4), // HotPink
    Color(0xFFEE82EE), // Violet
    Color(0xFF98FB98), // PaleGreen
    Color(0xFFAFEEEE), // PaleTurquoise
    Color(0xFFDB7093), // PaleVioletRed
    Color(0xFFFFB6C1), // LightPink
    Color(0xFFF0E68C), // Khaki
    Color(0xFFBC8F8F), // RosyBrown
    Color(0xFFF5DEB3), // Wheat
    Color(0xFF6B8E23), // OliveDrab
    Color(0xFF191970), // MidnightBlue
    Color(0xFFDEB887), // BurlyWood
    Color(0xFF00BFFF), // DeepSkyBlue
    Color(0xFFAFEEEE), // PaleTurquoise
    Color(0xFFBA55D3), // MediumOrchid
    Color(0xFF9370DB), // MediumPurple
    Color(0xFFFFE4C4), // Bisque
    Color(0xFFFFA07A), // LightSalmon
    Color(0xFFB0E0E6), // PowderBlue
    Color(0xFF66CDAA), // MediumAquamarine
    Color(0xFF778899), // LightSlateGray
    Color(0xFFFFE4B5), // Moccasin
    Color(0xFF6B8E23), // OliveDrab
    Color(0xFF20B2AA), // LightSeaGreen
    Color(0xFF87CEFA), // LightSkyBlue
    Color(0xFF87CEEB), // SkyBlue
    Color(0xFF4169E1), // RoyalBlue
    Color(0xFFFFEBCD), // BlanchedAlmond
    Color(0xFFFAFAD2), // LightGoldenRodYellow
    Color(0xFFEEE8AA), // PaleGoldenRod
    Color(0xFFE6E6FA), // Lavender
    Color(0xFFD8BFD8), // Thistle
    Color(0xFFB0C4DE), // LightSteelBlue
    Color(0xFF800000), // Maroon
    Color(0xFFDCDCDC), // Gainsboro
    Color(0xFFF5F5DC), // Beige
    Color(0xFFFFF8DC), // Cornsilk
    Color(0xFFFFF5EE), // Seashell
    Color(0xFFFFF0F5), // LavenderBlush
    Color(0xFFF0FFFF), // Azure
    Color(0xFFFAEBD7), // AntiqueWhite
    Color(0xFFF5FFFA), // MintCream
  ];

  TextStyle _textStyle = TextStyle(
    fontSize: 50,
    color: Colors.white,
    fontFamily: 'Oswald',
  );
  String _text = '';
  TextAlign _textAlign = TextAlign.center;

  void _tapHandler(text, textStyle, textAlign) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(
        milliseconds: 400,
      ), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return Container(
          color: Colors.black.withOpacity(0.4),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              // top: false,
              child: TextEditor(
                fonts: fonts,
                text: text,
                textStyle: textStyle,
                textAlingment: textAlign,
                minFontSize: 10,
                paletteColors: colors,
                decoration: EditorDecoration(
                  doneButton: Icon(Icons.close, color: Colors.white),
                  fontFamily: Icon(Icons.title, color: Colors.white),
                  colorPalette: Icon(Icons.palette, color: Colors.white),
                ),
                onEditCompleted: (style, align, text) {
                  setState(() {
                    _text = text;
                    _textStyle = style;
                    _textAlign = align;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());

  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This ensures that the _tapHandler is called after the widget has been rendered
      _tapHandler(_text, _textStyle, _textAlign);
    });
  }

  @override
  Widget build(BuildContext context) {
    late Offset offset;

    return Listener(
      onPointerMove: (event){
        offset = event.position;
        widget.onDragUpdate(offset,widget.key);
      },
      child: MatrixGestureDetector(
        onMatrixUpdate: (m,tm,sm,rm){
          notifier.value = m;
        },
        onScaleStart: () {
          widget.onDragStart();
        },
        onScaleEnd: () {
          widget.onDragEnd(offset,widget.key);
        },
        child: AnimatedBuilder(
          animation: notifier,
          builder: (ctx, child) {
            return Transform(
              transform: notifier.value,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      transform: notifier.value,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: GestureDetector(
                          onTap: () => _tapHandler(_text, _textStyle, _textAlign),
                          child: Text(
                            _text,
                            style: _textStyle,
                            textAlign: _textAlign,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
