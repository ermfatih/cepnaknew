import 'package:flutter/material.dart';
import 'package:i18n_extension/default.i18n.dart';

class SeeMoreText extends StatefulWidget {
  final String text;
  final int maxLines;

  const SeeMoreText({
    Key? key,
    required this.text,
    this.maxLines = 2,
  }) : super(key: key);

  @override
  SeeMoreTextState createState() => SeeMoreTextState();
}

class SeeMoreTextState extends State<SeeMoreText> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          key: Key(widget.text),
          firstChild: Text(
            widget.text,
            maxLines: widget.maxLines,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(height: 1.12, fontWeight: FontWeight.w300),
          ),
          secondChild: Text(
            widget.text,
            maxLines: expanded ? null : widget.maxLines,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(height: 1.12, fontWeight: FontWeight.w300),
          ),
          crossFadeState:
              expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        if (doesTextExceedMaxLines(context))
          InkWell(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Text(
              expanded ? "See less".i18n : "See more".i18n,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  height: 1.12,
                  color: Colors.orange, // Change this to your desired color
                  fontWeight: FontWeight.w300),
            ),
          ),
      ],
    );
  }

  bool doesTextExceedMaxLines(BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(
          text: widget.text, style: Theme.of(context).textTheme.bodySmall),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    final textHeight = textPainter.height;
    final lineHeight = textPainter.preferredLineHeight;
    final calculatedMaxLines = (textHeight / lineHeight).ceil() * 2;

    return calculatedMaxLines > widget.maxLines;
  }
}
