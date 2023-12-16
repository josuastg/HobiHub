import 'package:flutter/material.dart';

class BottomSheetMenu extends StatefulWidget {
  const BottomSheetMenu({super.key});

  @override
  State<BottomSheetMenu> createState() {
    return _BottomSheetMenuState();
  }
}

class _BottomSheetMenuState extends State<BottomSheetMenu> {
  @override
  void dispose() {
    // dispose() akan dipanggil ketika widget tidak lagi dibutuhkan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('showModalBottomSheet'),
    );
  }
}
