import 'package:flutter/material.dart';

import '../widgets/app_settings.dart';

class ColorizedText extends StatelessWidget {
  final String text;
  final List<Color> colors;
  final TextAlign textAlign;
  final TextStyle textStyle;

  const ColorizedText({
    super.key,
    required this.text,
    required this.colors,
    this.textAlign = AppSettings.textAlignCenter,
    this.textStyle = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    List<String> characters = text.split('');
    List<TextSpan> textSpans = List.generate(
      characters.length,
      (index) {
        int colorIndex = index % colors.length;
        return TextSpan(
          text: characters[index],
          style: textStyle.copyWith(color: colors[colorIndex]),
        );
      },
    );

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: textSpans,
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class ScaleAnimatedText extends StatefulWidget {
//   final String text;
//   final List<Color> colors;
//   final TextAlign textAlign;
//   final TextStyle textStyle;

//   const ScaleAnimatedText({
//     Key? key,
//     required this.text,
//     required this.colors,
//     this.textAlign = TextAlign.center,
//     this.textStyle = const TextStyle(),
//   }) : super(key: key);

//   @override
//   _ScaleAnimatedTextState createState() => _ScaleAnimatedTextState();
// }

// class _ScaleAnimatedTextState extends State<ScaleAnimatedText>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<String> characters = widget.text.split('');
//     List<TextSpan> textSpans = List.generate(
//       characters.length,
//       (index) {
//         int colorIndex = index % widget.colors.length;
//         return TextSpan(
//           text: characters[index],
//           style: widget.textStyle.copyWith(
//             color: widget.colors[colorIndex],
//           ),
//         );
//       },
//     );

//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return ScaleTransition(
//           scale: _controller,
//           child: RichText(
//             textAlign: widget.textAlign,
//             text: TextSpan(
//               style: DefaultTextStyle.of(context).style,
//               children: textSpans,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
