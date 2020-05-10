import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:path/path.dart' as path;
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;

import './post_edit.dart';

class InstaGallery extends StatefulWidget {
  @override
  _InstaGalleryState createState() => _InstaGalleryState();
}

class _InstaGalleryState extends State<InstaGallery> {
  int pageViewActiveIndex = 0;

  bool nextPressed = false;

  Future<File> imageFile;
  List<File> selectedImages = [];
  List<String> filteredImagesPath = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      showModalSheet(context);
    });
  }

  pickImageFromSystem(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Image'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => showModalSheet(context),
          ),
          FlatButton(
            child: Text(
              nextPressed ? 'PROCEED' : 'NEXT',
              style: TextStyle(
                color: Colors.blueAccent,
              ),
            ),
            onPressed: () async {
              if (selectedImages.isEmpty)
                Fluttertoast.showToast(
                  msg: 'Please select an image first!',
                  backgroundColor: Colors.blueGrey,
                );
              else if (nextPressed) {
                print('Proceed Clicked');
                Navigator.of(context).pushNamed(PostEdit.routeName,
                    arguments: filteredImagesPath);
              } else {
                nextPressed = true;
                for (var i = 0; i < selectedImages.length; i++) {
                  applyFilter(i).then((Map map) {
                    if (map != null && map.containsKey('image_filtered')) {
                      filteredImagesPath.add(map['image_filtered'].path);
                      print(filteredImagesPath);
                      if (i == (selectedImages.length - 1)) setState(() {});
                    }
                  });
                }
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        width: double.infinity,
        height: 400.0,
        child: showImage(),
      ),
    );
  }

  void showModalSheet(BuildContext context) => showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 150,
          color: Colors.blueGrey[150],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.camera),
                    Text('Camera'),
                  ],
                ),
                onPressed: () {
                  pickImageFromSystem(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.folder_open),
                    Text('Gallery'),
                  ],
                ),
                onPressed: () {
                  pickImageFromSystem(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null &&
            !selectedImages.contains(snapshot.data))
          selectedImages.add(snapshot.data);

        if (selectedImages.length == 0) {
          return Center(
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Click ',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 20.0,
                    ),
                  ),
                  TextSpan(
                    text: '+',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 40.0,
                    ),
                  ),
                  TextSpan(
                    text: ' to add images.',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return selectedImages.length == 1
            ? imageBuilder(
                nextPressed
                    ? FileImage(File(filteredImagesPath[0]))
                    : FileImage(snapshot.data),
                false)
            : PageView.builder(
                itemCount: selectedImages.length,
                onPageChanged: (currentIndex) {
                  setState(() {
                    this.pageViewActiveIndex = currentIndex;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return imageBuilder(
                      FileImage(nextPressed
                          ? ((index >= filteredImagesPath.length)
                              ? selectedImages[index]
                              : File(
                                  filteredImagesPath.reversed.toList()[index]))
                          : (selectedImages.reversed.toList()[index])),
                      true);
                });
      },
    );
  }

  Widget imageBuilder(ImageProvider image, bool multiple) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: image,
          ),
        ),
        child: multiple
            ? Container(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    width: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey[400],
                    ),
                    child: Text(
                      '${pageViewActiveIndex + 1} / ${selectedImages.length}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      );

  Future<Map> applyFilter(int i) async {
    var imageFile = File(selectedImages[i].path);
    String fileName = path.basename(imageFile.path);
    var image = imageLib.decodeImage(imageFile.readAsBytesSync());
    image = imageLib.copyResize(image, width: 600);
    return await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          title: Text('Please select filter'),
          filters: presetFiltersList,
          image: image,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
