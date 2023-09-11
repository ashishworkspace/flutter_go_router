import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

void main(List<String> args) {
  setPathUrlStrategy();
  runApp(const NavigationApp());
}

class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
    name: "homePage",
    path: '/',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    name: 'profilePage',
    path: '/profile',
    redirect: (context, state) => '/profile/a',
  ),
  ShellRoute(
      builder: (context, state, child) => Profile(
            child: child,
          ),
      routes: [
        GoRoute(
          name: "a_screen",
          path: '/profile/a',
          builder: (context, state) => const ShellA(),
        ),
        GoRoute(
          name: "b_screen",
          path: '/profile/b',
          builder: (context, state) => const ShellB(),
        ),
        GoRoute(
          name: "c_screen",
          path: '/profile/c',
          builder: (context, state) => const ShellC(),
        ),
      ])
]);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.go('/profile');
            },
            child: const Text('Profile Button')),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final Widget child;
  const Profile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'A Screen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'B Screen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important_rounded),
            label: 'C Screen',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/profile/a')) {
      return 0;
    }
    if (location.startsWith('/profile/b')) {
      return 1;
    }
    if (location.startsWith('/profile/c')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    print(index);
    switch (index) {
      case 0:
        GoRouter.of(context).go('/profile/a');
        break;
      case 1:
        GoRouter.of(context).go('/profile/b');
        break;
      case 2:
        GoRouter.of(context).go('/profile/c');
        break;
    }
  }
}

class ShellA extends StatelessWidget {
  const ShellA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A'),
      ),
    );
  }
}

class ShellB extends StatelessWidget {
  const ShellB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('B'),
      ),
    );
  }
}

class ShellC extends StatelessWidget {
  const ShellC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C'),
      ),
    );
  }
}

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C'),
      ),
    );
  }
}
