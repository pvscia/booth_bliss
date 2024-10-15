
import 'package:flutter/material.dart';

class ViewDialogUtil{
  void showYesNoActionDialog(String content, String positiveTitle,
      String negativeTitle, String pictureParam,
      BuildContext context,
      VoidCallback positiveClick,
      VoidCallback negativeClick,
      ) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            backgroundColor: Colors.white,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 280,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Image.asset('assets/images/$pictureParam', width: 220, height: 90),
                            const SizedBox(height: 25),
                            Text(
                              content,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 15.0, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 33.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 105,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                negativeClick();
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)), // Adjust radius as needed
                                side: const BorderSide(
                                    color: Colors.grey, width: 1),
                              ),
                              child: Text(
                                negativeTitle,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 105,
                            height: 40,
                            child: RawMaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                positiveClick();
                              },
                              fillColor: Colors.pinkAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                positiveTitle,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
