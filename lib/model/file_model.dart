class FileModel {
  String? id;
  String? nama;
  String? path;
  FileModel({this.id, this.nama, this.path});

  FileModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    nama = json['Nama'];
    path = json['Path'];
  }
}