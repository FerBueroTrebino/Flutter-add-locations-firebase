part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({required this.currentIndex});

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
}

class PageLoading extends BottomNavigationState {
  @override
  String toString() => 'PageLoading';
}

class MapPageLoaded extends BottomNavigationState {
  final LatLng userLocation;

  MapPageLoaded({required this.userLocation});

  @override
  String toString() => 'FirstPageLoaded with text: $userLocation';
}

class AddLocationPageLoaded extends BottomNavigationState {
  final LatLng userLocation;

  AddLocationPageLoaded({required this.userLocation});

  @override
  String toString() => 'SecondPageLoaded with number: $userLocation';
}
