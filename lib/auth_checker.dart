import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placement/screens/error_screen.dart';
import 'package:placement/screens/loading_screen.dart';
import 'package:placement/screens/start_screen.dart';

import 'provider/auth_provider.dart';
import 'screens/admin_bottom_navigation_bar.dart';
import 'screens/introduction_app_screen.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final auth = ref.watch(authenticationProvider);

    return authState.when(
      data: (data) {
        if (data != null) {
          if (auth.isAdmin(data.uid)) {
            return const AdminBottomNavigationBar();
          } else {
            return const StartScreen();
          }
        }
        return const IntroAppPagesScreen();
      },
      loading: () => const LoadingScreen(),
      error: (e, trace) => ErrorScreen(e, trace),
    );
  }
}
