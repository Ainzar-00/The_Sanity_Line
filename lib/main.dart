import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/assessment.dart';
import 'screens/authentication_screen.dart';
import 'screens/home_screen.dart';
import 'screens/nutrition_screen.dart';
import 'screens/splash_screen.dart';
import 'package:workmanager/workmanager.dart';
import 'services/midnight_reset_service.dart';
import 'services/offline_sync_service.dart';
import 'database/app_database.dart';
import 'providers/database_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == MidnightResetService.taskName) {
      final auth = FirebaseAuth.instance;
      final userId = auth.currentUser?.uid;
      if (userId != null) {
        final db = AppDatabase();
        await MidnightResetService.runReset(userId, db);
      }
      MidnightResetService.scheduleNext();
    }
    return true;
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );
  MidnightResetService.scheduleNext();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // Listen to network changes to trigger offline sync
    Connectivity().onConnectivityChanged.listen((results) {
      if (!results.contains(ConnectivityResult.none)) {
        final db = ref.read(dbProvider);
        OfflineSyncService.attemptSync(db);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) {
          final userId =
              ModalRoute.of(context)?.settings.arguments as String?;
          return HomeScreen(userId: userId);
        },
        '/nutrition': (context) => const NutritionScreen(),
        '/onboarding/nutrition': (context) => const NutritionScreen(),
        '/assessment': (context) {
          final userId =
              ModalRoute.of(context)!.settings.arguments as String;
          return AssessmentScreen(userId: userId);
        },
      },
    );
  }
}