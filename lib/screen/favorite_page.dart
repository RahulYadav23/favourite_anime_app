import 'package:anime/blocs/anime%20bloc/anime_bloc.dart';
import 'package:anime/blocs/favorite%20bloc/favorite_bloc.dart';
import 'package:anime/screen/anime_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(GetFavoriteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, kToolbarHeight, 20, 0),
      child: Column(
        children: [
          const Text("Your's favourite",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is Favoriteloading) {
                return const SizedBox(
                  height: 400,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is FavoriteLoaded) {
                if (state.mylist.isEmpty) {
                  return const SizedBox(
                    height: 500,
                    child: Center(
                      child: Text(
                        "No favourite Anime found",
                        style: TextStyle(
                            fontSize: 55, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }
                return Flexible(
                  flex: 1,
                  child: GridView.builder(
                    primary: false,
                    shrinkWrap: true,
                    controller: scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0,
                            crossAxisCount: 2,
                            childAspectRatio: 0.8),
                    itemCount: state.mylist.length,
                    itemBuilder: (context, index) {
                      if (index == state.mylist.length) {
                        return const SizedBox(
                          height: 400,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return BlocProvider.value(
                                value: AnimeBloc(),
                                child: AnimeInfoPage(
                                  animedata: state.mylist[index],
                                  visible: false,
                                ),
                              );
                            },
                          )).then((value) {
                            context
                                .read<FavoriteBloc>()
                                .add(GetFavoriteEvent());
                          });
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 4,
                          child: Container(
                            constraints: const BoxConstraints(
                                minHeight: 100, minWidth: 40),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      state.mylist[index].images["jpg"]
                                              ?.largeImageUrl ??
                                          "",
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    color: Colors.black54,
                                    width: double.maxFinite,
                                    child: Text(
                                      state.mylist[index].title ??
                                          "Anime Title",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return Container();
            },
          )
        ],
      ),
    );
  }
}
