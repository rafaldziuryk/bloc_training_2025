part of 'detail_bloc.dart';

sealed class DetailEvent extends Equatable {
  const DetailEvent();
}

class LoadDetailEvent extends DetailEvent {
  @override
  List<Object?> get props => [];
} 