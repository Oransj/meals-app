import 'package:flutter/material.dart';

/// A step or ingredient that can be checked.
class CheckableStep extends StatefulWidget {
  const CheckableStep({super.key, required this.text});

  final String text;

  @override
  State<CheckableStep> createState() {
    return _CheckableStepState();
  }
}

class _CheckableStepState extends State<CheckableStep> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      //To make everything centered in the style I wanted this need to be done. There is no other good way to avoid offset issues.
      //Need Stack with alignments to make it work
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Text(
              widget.text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}
