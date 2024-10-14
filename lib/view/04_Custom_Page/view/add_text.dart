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
              child: Container(
                child: TextEditor(
                  fonts: fonts,
                  text: text,
                  textStyle: textStyle,
                  textAlingment: textAlign,
                  minFontSize: 10,
                  paletteColors: [
                    Colors.black,
                    Colors.white,
                    Colors.blue,
                    Colors.red,
                    Colors.green,
                    Colors.yellow,
                    Colors.pink,
                    Colors.cyanAccent,
                  ],
                  decoration: EditorDecoration(
                    // textBackground: TextBackgroundDecoration(
                    //   disable: Text('Disable'),
                    //   enable: Text('Enable'),
                    // ),
                    doneButton: Icon(Icons.close, color: Colors.white),
                    fontFamily: Icon(Icons.title, color: Colors.white),
                    colorPalette: Icon(Icons.palette, color: Colors.white),
                    // alignment: AlignmentDecoration(
                    //   left: Text(
                    //     'left',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   center: Text(
                    //     'center',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   right: Text(
                    //     'right',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
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
          ),
        );
      },
    );
  }
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
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
