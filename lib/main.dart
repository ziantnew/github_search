import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_api/provider/network_provider.dart';
import 'view/Search/search_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    var connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (connectivityStatusProvider != ConnectivityStatus.isConnected) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
                 '네트워크 연결을 확인해 주세요.' ,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          backgroundColor: Colors.red
        ),
      );
      }
    });

    return const Scaffold(
      body: SearchMain(),
    );
  }
}
