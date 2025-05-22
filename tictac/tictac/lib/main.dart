import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tictac/src/audio/audio_controller.dart';
import 'package:tictac/src/level_selection/level_selection_screen.dart';
import 'package:tictac/src/level_selection/levels.dart';
import 'package:tictac/src/main_menu/main_menu_screen.dart';
import 'package:tictac/src/play_session/play_session_screen.dart';
import 'package:tictac/src/play_session/progress.dart';
import 'package:tictac/src/settings/persistence/local_storage_settings_persistence.dart';
import 'package:tictac/src/settings/persistence/settings_persistence.dart';
import 'package:tictac/src/settings/settings.dart';
import 'package:tictac/src/settings/settings_screen.dart';
import 'package:tictac/src/style/palette.dart';
import 'package:tictac/src/win_game/win_game_screen.dart';


// 功能分析
// 页面
//    - 主页面
//      + xo 图片
//      + 菜单
//        - play: 默认选中
//          + Select Level
//          + 9 个 level: 根据用户的游玩历史确定可以解锁的 level 们
//            - 顶部菜单
//              + player versus blobfish
//              + 配置按钮
//            - 中部栅格
//            - 底部 restart 按钮
//          + 底部的 back 按钮
//        - settings
//          + 顶部 settings 文本
//          + name
//          + sound fx
//          + music
//          + reset progress
//          + music 使用声明
//          + 底部 back 按钮
//        - 静音按钮: 默认静音
//      + Music by Mr Smith

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    settingsPersistence: LocalStorageSettingsPersistence(),
  ));
}

class MyApp extends StatelessWidget {
  final SettingsPersistence settingsPersistence;

  const MyApp({
    required this.settingsPersistence,
    super.key
   });

  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            MainMenuScreen(key: Key("main menu")),
        routes: [
          GoRoute(
            path: 'play',
            // TODO: 换成 pageBuilder, 编写自定义转场动画
            builder: (context, state) => LevelSelectionScreen(
              key: Key('level selection'),
            ),
            routes: [
              GoRoute(
                path: 'session/:level',
                builder: (context, state) {
                  final levelNumber = int.parse(state.pathParameters['level']!);
                  final level = gameLevels.singleWhere((e) => e.number == levelNumber);
                  return PlaySessionScreen(
                    level,
                    key: Key('play session')
                  );
                } 
              ),
              GoRoute(
                path: 'won',
                builder: (context, state) => const WinGameScreen(
                  key: Key('win game'),
                )
              ),
            ]
          ),
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsScreen(
              key: Key('settings')
            )
          )
        ] 
      )
    ]
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Palette()),
        Provider<SettingsController>(
          lazy: false,
          create: (context) => SettingsController(
            persistence: settingsPersistence,
          )..loadStateFromPersistence(),
        ),
        // TODO: set/get progress from cache
        Provider(create:(context) => Progress(),),
        ProxyProvider<SettingsController, AudioController>(
          lazy: false,
          create: (context) => AudioController()..initialize(),
          update: (context, settings, audio) {
            if(audio == null) throw ArgumentError.notNull();
            audio.attachSettings(settings);
            return audio;
          },
          dispose: (context, audio) => audio.dispose(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final palette = context.watch<Palette>();
          return MaterialApp.router(
            title: 'Flutter Demo',
            // TODO: 对 theme 的进一步研究
            theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: palette.darkPen,
                surface: palette.backgroundMain 
              ),
              textTheme: TextTheme(
                bodyMedium: TextStyle(
                  color: palette.ink
                )
              )
            ),
            routeInformationProvider: _router.routeInformationProvider, 
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
          );
        }
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
