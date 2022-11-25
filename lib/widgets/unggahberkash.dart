import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/file_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'dart:io';

import '../util/style.dart';

class UnggahBerkas extends StatefulWidget {
  final ValueChanged<File>? delCallbackLokal;
  final FileModel? values;
  final ValueChanged<File>? imagesCallback;
  final File? images;
  const UnggahBerkas(
      {Key? key,
      this.delCallbackLokal,
      this.values,
      this.images,
      this.imagesCallback})
      : super(key: key);

  @override
  State<UnggahBerkas> createState() => _UnggahBerkasState();
}

class _UnggahBerkasState extends State<UnggahBerkas> {
  File? _image;
  bool? loading;
  final ImagePicker _picker = ImagePicker();
  String? result;
  FileModel? categories;
  FilterChip? chips;
  FilterChip? chipsLokal;

  FileType _pickingType = FileType.any;
  String? _extension;
  final bool _multiPick = false;

  @override
  Widget build(BuildContext context) {
    // print("berkas: ${widget.values?.length}");

    categories = widget.values;
    if (categories != null) {
      chips = FilterChip(
        backgroundColor: blue.withOpacity(.1),
        label: Text(
          _image?.path ?? "-",
          style: TextStyle(color: blue, fontSize: 10),
        ),
        onSelected: (bool value) {},
      );
    }

    _image = widget.images;
    if (_image != null) {
      chipsLokal = FilterChip(
          backgroundColor: blue.withOpacity(.1),
          label: Text(
            _image?.path ?? "-",
            style: TextStyle(color: blue, fontSize: 10),
          ),
          onSelected: (b) {
            setState(() {
              widget.delCallbackLokal!(_image!);
            });
          });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 10,
          ),
          child: Text(
            "Unggah Berkas",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  tampilPilihan();
                },
                style: ElevatedButton.styleFrom(
                  primary: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Unggah Disini', //  'Login'.toUpperCase(),
                    style: TextStyle(
                      // fontSize: 18.0,
                      color: Colors.black,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            )),
        widget.values != null ? chips! : Container(),
        _image != null ? chipsLokal! : Container(),
      ],
    );
  }

  void tampilPilihan() {
    AlertDialog alert = AlertDialog(
        title: const Text("Silahkan Pilih Sumber File"),
        content: SingleChildScrollView(
          child:
              // _buildPilihFile(),
              ListBody(
            children: [
              GestureDetector(
                onTap: () {
                  getImageFromCamera();
                },
                child: Row(
                  children: const <Widget>[
                    Icon(
                      Icons.camera,
                      color: Colors.pink,
                      size: 24.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Ambil Foto")
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _pickingType = FileType.image;
                  _cekPermissionStorage();
                },
                child: Row(
                  children: const <Widget>[
                    Icon(
                      Icons.image,
                      color: Colors.purple,
                      size: 24.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Buka Galeri")
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _pickingType = FileType.audio;
                  _cekPermissionStorage();
                },
                child: Row(
                  children: const <Widget>[
                    Icon(
                      Icons.audio_file,
                      color: Colors.orange,
                      size: 24.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Buka Audio")
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _pickingType = FileType.any;
                  _cekPermissionStorage();
                },
                child: Row(
                  children: const <Widget>[
                    Icon(
                      Icons.file_present,
                      color: Colors.green,
                      size: 24.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Buka Dokumen")
                  ],
                ),
              )
            ],
          ),
        ));
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  _cekPermissionStorage() async {
    // You can request multiple permissions at once.
    if (await Permission.storage.request().isGranted) {
      _openFileExplorer();
      return;
    }
  }

  // void _openFileExplorer() async {
  //   // IsShowingAuth.setValue(2);
  //   // IsShowingAuth.setValue(0);
  //   // if(IsShowingAuth.isShowing != 0){
  //   //   return;
  //   // }
  //   List<PlatformFile> _paths;
  //   try {
  //     // IsShowingAuth.setValue(0);
  //     _paths = (await FilePicker.platform.pickFiles(
  //       type: _pickingType,
  //       allowMultiple: _multiPick,
  //       allowedExtensions: (_extension?.isNotEmpty ?? false)
  //           ? _extension?.replaceAll(' ', '')?.split(',')
  //           : null,
  //     ))
  //         ?.files;
  //   } on PlatformException catch (e) {
  //     print("_openFileExplorer Unsupported operation" + e.toString());
  //     // IsShowingAuth.setValue(0);
  //   } catch (ex) {
  //     print("_openFileExplorer1 $ex");
  //     // IsShowingAuth.setValue(0);
  //   }
  //   print("_openFileExplorer1");
  //   if (!mounted) return;
  //   if (_paths == null) {
  //     IsShowingAuth.isShowing = 0;
  //   }
  //   print("_openFileExplorer2 $_paths");
  //   final path = _paths.map((e) => e.path).toList().first.toString();
  //   File file = File(path);
  //   // IsShowingAuth.setValue(2);
  //   setState(() {
  //     // IsShowingAuth.setValue(0);
  //     print("asdf : " + path);
  //     // String _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
  //     widget.imagesCallback(file);
  //   });
  //   Navigator.pop(context);
  // }

  void _openFileExplorer() async {
    final transaction = Sentry.startTransaction('_openFileExplorer()', 'task');
    List<PlatformFile>? _paths;

    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } catch (exception) {
      transaction.throwable = exception;
      transaction.status = const SpanStatus.internalError();
    } finally {
      await transaction.finish();
    }
    if (!mounted) return;

    String? path = _paths?.map((e) => e.path).toList().first.toString();
    File? file = File(path!);
    setState(() {
      widget.imagesCallback!(file);
    });
    Navigator.pop(context);
  }

  // void _clearCachedFiles() {
  //   FilePicker.platform.clearTemporaryFiles().then((result) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: result ? Colors.green : Colors.red,
  //         content: Text((result
  //             ? 'Temporary files removed with success.'
  //             : 'Failed to clean temporary files')),
  //       ),
  //     );
  //   });
  // }

  // Future<void> getImageFromCamera() async {
  //   // IsShowingAuth.setValue(0);
  //   IsShowingAuth.isShowing = 0;
  //   final XFile photo = await _picker.pickImage(source: ImageSource.camera);
  //   File file = File(photo.path);
  //   setState(() {
  //     print(file?.path.toString());
  //     widget.imagesCallback(file);
  //   });
  //   Navigator.pop(context);
  // }

  Future<void> getImageFromCamera() async {
    final transaction = Sentry.startTransaction('getImageFromCamera()', 'task');
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      File? file = File(photo!.path);
      setState(() {
        print(file.path.toString());
        widget.imagesCallback!(file);
      });
    } catch (exception) {
      transaction.throwable = exception;
      transaction.status = const SpanStatus.internalError();
    } finally {
      await transaction.finish();
    }
    Navigator.pop(context);
  }

  // Future<void> getImageFromGalery() async {
  //   final XFile photo = await _picker.pickImage(source: ImageSource.gallery);
  //   File file = File(photo.path);
  //   setState(() {
  //     _image = file;
  //     print(_image?.path.toString());
  //     var pos = _image?.path.lastIndexOf('/');
  //     result = _image?.path.substring(_image.path.lastIndexOf("/") + 1);
  //     print("result ${result}");
  //     widget.jokeCallback(result);
  //     widget.imagesCallback(_image);
  //   });
  //   Navigator.pop(context);
  // }
}
