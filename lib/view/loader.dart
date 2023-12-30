import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  final bool isLoading;

  const LoaderWidget({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: AnimatedOpacity(
        opacity: isLoading ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: isLoading
            ? Image.asset(
                'lib/assets/loader.gif',
                width: 200, // Adjust width as needed
                height: 200, // Adjust height as needed
              )
            : Container(), // Empty container when not loading
      ),
    );
  }
}