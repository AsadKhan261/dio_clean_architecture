import 'package:flutter/material.dart';

import '../../helpers/storage_helper.dart';

Future<void> saveAddressPopup(BuildContext context,double lat, double lng) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Do you want to view this location temp in future?'),
        actions: <Widget>[

          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          TextButton(
            child: const Text('Save'),
            onPressed: () {
              StorageHelper().setUserLat(lat);
              StorageHelper().setUserLng(lng);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}