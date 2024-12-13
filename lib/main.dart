import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mappbox_app/pages/map_page.dart';
import 'package:mappbox_app/provider/map_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  String setAccessToken = const String.fromEnvironment("ACCESS_TOKEN");
  MapboxOptions.setAccessToken(setAccessToken);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapProvider()),
      ],
      child: const MaterialApp(
        title: 'Mapbox App',
        home: MapPage(),
      ),
    );
  }
}
