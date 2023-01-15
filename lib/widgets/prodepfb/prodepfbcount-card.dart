import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Prodepfbcountcard extends StatefulWidget {
  final int sentimentValue;
  final String sentimentType;
  const Prodepfbcountcard(
      {Key? key, required this.sentimentValue, required this.sentimentType})
      : super(key: key);

  @override
  State<Prodepfbcountcard> createState() => _ProdepfbcountcardState();
}

class _ProdepfbcountcardState extends State<Prodepfbcountcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 180,
      width: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        shadowColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.sentimentValue < 10
                  ? "0${widget.sentimentValue.toString()}"
                  : widget.sentimentValue.toString(),
              style: TextStyle(
                  color: widget.sentimentType == "POSITIVE"
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 65),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: Text(
                "Total no. of ${widget.sentimentType} posts",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[850],
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )
          ],
        ),
      ),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          new BoxShadow(
            color: Color.fromARGB(255, 238, 237, 237),
            blurRadius: 10.0,
          ),
        ],
      ),
    );
  }
}
