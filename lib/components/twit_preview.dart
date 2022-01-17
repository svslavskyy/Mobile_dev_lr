import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab1_flutter_dart_basics/models/twits.dart';
import 'package:lab1_flutter_dart_basics/pages/twit_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TwitPreview extends StatelessWidget {
  static const TextStyle BottomInfoStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Color(0xFFAAAAAA),
    fontSize: 12,
    fontFamily: 'Roboto',
  );

  final VoidCallback incrementLikeCounter;

  final String _channelAvatarImage;
  final String _twitterName;
  final String _twitterID;
  final String _strings;
  final String _shortUploadedAt;
  final String _retweet;
  final String _answer;
  final int _likes;

  final String id;

  TwitPreview(
      {required this.id,
      required strings,
      required channelAvatarImage,
      required twitterName,
      required shortUploadedAt,
      required twitterID,
      required retweet,
      required answer,
      required likes,
      required this.incrementLikeCounter})
      : this._strings = strings,
        this._channelAvatarImage = channelAvatarImage,
        this._twitterName = twitterName,
        this._shortUploadedAt = shortUploadedAt,
        this._twitterID = twitterID,
        this._retweet = retweet,
        this._answer = answer,
        this._likes = likes;

  @override
  Widget build(BuildContext context) {
    // timeDilation = 1.0;
    return Hero(
      tag: this.id,
      child: RawMaterialButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (BuildContext context) {
              return Scaffold(
                body: TwitPage(
                  id: this.id,
                  incrementLikeCounter: this.incrementLikeCounter,
                ),
              );
            }),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(this._channelAvatarImage),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                this._twitterName,
                                style: BottomInfoStyle,
                              ),
                            ),
                            Container(
                              child: Text(
                                " ${this._twitterID}",
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
                                this._shortUploadedAt,
                                style: BottomInfoStyle,
                              ),
                            ),
                          ],
                        ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10.0, right: 20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  this._strings,
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 10,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  tweetIconButton(FontAwesomeIcons.comment, this._answer,(){}),
                                  tweetIconButton(FontAwesomeIcons.retweet, this._retweet,(){} ),
                                  tweetIconButton(FontAwesomeIcons.heart, "${this._likes}",(){
                                    this.incrementLikeCounter();
                                    Provider.of<Twits>(context,listen: false).like(this.id);
                                  }),
                                  tweetIconButton(FontAwesomeIcons.shareAlt, '',(){}),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tweetIconButton(IconData icon, String text, VoidCallback onPressed) {
    return MaterialButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            size: 16.0,
            color: Colors.white,
          ),
          Container(
            margin: const EdgeInsets.all(6.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
