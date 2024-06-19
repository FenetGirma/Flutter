part of 'salons_bloc.dart';

@immutable
sealed class SalonsState {}

final class SalonsInitial extends SalonsState {}

class SalonDeletionErrorState extends SalonsActionState {
  final String error;

  SalonDeletionErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class SalonsActionState extends SalonsState {}

class SalonsDeleted extends SalonsState {}

class SalonsLoaded extends SalonsState {}

class SalonSuccessful extends SalonsState {
  final List<SalonModel> salons;

  SalonSuccessful({required this.salons});
}
