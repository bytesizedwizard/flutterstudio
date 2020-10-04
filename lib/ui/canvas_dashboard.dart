import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_studio/bloc/bloc.dart';
import 'package:flutter_studio/ui/components/buttons.dart';
import 'package:flutter_studio/ui/components/styles.dart';
import 'package:flutter_studio/ui/new_widget.dart';
import 'package:flutter_studio/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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

    final _bloc = Provider.of<Bloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Form(
        key: _formKey,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
              child: ScreenBackgroundBasic(),
            ),
            SafeArea(
              minimum: EdgeInsets.only(
                left: 20,
                right: 20
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Image.asset(
                      "assets/images/flutter_studio_logo.png",
                      alignment: Alignment.center,
                    ),
                  ),
                  Flexible(
                    flex: 20,
                    child: PageView(
                      controller: _pageController,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 50.0,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors(0xFFFFFFFF),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.secondaryColor.withOpacity(0.75),
                                blurRadius: 15.0,
                                offset: Offset(0.0, 5.0),
                              )
                            ],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Scaffold(
                              appBar: previewAppBar,
                              body: previewBody,
                              floatingActionButton: previewFloatingActionButton,
                            ),
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
                  Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomButton.secondary(
                          child: Icon(Icons.undo, color: AppColors.fontPrimaryColor,),
                          onPressed: () {

                          },
                          buttonColor: AppColors.secondaryColor,
                        ),
                        CustomButton.secondary(
                          child: Icon(Icons.loop, color: AppColors.fontPrimaryColor,),
                          onPressed: () {
                            setState(() {
                              previewAppBar = previewBody = previewFloatingActionButton = null;
                            });
                          },
                          buttonColor: AppColors.secondaryColor,
                        ),
                        CustomButton.secondary(
                          child: Icon(Icons.redo, color: AppColors.fontPrimaryColor,),
                          onPressed: () {

                          },
                          buttonColor: AppColors.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Flexible(
                    flex: 2,
                    child: CustomButton(
                      child: Text(
                        "Add New Widget",
                        style: CustomStyles.buttonTextStyle,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(builder: (_) => NewWidget())
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                  Flexible(
                    flex: 2,
                    child: CustomButton.secondary(
                      child: Text(
                        "View Code",
                        style: CustomStyles.buttonTextStyle,
                      ),
                      onPressed: () {},
                      buttonColor: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            /*Positioned(
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
            )*/
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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