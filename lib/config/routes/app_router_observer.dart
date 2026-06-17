import 'package:flutter/material.dart';

class AppRouterObserver extends RouteObserver<ModalRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute?.settings.name != null) {
      debugPrint('didPush previousRoute => ${previousRoute?.settings.name}');
    }

    if (route.settings.name != null) {
      debugPrint('didPush route => ${route.settings.name}');
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute?.settings.name != null) {
      debugPrint('didReplace newRoute => ${newRoute?.settings.name}');
    }

    if (oldRoute?.settings.name != null) {
      debugPrint('didReplace oldRoute => ${oldRoute?.settings.name}');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute?.settings.name != null) {
      debugPrint('didPop previousRoute => ${previousRoute?.settings.name}');
    }

    if (route.settings.name != null) {
      debugPrint('didPop route => ${route.settings.name}');
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute?.settings.name != null) {
      debugPrint('didRemove previousRoute => ${previousRoute?.settings.name}');
    }

    if (route.settings.name != null) {
      debugPrint('didRemove route => ${route.settings.name}');
    }
  }
}
