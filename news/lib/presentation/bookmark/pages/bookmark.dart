import 'package:flutter/cupertino.dart';
import 'package:news/core/configs/assets/app_images.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.wall),
            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            Text(
              'This feature is under construction.',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
