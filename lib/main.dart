import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter_demo/entity/person.dart';
import 'boxes.dart';
import 'view/home_page.dart';

/// Steps:
/// 1. Add dependencies
///      hive, hive_flutter, hive_generator, build_runner,
/// 2. Create class (Generate Adapter)
/// 3. Auto generate class.g
///      dart run build_runner build
///
/// 4. initFlutter
/// 5. Register adapter
/// 6. Open Box and create Box file
///
/// 7. CRUD operations

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  boxPersons = await Hive.openBox<Person>('personBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
