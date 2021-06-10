import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:flutter_add_locations_firebase/generated/l10n.dart';

import 'pages/add_location_page.dart';
import 'pages/map_page.dart';

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carrots Lab Test',
        ),
      ),
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (BuildContext context, BottomNavigationState state) {
          if (state is PageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is MapPageLoaded) {
            return MapPage(
              userLocation: state.userLocation,
            );
          }
          if (state is AddLocationPageLoaded) {
            return AddLocationPage(userLocation: state.userLocation);
          }
          return Container();
        },
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
              builder: (BuildContext context, BottomNavigationState state) {
        return BottomNavigationBar(
          currentIndex:
              context.select((BottomNavigationBloc bloc) => bloc.currentIndex),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: AppLocalizations.of(context).map,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_location_alt_outlined),
              label: AppLocalizations.of(context).locations,
            ),
          ],
          onTap: (index) => context
              .read<BottomNavigationBloc>()
              .add(PageTapped(index: index)),
        );
      }),
    );
  }
}
