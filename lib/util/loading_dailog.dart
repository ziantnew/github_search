import 'package:flutter/material.dart';

class LoadingDialog {
  bool isLoading = false;
  BuildContext context;
  BuildContext? loadingContext;

  LoadingDialog({required this.context});

  void show() {
    if (!isLoading) {
      isLoading = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          loadingContext = context;
          return const Loading();
        },
      ).whenComplete(() {
        isLoading = false;
      });
    }
  }

  void hide() {
    if (isLoading) {
      isLoading = false;
      if (loadingContext != null) {
        Navigator.pop(loadingContext!);
      }
    }
  }
}

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoadingState();
  }
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        // color: const Color(0x59090d14),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}