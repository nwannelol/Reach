// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:permission_handler/permission_handler.dart';

// class UserImage extends StatefulWidget {
//   final Function(String imageurl) onFileChanged;

//   const UserImage({required this.onFileChanged});

//   @override
//   State<UserImage> createState() => _UserImageState();
// }

// class _UserImageState extends State<UserImage> {
//   final ImagePicker imagePickerVar = ImagePicker();
//   String? imageUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (imageUrl == null)
//           Icon(Icons.image, size: 60, color: Theme.of(context).primaryColor),
//         if (imageUrl != null)
//           InkWell(
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             onTap: () => selectPhoto(),
//             child: Text(
//               imageUrl != null ? 'Change Photo' : 'Select Photo',
//               style: TextStyle(
//                   color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
//             ),
//           )
//       ],
//     );
//   }

//   Future selectPhoto() async {
//     await showModalBottomSheet(
//       context: context,
//       builder: (context) => Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: Icon(Icons.camera),
//             title: Text('Camera'),
//             onTap: () {
//               Navigator.of(context).pop();
//               pickImage(ImageSource.camera);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future pickImage(ImageSource source) async {
//     final pickedFile = await imagePickerVar.pickImage(source: source, imageQuality: 50);
//     if (pickedFile == null) {
//       return;
//     }

//     var file = await ImageCropper.cropImage(
//         sourcePath: pickedFile.path, aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
//     if (file == null) {
//       return;
//     }

//     file = await compressImage(file.path, 35);
//   }

//   Future compressImage(String path, int quality) async {
//     final newPath = path_provider.join((await getTemporaryDirectory()).path,
//         '${DateTime.now()}.${path_provider.extension(path)}');

//     final result = await FlutterImageCompress.compressAndGetFile(
//       path,
//       newPath,
//       quality: quality,
//     );

//     return result;
//   } 
// }
