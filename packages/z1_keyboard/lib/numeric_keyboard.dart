import 'package:flutter/material.dart';
import 'package:z1_keyboard/keyboard_button_config.dart';


class NumericKeyboard extends StatelessWidget {
  final List<KeyboardButtonConfig> buttons;
  final void Function(dynamic value) onPressed;
  final void Function(dynamic altValue)? onAltPressed;

  const NumericKeyboard({
    Key? key,
    required this.buttons,
    required this.onPressed,
    this.onAltPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 56;
    // Ostatni przycisk to nawigacja (góra/dół) w kolumnie
    final navButtons = buttons.where((b) => b.icon == Icons.arrow_upward || b.icon == Icons.arrow_downward).toList();
    final mainButtons = buttons.where((b) => b.icon != Icons.arrow_upward && b.icon != Icons.arrow_downward).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final btn in mainButtons)
          _SquareButton(
            label: btn.label,
            altLabel: btn.altLabel,
            icon: btn.icon,
            onPressed: () => onPressed(btn.value),
            onLongPress: btn.altValue != null && onAltPressed != null
                ? () => onAltPressed!(btn.altValue)
                : null,
            size: buttonSize,
          ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final btn in navButtons)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: _SquareButton(
                  label: btn.label,
                  altLabel: btn.altLabel,
                  icon: btn.icon,
                  onPressed: () => onPressed(btn.value),
                  onLongPress: btn.altValue != null && onAltPressed != null
                      ? () => onAltPressed!(btn.altValue)
                      : null,
                  size: buttonSize,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _SquareButton extends StatelessWidget {
  final String label;
  final String? altLabel;
  final IconData? icon;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double size;

  const _SquareButton({
    Key? key,
    required this.label,
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
                      label,
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