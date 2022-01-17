import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/twits.dart';

class TwitPage extends StatelessWidget {
  static const TextStyle BottomInfoStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Color(0xFFAAAAAA),
    fontSize: 12,
    fontFamily: 'Roboto',
  );

  final String id;
  final VoidCallback incrementLikeCounter;

  TwitPage({required this.id, required this.incrementLikeCounter});

  @override
  Widget build(BuildContext context) {
    final twits = context.watch<Twits>();
    final twit = twits.getTwitById(this.id);
    final _strings = twit['strings'];
    final _channelAvatarImage = twit['channelAvatarImage'];
    final _twitterName = twit['twitterName'];
    final _uploadedAt = twit['uploadedAt'];
    final _likes = twit['likes'];
    final _retweet = twit['retweet'];
    final _answer = twit['answer'];
    final _isLiked = twit['isLiked'];

    return Hero(
      tag: this.id,
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // channel info
                    MaterialButton(
                      onPressed: () {},
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage(_channelAvatarImage),
                              ),
                            ),
                            Container(
                              width: 88,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          child: Text(
                                            _twitterName,
                                            style: TextStyle(fontSize: 14),
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    _strings,
                                    style: TextStyle(fontSize: 18),
                                    maxLines: 50,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Color(0xFFAAAAAA),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                child: Text(
                                  _uploadedAt,
                                  style: BottomInfoStyle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Color(0xFFAAAAAA),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                child: Text(
                                  " Twitter for iPhone",
                                  style: BottomInfoStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Provider.of<Twits>(context, listen: false)
                            .like(this.id);
                      },
                      child: Column(
                        children: [
                          Divider(
                            thickness: 0,
                            height: 3,
                          ),
                          Text(NumberFormat.compact().format(_likes)),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        "Mark(s) \"Like\"",
                        style: BottomInfoStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        tweetIconButton(FontAwesomeIcons.comment,(){}),
                        tweetIconButton(FontAwesomeIcons.retweet, (){} ),
                        tweetIconButton(FontAwesomeIcons.heart,(){
                          this.incrementLikeCounter();
                          Provider.of<Twits>(context,listen: false).like(this.id);
                        }),
                        tweetIconButton(FontAwesomeIcons.shareAlt, (){}),
                      ],
                    ),
                  )
                ],
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget tweetIconButton(IconData icon, VoidCallback onPressed) {
    return MaterialButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            size: 16.0,
            color: Colors.white,
          ),

        ],
      ),
    );
  }
}
