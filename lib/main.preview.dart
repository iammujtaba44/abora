
import 'package:flutter/widgets.dart';
import 'package:preview/preview.dart';
import 'screens/Trainer/post_ad_page.dart';
void main() {
  runApp(_PreviewApp());
}

class _PreviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PreviewPage(
      path: 'screens/post_ad_page.dart',
      providers: () => [
        IPhone5(), 
        IPhoneX(), 
        IPad(), 
        
      ],
    );
  }
}
  