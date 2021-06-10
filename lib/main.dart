import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/bottom_navigation/bottom_navigation_bloc.dart';
import 'ui/app_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'repositories/repositories.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('ERROR AL INICIAR FIREBASE');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
            home: BlocProvider<BottomNavigationBloc>(
              create: (context) => BottomNavigationBloc(
                mapPageRepository: MapPageRepository(),
                addLocationPageRepository: AddLocationPageRepository(),
              )..add(AppStarted()),
              child: AppScreen(),
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.delegate.supportedLocales,
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
