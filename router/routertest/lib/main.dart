import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const SimpleNavigatorApp());
}

class SimpleNavigatorApp extends StatelessWidget {
  const SimpleNavigatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Navigator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SimpleNavigatorScreen(),
    );
  }
}

class SimpleNavigatorScreen extends StatelessWidget {
  const SimpleNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Navigator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SimpleNavigatorDetailScreen()),
                );
              },
              child: const Text('Go to Detail Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleNavigatorDetailScreen extends StatelessWidget {
  const SimpleNavigatorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Navigator Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleGoRouterTestApp extends StatelessWidget {
  const SimpleGoRouterTestApp({super.key});

  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const MyTestHomePage();
        },
      )
    ]
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class MyTestHomePage extends StatelessWidget {
  const MyTestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Home Page'),
      ),
      body: Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return MyHomePage();
        },
        routes: [
          GoRoute(
            path: 'menu',
            builder: (context, state) => const MenuPage(),
            routes: [
              GoRoute(
                path: 'product',
                builder:(context, state) => const ProductPage(),
                routes: [
                  GoRoute(
                    path: 'detail',
                    builder: (context, state) => const DetailPage(),
                  )
                ]
              ),
              GoRoute(
                path: 'help',
                builder: (context, state) => const HelpPage(),
                routes: [
                  GoRoute(
                    path: 'info',
                    builder: (context, state) => const InfoPage(),
                  )
                ]
              ),
            ]
          ),
        ]
      ),
    ]
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router,);
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/menu/product/detail');
              },
              child: const Text('Go to Detail Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/menu/help');
              },
              child: const Text('Go to Help Page'),
            ), 
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/menu/help/info');
              },
              child: const Text('Go to Info Page'),
            ), 
            ElevatedButton(
              onPressed: (){
                GoRouter.of(context).push("/menu/help");
              }, 
              child: const Text('Push to Help Page') 
            )
          ],
        ),
      ),
    );
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/menu/help/info');
              },
              child: const Text('Go to Info Page'),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pop();
              }, 
              child: const Text('Pop'),
            )
          ],
        ),
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: const Text('Pop'),
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text('Pop'),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/menu/product');
              },
              child: const Text('Go to Product Page'),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/menu/help');
              },
              child: const Text('Go to Help Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).go('/menu');
          },
          child: const Text('Go to menu Page'),
        ),
      ),
    );
  }
}
