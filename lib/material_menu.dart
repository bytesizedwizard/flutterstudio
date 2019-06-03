import 'package:flutter/material.dart';
import 'package:flutter_studio/bloc/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MaterialWidgetMenu extends StatefulWidget {
  final VoidCallback expandCollapseMenuCallback;
  final void Function(AppBar appBar, dynamic bloc) updateAppBarCallback;
  final VoidCallback centerWidgetCallback;
  final void Function(Widget body, dynamic bloc) updateBodyCallback;
  final void Function(FloatingActionButton button, dynamic bloc) updateFabCallback;
  final VoidCallback updateCounterCallback;
  int counter;

  MaterialWidgetMenu(this.expandCollapseMenuCallback, this.updateAppBarCallback,
      this.updateBodyCallback, this.updateFabCallback, this.updateCounterCallback, this.counter, this.centerWidgetCallback);

  @override
  _MaterialWidgetMenuState createState() => _MaterialWidgetMenuState();
}

class _MaterialWidgetMenuState extends State<MaterialWidgetMenu> {
  AppBar _appBar;
  Widget _body;
  FloatingActionButton _floatingActionButton;


  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(
                  "Material Widgets",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: widget.expandCollapseMenuCallback,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 40,
            runSpacing: 20,
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.solidObjectGroup),
                    color: Colors.white,
                    onPressed: () {
                      _bloc.generateCode(
'''
Scaffold(
  404Found,
)
'''
                      );
                    },
                    iconSize: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Sacffold",
                      style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.space_bar),
                    color: Colors.white,
                    onPressed: () {
                      _appBar = AppBar(
                        title: Text(
                          "Flutter Demo App",
                        ),
                      );
                      widget.updateAppBarCallback(_appBar, _bloc);
                    },
                    iconSize: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "AppBar",
                      style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.alignCenter),
                    color: Colors.white,
                    onPressed: () {
                      widget.centerWidgetCallback();
                    },
                    iconSize: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Center",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.font),
                    color: Colors.white,
                    onPressed: () {
                      _body = Text("Button pressed ${widget.counter} times");
                      widget.updateBodyCallback(_body, _bloc);
                    },
                    iconSize: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Text",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Colors.white,
                    onPressed: () {
                      widget.updateFabCallback(
                        FloatingActionButton(
                          onPressed: widget.updateCounterCallback,
                          child: Icon(Icons.add),
                        ),
                        _bloc
                      );
                    },
                    iconSize: 48,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "FAB",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
