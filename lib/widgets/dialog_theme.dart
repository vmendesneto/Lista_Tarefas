import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lista_tarefas_vitor/utils/theme_colors.dart';


// Providers
import 'package:lista_tarefas_vitor/providers/providers.dart';

class ThemeChangerWidget extends ConsumerWidget {
  final List<String> string = ['Light', 'Dark'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(themeProvider.notifier);
    final stateData = ref.watch(themeProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Theme(
        data: stateData.copyWith(
          disabledColor: stateData.primaryColor,
          splashColor: Colors.white,
        ),
        child: AlertDialog(
          insetPadding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          elevation: 0.0,
          backgroundColor: stateData.primaryColorDark,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          title: Text('Select Theme', style: stateData.textTheme.bodyText2),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Dark',
                  style: stateData.textTheme.caption,
                )),
            SizedBox(
              height: height * 0.004,
            ),
            InkWell(
                onTap: () {
                  state.onThemeChanged(1, state);
                },
                child: Container(
                    width: width * 0.62,
                    height: height * 0.064,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Theme(
                                  data: stateData.copyWith(
                                      unselectedWidgetColor: Color(0xff565656)),
                                  child: Radio(
                                      value: 1,
                                      groupValue: themes.indexOf(stateData),
                                      onChanged: (dynamic ind) {
                                        state.onThemeChanged(ind, state);
                                      }))),
                          Stack(
                            children: [
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      height: height * 0.05,
                                      width: width * 0.47,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8.0),
                                            topLeft: Radius.circular(8.0)),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.04,
                                                  right: 15,
                                                  top: height * 0.008),
                                              child: Container()),
                                          //SizedBox(width: width * 0.045, height: height * 0.02,),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.03,
                                                  right: width * 0.02,
                                                  top: height * 0.02),
                                              child: Container(
                                                height: height * 0.007,
                                                width: width * 0.10,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(8.0)),
                                                    color: Color(0xff9d9d9d)),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * 0.02),
                                              child: Container(
                                                height: height * 0.007,
                                                width: width * 0.10,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(8.0)),
                                                    color: Color(0xff565656)),
                                              ))
                                        ],
                                      ))),
                            ],
                          )
                        ]))),
            SizedBox(
              height: height * 0.013,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Ligth',
                  style: stateData.textTheme.caption,
                )),
            SizedBox(
              height: height * 0.004,
            ),
            InkWell(
                onTap: () {
                  state.onThemeChanged(0, state);
                },
                child:Container(
                    width: width * 0.62,
                    height: height * 0.064,
                    decoration: BoxDecoration(
                        color: Color(0xffC2C2C2),
                        border: Border.all(color: stateData.primaryColorDark),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Theme(
                                  data: stateData.copyWith(
                                      unselectedWidgetColor: Color(0xffFAFAFA)),
                                  child: Radio(
                                      value: 0,
                                      groupValue: themes.indexOf(stateData),
                                      onChanged: (dynamic ind) {
                                        state.onThemeChanged(ind, state);
                                      }))),
                          Stack(
                            children: [
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      height: height * 0.05,
                                      width: width * 0.47,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8.0),
                                            topLeft: Radius.circular(8.0)),
                                        color: Color(0xffFAFAFA),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.04,
                                                  right: 15,
                                                  top: height * 0.008),
                                              child:Container()),
                                          //SizedBox(width: width * 0.045, height: height * 0.02,),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.03,
                                                  right: width * 0.02,
                                                  top: height * 0.02),
                                              child: Container(
                                                height: height * 0.007,
                                                width: width * 0.10,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(8.0)),
                                                    color: Color(0xff232323)),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * 0.02),
                                              child: Container(
                                                height: height * 0.007,
                                                width: width * 0.10,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(8.0)),
                                                    color: Color(0xffc4c4c4)),
                                              ))
                                        ],
                                      ))),
                            ],
                          )
                        ])))
          ]),
          //),
        ));
  }
}

//SELEÇÃO DOS TEMAS

void showLoadingDialog(BuildContext context, state) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: _willPopCallback,
        child: AlertDialog(
          backgroundColor: state.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(color: state.hoverColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Please Wait....',
                    style: state.textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
}

Future<bool> _willPopCallback() async {
  return false;
}

void showAlertDialog(BuildContext context, String error, String title) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        title: Text('$title'),
        content: Text(error),
        actions: <Widget>[
          TextButton(
            child: Text('Okay', style: TextStyle(color: Colors.blue)),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    },
  );
}

showConfirmationDialog(BuildContext context, String title, String content,
    state) async {
  bool confirm = false;

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: state.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        title: Text('$title', style: state.textTheme.bodyText2),
        content: Text(content, style: state.textTheme.bodyText1),
        actions: <Widget>[
          TextButton(
            child: Text('Yes', style: TextStyle(color: state.hoverColor)),
            onPressed: () {
              confirm = true;
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('No', style: TextStyle(color: state.hoverColor)),
            onPressed: () {
              confirm = false;
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );

  return confirm;
}

showThemeChangerDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => ThemeChangerWidget(),
  );
}
