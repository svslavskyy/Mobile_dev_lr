import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/twits.dart';
import '../components/twit_preview.dart';

class MainPage extends StatelessWidget {
  static final double _twitMargin = 10.0;
  final VoidCallback incrementLikeCounter;

  MainPage({required this.incrementLikeCounter});

  @override
  Widget build(BuildContext context) {
    return Consumer<Twits>(
      builder: (context, twits, child) {
        return SingleChildScrollView(
          child: Column(
            children: twits.getAll()
                .map(
                  (e) =>
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, _twitMargin),
                    child: TwitPreview(
                      id: e['id'],
                      strings: e['strings'],
                      channelAvatarImage: e['channelAvatarImage'],
                      twitterName: e['twitterName'],
                      shortUploadedAt: e['shortUploadedAt'],
                      twitterID: e['twitterID'],
                      retweet: e['retweet'],
                      answer: e['answer'],
                      likes: e['likes'],
                      incrementLikeCounter: this.incrementLikeCounter,
                    ),
                  ),
            )
                .toList(),
          ),
        );
      }
    );

  }
}
