/* External dependencies */
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocktail/mocktail.dart';

/* Local dependencies */
import 'package:test_project/features/manufacturers/data/repositories/manufacturers_repository_impl.dart';
import 'package:test_project/features/manufacturers/presentation/logic/bloc/manufacturers_bloc.dart';
import 'package:test_project/generated/l10n.dart';

Widget wrapApp(Widget app) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    splitScreenMode: true,
    builder: (context, child) => (MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: child,
      supportedLocales: S.delegate.supportedLocales,
    )),
    child: app,
  );
}

class MockManufacturersRepositoryImpl extends Mock
    implements ManufacturersRepositoryImpl {}

class MockManufacturersBloc
    extends MockBloc<ManufacturersEvent, ManufacturersState>
    implements ManufacturersBloc {}
