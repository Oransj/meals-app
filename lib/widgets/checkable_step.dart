import 'package:flutter/material.dart';

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
      alignment: Alignment.center,
      children: [
        /* const SizedBox(
          width: 32.0,
        ), */
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
