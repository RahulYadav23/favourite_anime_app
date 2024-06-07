import 'package:anime/blocs/anime%20bloc/anime_bloc.dart';
import 'package:anime/model/anime_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeInfoPage extends StatefulWidget {
  final Datum animedata;
  final bool visible;
  const AnimeInfoPage(
      {super.key, required this.animedata, required this.visible});

  @override
  State<AnimeInfoPage> createState() => _AnimeInfoPageState();
}

class _AnimeInfoPageState extends State<AnimeInfoPage> {
  bool reveal = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AnimeBloc, AnimeState>(
      listener: (context, state) {
        if (state is ShowInfoState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: const EdgeInsets.all(16),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Card(
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 10.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.animedata.images["jpg"]?.largeImageUrl ?? "",
                      fit: BoxFit.cover,
                      width: 150,
                      height: 220,
                    ),
                  ),
                ),
              )),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "${widget.animedata.titleEnglish}",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  "${widget.animedata.titleJapanese}",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  "${widget.animedata.score ?? ""} / 10",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Rating",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.animedata.rating ?? "Not found",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Geners",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    genres(),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Aired",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.animedata.aired?.string ?? "",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    text: reveal
                        ? widget.animedata.synopsis ?? ""
                        : '${(widget.animedata.synopsis ?? "").substring(0, 250)} ... ',
                    children: [
                      TextSpan(
                        text: reveal ? ' Show less' : ' Show more',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => setState(() {
                                reveal = !reveal;
                              }),
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              widget.visible
                  ? ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AnimeBloc>(context)
                            .add(AddtoFavEvent(data: widget.animedata));
                      },
                      child: const SizedBox(
                          width: 300,
                          child: Center(child: Text("Add to favourite"))))
                  : ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AnimeBloc>(context)
                            .add(RemoveFavEvent(data: widget.animedata));
                      },
                      child: const SizedBox(
                          width: 300,
                          child: Center(child: Text("Remove to favourite"))))
            ],
          ),
        ),
      ),
    );
  }

  String genres() {
    StringBuffer sb = StringBuffer();

    for (int i = 0; i < widget.animedata.genres.length; i++) {
      sb.write('${widget.animedata.genres[i].name},');
    }
    return sb.toString();
  }
}
