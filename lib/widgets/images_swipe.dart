import 'package:flutter/material.dart';

import '../appUtils.dart';

class ImagesSwipe extends StatefulWidget {
  final List<dynamic> imagesList;

  ImagesSwipe({@required this.imagesList});

  @override
  _ImagesSwipeState createState() => _ImagesSwipeState();
}

class _ImagesSwipeState extends State<ImagesSwipe> {
  List<dynamic> _imagesList;
  int _selectedPage = 0;

  @override
  void initState() {
    _imagesList = widget.imagesList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 270,
        child: Stack(
          children: [

            ///Page view of product images
            PageView(
              onPageChanged: (num){
                setState(() {
                  _selectedPage = num;
                });
              },
              children: [
                for (var i = 0; i < _imagesList.length; i++)
                  Container(
                    child: FadeInImage.assetNetwork(
                      placeholder: '${AppUtils.images_dir}place_holder.png',
                      image: _imagesList[i],
                      fit: BoxFit.cover,
                    ),
                  )
              ],
            ),


            ///Animated dots
            Positioned(
              bottom: 20.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < _imagesList.length; i++)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      margin: EdgeInsets.all(5.0),
                      width: _selectedPage == i ? 35.0: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color:  Colors.black.withOpacity(0.6),
                      ),
                    )
                ],
              ),
            )

          ],
        ));
  }
}
