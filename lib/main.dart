import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placement/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_core/firebase_core.dart';
import 'auth_checker.dart';
import 'firebase_options.dart';
import 'screens/error_screen.dart';
import 'screens/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseinitializerProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple.shade200,
          titleSpacing: 2.0,
          titleTextStyle: GoogleFonts.labrada(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.15,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.labrada(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
          displayLarge: GoogleFonts.labrada(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: GoogleFonts.lato(
            fontSize: 20,
            color: Colors.deepPurple.shade900,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          bodySmall: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ).copyWith(
          background: Colors.white,
        ),
      ),
      // theme: ThemeData.dark(),
      home: initialize.when(
          data: (data) {
            return const AuthChecker();
          },
          loading: () => const LoadingScreen(),
          error: (e, stackTrace) => ErrorScreen(e, stackTrace)),
      routes: AppRoutes.routes,
    );
  }
}
