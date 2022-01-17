import 'package:flutter/material.dart';

class LikesPage extends StatelessWidget {
  final int totalLikeClicks;
  final VoidCallback onClick;

  const LikesPage(
      {Key? key, required this.totalLikeClicks, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${this.totalLikeClicks}"),
            TextButton(
              onPressed: () {
                onClick();
              },
              child: Text("Like"),
            ),
          ],
        ),
      ),
    ]);
  }
}
