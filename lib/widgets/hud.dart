import 'package:flutter/material.dart';

class Hud extends StatelessWidget {
  static const id = 'Hud';

  const Hud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (index) {
                if (index < 3) {
                  return const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  );
                } else {
                  return const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  );
                }
              },
            ),
          ),
          const Text(
            'Score: 666',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          TextButton(
            onPressed: () {},
            child: const Icon(Icons.pause, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
