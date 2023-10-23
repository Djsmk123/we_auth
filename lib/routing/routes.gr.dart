// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:assignment/Features/Authentication/Presentations/Pages/authetication_page.dart'
    as _i1;
import 'package:assignment/Features/HomeScreen/home_screen.dart' as _i2;
import 'package:assignment/Features/SplashScreen/Page/Views/splash_screen.dart'
    as _i3;
import 'package:auto_route/auto_route.dart' as _i4;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    AuthPage.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthticationPage(),
      );
    },
    HomePage.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    Splash.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthticationPage]
class AuthPage extends _i4.PageRouteInfo<void> {
  const AuthPage({List<_i4.PageRouteInfo>? children})
      : super(
          AuthPage.name,
          initialChildren: children,
        );

  static const String name = 'AuthPage';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomePage extends _i4.PageRouteInfo<void> {
  const HomePage({List<_i4.PageRouteInfo>? children})
      : super(
          HomePage.name,
          initialChildren: children,
        );

  static const String name = 'HomePage';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SplashScreen]
class Splash extends _i4.PageRouteInfo<void> {
  const Splash({List<_i4.PageRouteInfo>? children})
      : super(
          Splash.name,
          initialChildren: children,
        );

  static const String name = 'Splash';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
