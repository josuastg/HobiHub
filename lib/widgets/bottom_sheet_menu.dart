import 'package:flutter/material.dart';
import 'package:hobihub/screens/info_app_screen.dart';

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
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Tutup bottom sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoApplication(),
                  ),
                );
              },
              child: const Text('Go to Info Application'),
            ),
          ],
        ),
      ),
    );
  }
}
