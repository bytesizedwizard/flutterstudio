import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_studio/bloc/provider.dart';
import 'package:flutter_studio/material_menu.dart';

import 'components/screen_background.dart';

class StudioDashboard extends StatefulWidget {
  StudioDashboard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StudioDashboardState createState() => _StudioDashboardState();
}

class _StudioDashboardState extends State<StudioDashboard> {

  GlobalKey<FormState> _formKey = GlobalKey(debugLabel: "Dashboard Form Key");
  PageController _pageController = PageController();
  double _widgetMenuHeight = 150.0;
  Widget previewAppBar;
  Widget previewBody;
  FloatingActionButton previewFloatingActionButton;
  int counter = 0;
  bool isCentered = false;

  @override
  Widget build(BuildContext context) {

    final _bloc = Provider.of(context);

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: ScreenBackgroundBasic(),
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            centerTitle: true,
            title:  Image.asset(
              "assets/images/flutter_studio_logo.png",
              alignment: Alignment.topLeft,
              width: 100,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    previewAppBar = previewBody = previewFloatingActionButton = null;
                  });
                },
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60.0,
                              vertical: 10.0
                          ),
                          child: Text(
                            "Use the widgets panel to start building",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 1.1,
                                color: Colors.white,
                                fontSize: 12
                            ),
                          )
                      ),
                    ),
                    Flexible(
                      flex: 10,
                      child: PageView(
                        controller: _pageController,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 60.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white
                            ),
                            child: Scaffold(
                              appBar: previewAppBar,
                              body: previewBody,
                              floatingActionButton: previewFloatingActionButton,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 50.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25)
                            ),
                            child: StreamBuilder<String>(
                                stream: _bloc.getGeneratedCode,
                                builder: (context, snapshot) {
                                  if(!snapshot.hasData) {
                                    return Container();
                                  }

                                  return SingleChildScrollView(
                                    child: Text(
                                      snapshot.data,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ],
                        onPageChanged: (index) {
                          if(index == 1) {
                            _bloc.setSelectedMenu("codeOptions");
                          } else {
                            _bloc.setSelectedMenu("none");
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(),
                    )
                  ],
                ),
                Positioned(
                  bottom: 0.0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: MediaQuery.of(context).size.width,
                    height: _widgetMenuHeight,
                    color: Colors.black,
                    child: SingleChildScrollView(
                      child: StreamBuilder<String>(
                          stream: _bloc.getSelectedMenu,
                          initialData: "none",
                          builder: (context, snapshot) {
                            if(snapshot.hasData) {
                              switch(snapshot.data) {
                                case "none":
                                  return defaultMenu(_bloc);

                                case "material":
                                  return MaterialWidgetMenu(
                                      expandCollapseMenu,
                                      renderPreviewAppBar,
                                      renderPreviewBody,
                                      renderFloatingActionButton,
                                      onButtonPressed,
                                      counter,
                                      centerWidgetCallback
                                  );

                                case "codeOptions":
                                  return codeMenu(_bloc);
                              }
                            }
                            return defaultMenu(_bloc);
                          }
                      ),
                    ),
                  ),
                )
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ],
    );
  }

  Widget defaultMenu(var _bloc) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          color: Colors.transparent,
          child: Text(
            "Widgets Menu",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: expandCollapseMenu,
        ),
        Wrap(
          children: <Widget>[
            Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.android),
                  color: Colors.white,
                  onPressed: () {
                    _bloc.setSelectedMenu("material");
                  },
                  iconSize: 36,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Material",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 40,),
            Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.apple),
                  color: Colors.white,
                  onPressed: () {
                    _bloc.setSelectedMenu("cupertino");
                  },
                  iconSize: 36,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cupertino",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 40,),
            Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.mobileAlt),
                  color: Colors.white,
                  onPressed: () {
                    _bloc.setSelectedMenu("native");
                  },
                  iconSize: 36,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Native",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget codeMenu(var _bloc) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          color: Colors.transparent,
          child: Text(
            "Code Options",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: expandCollapseMenu,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Wrap(
            spacing: 40,
            runSpacing: 20,
            alignment: WrapAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.share),
                    color: Colors.white,
                    onPressed: () {
                      _bloc.share();
                    },
                    iconSize: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Share",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.copy),
                    color: Colors.white,
                    onPressed: () {
                      _bloc.copy();
                    },
                    iconSize: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Copy",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.file),
                    color: Colors.white,
                    onPressed: () {
                      _bloc.writeToStorage();
                    },
                    iconSize: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Write to File",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.github),
                    color: Colors.white,
                    onPressed: () {
                      //TODO:Add GitHub
                    },
                    iconSize: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "GitHub",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.stackOverflow),
                    color: Colors.white,
                    onPressed: () {

                    },
                    iconSize: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Ask",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300
                      ),
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

  void expandCollapseMenu() {
    if(_widgetMenuHeight == 150.0) {
      setState(() {
        _widgetMenuHeight = MediaQuery.of(context).size.height - 80.0;
      });
    } else {
      setState(() {
        _widgetMenuHeight = 150.0;
      });
    }
  }

  void renderPreviewAppBar(AppBar appBar, dynamic _bloc) {
    setState(() {
      previewAppBar = appBar;
    });
    _bloc.generateCode(
        '''
appBar: ${appBar.toString()}(
  title: ${appBar.title.toString()}
),
404Found
'''
    );
  }

  void centerWidgetCallback() {
    setState(() {
      isCentered = true;
    });
  }

  void renderPreviewBody(Widget body, dynamic _bloc) {
    if (!isCentered) {
      setState(() {
        previewBody = body;
      });
      _bloc.generateCode(
          '''
  body: ${body.toString()},
  404Found
'''
      );
    } else {
      setState(() {
        previewBody = Center(child: body);
      });
      _bloc.generateCode(
          '''
  body: Center(
    child: ${body.toString()},
  ),
  404Found
'''
      );
    }
  }

  void renderFloatingActionButton(FloatingActionButton button, dynamic _bloc) {
    setState(() {
      previewFloatingActionButton = button;
    });
    _bloc.generateCode(
        '''
  floatingActionButton: ${button.toString()} (
    child: ${button.child.toString()},
    onPressed: () {}
)   
'''
    );
  }

  void onButtonPressed() {
    setState(() {
      counter++;
    });
  }

}