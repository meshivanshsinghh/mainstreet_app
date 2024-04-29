import 'package:flutter/material.dart';

class BottomNavBarCustom extends StatefulWidget {
  final int currentIndex;
  const BottomNavBarCustom({
    super.key,
    required this.currentIndex,
  });

  @override
  State<BottomNavBarCustom> createState() => _BottomNavBarCustomState();
}

class _BottomNavBarCustomState extends State<BottomNavBarCustom> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
