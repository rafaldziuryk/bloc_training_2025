import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  final String name;
  final int age;

  const UserState({this.name = 'John', this.age = 25});

  UserState copyWith({String? name, int? age}) {
    return UserState(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  @override
  List<Object> get props => [name, age];
} 