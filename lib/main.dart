import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/model/song_model.dart';
import 'package:music_app/screens/Home.dart';
import 'package:music_app/screens/SongScreen.dart';
import 'package:music_app/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(SongsAdapter());
  }
  await Hive.openBox<Songs>("Allsongs");
  await Hive.openBox<List>('Playlist');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              )),

      home: MyCustomSplashScreen(),

      //  getPages: [
      //  GetPage(name: '/', page: ()=>const HomeScreen()),
      //GetPage(name: '/song', page: ()=>const SongScreen()),
      // GetPage(name: '/playlist', page: ()=>const PlaylistScreen()),
      //  ],
    );
  }
}
