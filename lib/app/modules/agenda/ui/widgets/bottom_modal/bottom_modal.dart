import 'package:flutter/material.dart';

showBottomAutoSizeModal(context, Widget contentWidget) {
  return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    children: [
                      contentWidget,
                    ],
                  )
                  // onPressed: () => Navigator.pop(context),
                ],
              ),
            ),
          ),
        );
      });
}

