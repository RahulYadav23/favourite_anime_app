import 'package:anime/blocs/anime%20bloc/anime_bloc.dart';
import 'package:anime/screen/anime_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      context.read<AnimeBloc>().add(LoadmoreEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, kToolbarHeight, 20, 0),
      child: BlocConsumer<AnimeBloc, AnimeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AnimeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AnimeLoadedState) {
            return GridView.builder(
              primary: false,
              shrinkWrap: true,
              controller: scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  crossAxisCount: 2,
                  childAspectRatio: 0.8),
              itemCount: state.isloading
                  ? state.mylist.length + 1
                  : state.mylist.length,
              itemBuilder: (context, index) {
                if (index == state.mylist.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
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
                      constraints:
                          const BoxConstraints(minHeight: 100, minWidth: 40),
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
                                state.mylist[index].title ?? "Anime Title",
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
            );
          }

          return Container();
        },
      ),
    );
  }
}
