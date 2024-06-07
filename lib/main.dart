import 'package:anime/blocs/anime%20bloc/anime_bloc.dart';
import 'package:anime/blocs/favorite%20bloc/favorite_bloc.dart';
import 'package:anime/blocs/search%20bloc/search_bloc.dart';
import 'package:anime/screen/favorite_page.dart';
import 'package:anime/screen/home_page.dart';
import 'package:anime/screen/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const FavoritePage()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AnimeBloc>(
          create: (context) {
            return AnimeBloc()..add(FirstFetchEvent());
          },
        ),
        BlocProvider<SearchBloc>(
          create: (context) {
            return SearchBloc();
          },
        ),
        BlocProvider<FavoriteBloc>(
          create: (context) {
            return FavoriteBloc();
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: onItemTapped,
            unselectedFontSize: 0,
            selectedFontSize: 0,
            backgroundColor: Colors.white,
            currentIndex: selectedIndex,
            selectedItemColor: Colors.black54,
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: "favourite", icon: Icon(Icons.search)),
              BottomNavigationBarItem(
                  label: "favourite", icon: Icon(Icons.favorite)),
            ]),
      ),
    );
  }
}
