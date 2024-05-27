import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessCheckMark extends StatefulWidget {
  const SuccessCheckMark({super.key});

  @override
  State<SuccessCheckMark> createState() => _SuccessCheckMarkState();
}

class _SuccessCheckMarkState extends State<SuccessCheckMark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }
    Widget _buildUI(){
      return Center(
        child: Lottie.asset("lib/assets/AnimationSuccessCheckMark.json",
     //   repeat: true,
        width: 150,
        height: 150, 
        ),
      );
    }
}
