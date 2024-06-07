import 'package:anime/blocs/anime%20bloc/anime_bloc.dart';
import 'package:anime/blocs/search%20bloc/search_bloc.dart';
import 'package:anime/screen/anime_info_page.dart';
import 'package:anime/utils/deboune.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ScrollController scrollController = ScrollController();
  final Debonce debonce = Debonce();

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, kToolbarHeight, 20, 0),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              debonce.run(() {
                context.read<SearchBloc>().add(SearchValue(value: value));
              });
            },
            decoration: const InputDecoration(
              labelText: 'Search',
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
            ),
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoadingState) {
                return Builder(builder: (context) {
                  return const SizedBox(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                });
              }

              if (state is SearchLoadedstate) {
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
                                  visible: true,
                                ),
                              );
                            },
                          ));
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
