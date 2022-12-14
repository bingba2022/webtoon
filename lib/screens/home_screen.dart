import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        elevation: 1.3,
      ),
      body: FutureBuilder(
        future: webtoons, //future builder will await for us
        builder: (context, snapshot) {
          // snapshot: state of your future
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      itemBuilder: (context, index) {
        print(index);
        var webtoon = snapshot.data![index];
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15, // how far away the shadows will be
                    offset: const Offset(
                        10, 10), // where is the shadow located (0,0) -> center
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              width: 250,
              clipBehavior: Clip.hardEdge,
              child: Image.network(webtoon.thumb),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              webtoon.title,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
