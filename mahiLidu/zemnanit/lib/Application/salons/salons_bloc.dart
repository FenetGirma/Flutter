import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zemnanit/Infrastructure/Models/salon_model.dart';
import 'package:zemnanit/Infrastructure/Repositories/salons_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'salons_event.dart';
part 'salons_state.dart';

class SalonsBloc extends Bloc<SalonsEvent, SalonsState> {
  final SalonsRepo salonsRepo;

  SalonsBloc(this.salonsRepo) : super(SalonsInitial()) {
    on<SalonsInitialFetchEvent>(salonsInitialFetchEvent);
  }

  FutureOr<void> salonsInitialFetchEvent(
      SalonsInitialFetchEvent event, Emitter<SalonsState> emit) async {
    List<SalonModel> salons = await SalonsRepo.fetchSalons();
    emit(SalonSuccessful(salons: salons));
    //
    //
  }
}
