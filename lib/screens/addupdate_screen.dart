import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/file_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import '../providers/barang.dart';
import '../providers/model_listbarang.dart';
import '../widgets/unggahberkash.dart';

class AddUpdateScreen extends StatefulWidget {
  static String id = "addupdate";
  Barang? barang;
  bool? edit;

  AddUpdateScreen({Key? key, this.barang = null, this.edit = true})
      : super(key: key);
  @override
  _AddUpdateScreenState createState() => _AddUpdateScreenState();
}

class _AddUpdateScreenState extends State<AddUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  bool? _validate = false;
  File? images;
  TextEditingController? _nmBarang = TextEditingController();
  TextEditingController? _hrgBarang = TextEditingController();
  TextEditingController? _gmbrBarang = TextEditingController();
  TextEditingController? _detBarang = TextEditingController();
  File? _image;
  String? _idBarang;
  FileModel? valuesBerkas;
  var picker = ImagePicker();

  String? state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit == true) {
      initData(widget.barang);
    }
  }

  void initData(Barang? barang) {
    _nmBarang = TextEditingController(text: barang?.barangNama);
    _hrgBarang = TextEditingController(text: barang?.barangHarga);
    _gmbrBarang = TextEditingController(text: barang?.barangGambar);
    _detBarang = TextEditingController(text: barang?.barangDetail);
    _idBarang = barang?.barangId;
  }

  @override
  Widget build(BuildContext context) {
    final listBarang = Provider.of<ModelListBarang>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit! ? "Edit Barang" : "Add Barang"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: myTextFormField(
                      _nmBarang, TextInputType.text, "nama barang"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: myTextFormField(
                      _hrgBarang, TextInputType.number, "harga barang"),
                ),
                UnggahBerkas(
                  values: valuesBerkas,
                  images: images,
                  delCallbackLokal: (File value) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Perhatian'),
                        content:
                            const Text('Apakah anda ingin menghapus file ini?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Batal'),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                              setState(() {
                                images?.delete();
                                // path = null;
                                // images = null;
                              });
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  imagesCallback: (File? value) {
                    setState(() {
                      images = File(value!.path);

                      print("isi path :" + images!.path.toString());
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12, top: 50),
                  child: myTextFormField(
                      _detBarang, TextInputType.multiline, "detail barang"),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Text(widget.edit == true ? "Update" : "save"),
                      onPressed: () async {
                        await cekValidasi(listBarang);
                      }),
                )
              ],
            )),
      ),
    );
  }

  tampilPilihan() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      getImageCamera();
                    },
                    child: Text("Take a Photo"),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImageGalery();
                    },
                    child: Text("open photo from galery"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  getImageCamera() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _gmbrBarang?.text = path.basename(_image!.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.pop(context);
  }

  getImageGalery() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _gmbrBarang?.text = path.basename(_image!.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.pop(context);
  }

  Widget myTextFormField(
      TextEditingController? controller, TextInputType? type, String? label) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: label),
      validator: validator,
    );
  }

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "tidak boleh kosong";
    } else {
      return null;
    }
  }

  Future cekValidasi(ModelListBarang listBarang) async {
    if (_formKey.currentState!.validate()) {
      print("test");
      _formKey.currentState?.save();
      if (widget.edit == true && images != null) {
        // await listBarang
        //     .updateProductProvider(_idBarang, _nmBarang?.text, _hrgBarang?.text,
        //         images?.path, _detBarang?.text)
        //     .then((value) => Navigator.pop(context));
      } else if (widget.edit == false && images != null) {
        String res = await listBarang
            .insertBarangProvider(_nmBarang?.text, _hrgBarang?.text,
                images?.path, _detBarang?.text)
            .then((value) {
          print("test");

          Navigator.pop(context);
          return value;
        });
        setState(() {
          state = res;
          print(res);
        });
      } else if (widget.edit == true && _image == null) {
        // await listBarang
        //     .updateProductTanpagmbar(_idBarang, _nmBarang?.text,
        //         _hrgBarang?.text, _gmbrBarang?.text, _detBarang?.text)
        //     .then((value) {
        //   final scaffold = ScaffoldMessenger.of(context);

        //   if (value.sukses!) {
        //     Navigator.pop(context);
        //     scaffold.showSnackBar(
        //       SnackBar(
        //         content: Text(value.pesan!),
        //       ),
        //     );
        //   } else {
        //     scaffold.showSnackBar(
        //       SnackBar(
        //         content: Text(value.pesan!),
        //       ),
        //     );
        //   }
        // });
      }
    }
  }
}
