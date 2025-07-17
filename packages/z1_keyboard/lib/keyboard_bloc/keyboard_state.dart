part of 'keyboard_bloc.dart';

final class KeyboardState extends Equatable {

  final KeyboardType type;
  final List<KeyboardButtonConfig> mainKeys;
  final Map<KeyboardFunctionals, KeyboardButtonConfig> specialKeys;

  const KeyboardState({
    required this.type,
    required this.mainKeys,
    required this.specialKeys,
  });

  KeyboardState copyWith({
    KeyboardType? type,
    List<KeyboardButtonConfig>? mainKeys,
    Map<KeyboardFunctionals, KeyboardButtonConfig>? specialKeys,
  }) {
    return KeyboardState(
      type: type ?? this.type,
      mainKeys: mainKeys ?? this.mainKeys,
      specialKeys: specialKeys ?? this.specialKeys,
    );
  }

  @override
  List<Object?> get props => [type, mainKeys, specialKeys];

}
