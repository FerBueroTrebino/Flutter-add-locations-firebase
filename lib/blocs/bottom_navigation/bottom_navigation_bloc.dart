import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../repositories/repositories.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc(
      {required this.mapPageRepository,
      required this.addLocationPageRepository})
      : super(PageLoading());

  final MapPageRepository mapPageRepository;
  final AddLocationPageRepository addLocationPageRepository;

  int currentIndex = 0;

  @override
  Stream<BottomNavigationState> mapEventToState(
      BottomNavigationEvent event) async* {
    if (event is AppStarted) {
      this.add(PageTapped(index: this.currentIndex));
    }
    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      yield PageLoading();

      if (this.currentIndex == 0) {
        LatLng data = await _getMapPageData();
        yield MapPageLoaded(userLocation: data);
      }
      if (this.currentIndex == 1) {
        LatLng data = await _getAddLocationPageData();
        yield AddLocationPageLoaded(userLocation: data);
      }
    }
  }

  Future<LatLng> _getMapPageData() async {
    LatLng data = mapPageRepository.data;
    await mapPageRepository.getUserLocation();
    data = mapPageRepository.data;

    return data;
  }

  Future<LatLng> _getAddLocationPageData() async {
    LatLng data = addLocationPageRepository.data;
    await addLocationPageRepository.getUserLocation();
    data = addLocationPageRepository.data;

    return data;
  }
}
