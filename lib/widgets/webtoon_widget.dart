import 'package:flutter/material.dart';
import 'package:webtoon/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;
  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // detect gestures
      onTap: () {
        Navigator.push(
          // make the user think we are going to different screen
          context,
          MaterialPageRoute(
            builder: ((context) => DetailScreen(
                  title: title,
                  thumb: thumb,
                  id: id,
                )),
            fullscreenDialog: true, // pops up from the top
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
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
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
