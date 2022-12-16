import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/services/api_service.dart';

// Had to turn into stateful widget because
// we need access to init state method to initialize getToonById
// and getLatestEpisodeById

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(
        widget.id); // widget.id 를 하는 이유는 we are now on a different class
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title, //
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        elevation: 1.3,
      ),
      body: SingleChildScrollView(
        // add SingleChildScrollView widget to fix overflow issues
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15, // how far away the shadows will be
                            offset: const Offset(10,
                                10), // where is the shadow located (0,0) -> center
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 190, // image size
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(widget.thumb),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 19, // gap between image and text
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 12, // font size
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 13, // font size
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text(".....");
                },
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future:
                    episodes, // future that we are going to wait for is episode
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // if there exists a list of episodes
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Container(
                            decoration:
                                BoxDecoration(color: Colors.green.shade300),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              child: Row(children: [
                                Text(episode.title),
                                const Icon(Icons.chevron_right_rounded)
                              ]),
                            ),
                          )
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
