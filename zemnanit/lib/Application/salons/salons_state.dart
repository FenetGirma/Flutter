part of 'salons_bloc.dart';

@immutable
sealed class SalonsState {}

final class SalonsInitial extends SalonsState {}

class SalonsActionState extends SalonsState {}

class SalonsLoaded extends SalonsState {}

class SalonSuccessful extends SalonsState {
  final List<SalonModel> salons;

  SalonSuccessful({required this.salons});
}
