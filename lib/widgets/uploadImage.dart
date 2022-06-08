import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';


import '../models/users.dart';


class uploadImage extends StatelessWidget {
  var maxImages;

  uploadImage({Key? key, this.maxImages}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FormBuilderImagePicker(
      name: 'photos',
      // displayCustomType: (obj) =>
      // obj is ApiImage ? obj.imageUrl : obj,
      // decoration: const InputDecoration(labelText: 'Pick Photos'),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
                Radius.circular(20)
            )
        ),
      ),
      maxImages: maxImages,
      previewHeight: 140,
      previewWidth: 284,
      previewMargin: EdgeInsets.only(bottom: 0),
      iconColor: Colors.white,
      fit: BoxFit.contain,
      // initialValue: [
      //   'https://images.pexels.com/photos/7078045/pexels-photo-7078045.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      //   const Text('this is an image\nas a widget !'),
      //   ApiImage(
      //     id: 'whatever',
      //     imageUrl:
      //     'https://images.pexels.com/photos/8311418/pexels-photo-8311418.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
      //   ),
      // ],
    );
  }
}




