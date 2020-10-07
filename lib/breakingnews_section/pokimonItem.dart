import 'package:flutter/material.dart';

import '../constants.dart';
import 'model_class.dart';

class PokemonItem extends StatelessWidget {

  PokemonItem({Key key, @required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return getFullResult(context);
  }

  Widget fullNewsButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: ktitleColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        ),
      ),
    );
  }

  Widget getFullResult(BuildContext context) {
    List<Widget> statWidgets = <Widget>[];

    String title;
    String img;
    String date;
    String desc;

    for(Map<String, dynamic> abilities in pokemon.results){
      print("length2: ${pokemon.results.length}");
      title = abilities['title'];
      img = abilities['img_link'];
      date = abilities['release_date'];
      desc = abilities['description'];

      statWidgets.add(Card(
        child: Row(
          children: <Widget>[
            Container(
              width: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  child: Image.network(
                    img,
                    width: 80.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title.length > 24 ? title.substring(0, 27) : title,
                    maxLines: 1,
                    style: TextStyle(
                        color: ktitleColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 130.0,
                    child: Container(
                        child: Text(
                          desc,
                          maxLines: 2,
                        )),
                  ),
                  Row(
                    children: <Widget>[
                      fullNewsButton("LifeStyle"),
                      fullNewsButton("Fashion"),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            size: 20.0,
                            color: Colors.grey,
                          ),
                          Text(date)
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ));
    }

    return Column(children: statWidgets);
  }
}
