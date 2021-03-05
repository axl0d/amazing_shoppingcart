import 'package:flutter/material.dart';

class TitleItem extends StatelessWidget {
  const TitleItem({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
