import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class PhotoCard extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);       // ← Add this.
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return GFCard(
      boxFit: BoxFit.cover,
      image: Image.asset('your asset image'),
      title: GFListTile(
        avatar: GFAvatar(
          backgroundImage: AssetImage('your asset image'),
        ),
        title: Text('Card Title'),
        subTitle: Text('Card Sub Title'),
      ),
      content: Text("Some quick example text to build on the card"),
      buttonBar: GFButtonBar(
        children: <Widget>[
          GFButton(
            onPressed: () {},
            text: 'Buy',
          ),
          GFButton(
            onPressed: () {},
            text: 'Cancel',
          ),
        ],
      ),
    );
  }

}