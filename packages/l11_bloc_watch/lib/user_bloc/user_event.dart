import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserNameChanged extends UserEvent {
  final String name;

  const UserNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class UserAgeChanged extends UserEvent {
  final int age;

  const UserAgeChanged(this.age);

  @override
  List<Object> get props => [age];
} 