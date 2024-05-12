import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;
  const EditData({required this.list, required this.index});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController nimcontroller = TextEditingController();
  TextEditingController namacontroller = TextEditingController();
  TextEditingController prodicontroller = TextEditingController();

  late String idMhs;

  void editData(String id) {
    var url =
        Uri.parse("https://6600f55a87c91a116419d146.mockapi.io/Mahasiswa/$id");
    http.put(url, body: {
      "nim": nimcontroller.text,
      "nama": namacontroller.text,
      "prodi": prodicontroller.text,
    });
  }

  void deleteData(String id) {
    var url =
        Uri.parse("https://6600f55a87c91a116419d146.mockapi.io/Mahasiswa/$id");
    http.delete(url, body: {'id': widget.list[widget.index]['id']});
  }

  void konfirmasi() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "Apakah Anda Yakin akan Menghapus data' ${widget.list![widget.index!]['nama']}'"),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: Text(
            "OK DELETE!",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            deleteData(idMhs);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false);
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: Text('CANCEL', style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  void initState() {
    idMhs = widget.list[widget.index]['id'];
    nimcontroller =
        TextEditingController(text: widget.list![widget.index!]['nim']);
    namacontroller =
        TextEditingController(text: widget.list![widget.index!]['nama']);
    prodicontroller =
        TextEditingController(text: widget.list![widget.index!]['prodi']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data Mahasiswa"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Ubah Data Mahasiswa',
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: nimcontroller,
              decoration: InputDecoration(labelText: "NIM"),
            ),
            TextFormField(
              controller: namacontroller,
              decoration: InputDecoration(labelText: "NAMA"),
            ),
            TextFormField(
              controller: prodicontroller,
              decoration: InputDecoration(labelText: "PRODI"),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    editData(idMhs);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text('Ubah'),
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      konfirmasi();
                    },
                    child: Text('Hapus')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
