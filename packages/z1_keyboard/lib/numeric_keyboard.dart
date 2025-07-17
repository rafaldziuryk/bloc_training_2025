import 'package:flutter/material.dart';

class NumericKeyboard extends StatelessWidget {
  final void Function(int digit) onDigitPressed;
  final void Function(String altValue)? onAltPressed;
  final VoidCallback onArrowUp;
  final VoidCallback onArrowDown;
  final VoidCallback onBackspace;
  final VoidCallback onSubmit;

  /// Alternatywne wartości dla przycisków (np. po długim naciśnięciu lub shift)
  final Map<int, String>? altDigits;
  final String? altBackspace;
  final String? altSubmit;
  final String? altArrowUp;
  final String? altArrowDown;

  const NumericKeyboard({
    Key? key,
    required this.onDigitPressed,
    this.onAltPressed,
    required this.onArrowUp,
    required this.onArrowDown,
    required this.onBackspace,
    required this.onSubmit,
    this.altDigits,
    this.altBackspace,
    this.altSubmit,
    this.altArrowUp,
    this.altArrowDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 56;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Cyfry 1-9
        for (var i = 1; i <= 9; i++)
          _SquareButton(
            label: '$i',
            altLabel: altDigits?[i],
            onPressed: () => onDigitPressed(i),
            onLongPress: altDigits?[i] != null && onAltPressed != null
                ? () => onAltPressed!(altDigits![i]!)
                : null,
            size: buttonSize,
          ),
        // 0
        _SquareButton(
          label: '0',
          altLabel: altDigits?[0],
          onPressed: () => onDigitPressed(0),
          onLongPress: altDigits?[0] != null && onAltPressed != null
              ? () => onAltPressed!(altDigits![0]!)
              : null,
          size: buttonSize,
        ),
        // Backspace
        _SquareButton(
          icon: Icons.backspace,
          altLabel: altBackspace,
          onPressed: onBackspace,
          onLongPress: altBackspace != null && onAltPressed != null
              ? () => onAltPressed!(altBackspace!)
              : null,
          size: buttonSize,
        ),
        // Zatwierdź
        _SquareButton(
          icon: Icons.check,
          altLabel: altSubmit,
          onPressed: onSubmit,
          onLongPress: altSubmit != null && onAltPressed != null
              ? () => onAltPressed!(altSubmit!)
              : null,
          size: buttonSize,
        ),
        // Nawigacja (góra/dół) w kolumnie po prawej
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SquareButton(
              icon: Icons.arrow_upward,
              altLabel: altArrowUp,
              onPressed: onArrowUp,
              onLongPress: altArrowUp != null && onAltPressed != null
                  ? () => onAltPressed!(altArrowUp!)
                  : null,
              size: buttonSize,
            ),
            const SizedBox(height: 8),
            _SquareButton(
              icon: Icons.arrow_downward,
              altLabel: altArrowDown,
              onPressed: onArrowDown,
              onLongPress: altArrowDown != null && onAltPressed != null
                  ? () => onAltPressed!(altArrowDown!)
                  : null,
              size: buttonSize,
            ),
          ],
        ),
      ],
    );
  }
}

class _SquareButton extends StatelessWidget {
  final String? label;
  final String? altLabel;
  final IconData? icon;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double size;

  const _SquareButton({
    Key? key,
    this.label,
    this.altLabel,
    this.icon,
    required this.onPressed,
    this.onLongPress,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        width: size,
        height: size,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          onLongPress: onLongPress,
          child: icon != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 28),
                    if (altLabel != null)
                      Text(
                        altLabel!,
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label ?? '',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    if (altLabel != null)
                      Text(
                        altLabel!,
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
} 