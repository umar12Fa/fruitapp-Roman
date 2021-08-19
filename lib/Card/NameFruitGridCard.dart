import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitapp/models/name_fruit_dialog_model.dart';
import 'package:fruitapp/widgets/item_rename_mixin.dart';
import 'package:provider/provider.dart';
import '../NameFruit.dart';

class NameFruitGridCard extends StatefulWidget {
  final NameFruit nameFruit;
  final fontSize = 20.0;
  final color = Colors.black;
  final fontWeight = FontWeight.bold;

  NameFruitGridCard(this.nameFruit);

  @override
  _NameFruitCardState createState() => _NameFruitCardState();
}

class _NameFruitCardState extends State<NameFruitGridCard>
    with ItemRenameMixin{
  Future<void> onUpdate(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => getRenameDialog(context, (String updatedName) {
              NameFruit nameFruit = new NameFruit(
                  name: updatedName,
                  imageSource: widget.nameFruit.imageSource);


              var result = Provider.of<NameFruitModel>(context, listen: false)
                  .updateNameFruit(nameFruit, widget.nameFruit.name)
                  .then((value) {
                Provider.of<NameFruitModel>(context, listen: false).refresh();

                // Navigator.of(context).pop();
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        child: Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.nameFruit.imageSource,
                  height: 130,
                  width: 100,
                  fit: BoxFit.fill,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Text(widget.nameFruit.name,
                          style: TextStyle(
                              fontSize: widget.fontSize,
                              color: widget.color,
                              fontWeight: widget.fontWeight,
                              decoration: TextDecoration.combine([]))),
                      onDoubleTap: () async {
                        await onUpdate(context);
                      },
                    ),
                  ],
                ),
              ]),
        )); //Sizedbox,
  }
}
