import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TrangChu(),
    );
  }
}

class TrangChu extends StatefulWidget {
  @override
  _TrangChuState createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChu> {
  String _thongDiepGuiDuLieu = "";
  final _tenController = TextEditingController();
  DateTime? _ngaySinhDuocChon;
  int? _viTriChinhSua;

  // Danh sách để lưu thông tin đã nhập và trạng thái check
  List<Map<String, dynamic>> _danhSachThongTin = [];

  // Hàm để gửi yêu cầu POST đến endpoint '/submit'
  Future<void> _guiDuLieu() async {
    if (_tenController.text.isEmpty || _ngaySinhDuocChon == null) {
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:8080/api/v1/submit'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': _tenController.text,
        'dateOfBirth': _ngaySinhDuocChon!.toIso8601String(),
      }),
    );

    final data = json.decode(response.body);
    setState(() {
      _thongDiepGuiDuLieu = data['message'] ?? 'Có lỗi xảy ra';

      if (_viTriChinhSua == null) {
        // Thêm thông tin mới nếu không đang chỉnh sửa
        _danhSachThongTin.add({
          'name': _tenController.text,
          'dateOfBirth': _ngaySinhDuocChon,
          'message': _thongDiepGuiDuLieu,
          'checked': false, // Mặc định chưa được check
        });
      } else {
        // Cập nhật thông tin khi đang chỉnh sửa
        _danhSachThongTin[_viTriChinhSua!] = {
          'name': _tenController.text,
          'dateOfBirth': _ngaySinhDuocChon,
          'message': _thongDiepGuiDuLieu,
          'checked': _danhSachThongTin[_viTriChinhSua!]['checked'],
        };
        _viTriChinhSua = null;
      }

      // Reset các trường nhập sau khi gửi
      _tenController.clear();
      _ngaySinhDuocChon = null;
    });
  }

  // Hàm chọn ngày sinh
  Future<void> _chonNgaySinh(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _ngaySinhDuocChon) {
      setState(() {
        _ngaySinhDuocChon = pickedDate;
      });
    }
  }

  // Hàm để chỉnh sửa thông tin
  void _suaThongTin(int index) {
    setState(() {
      _tenController.text = _danhSachThongTin[index]['name'];
      _ngaySinhDuocChon = _danhSachThongTin[index]['dateOfBirth'];
      _viTriChinhSua = index;
    });
  }

  // Hàm để xóa thông tin
  void _xoaThongTin(int index) {
    setState(() {
      _danhSachThongTin.removeAt(index);
    });
  }

  // Hàm để cập nhật trạng thái check của mỗi hàng
  void _toggleChecked(int index, bool? value) {
    setState(() {
      _danhSachThongTin[index]['checked'] = value ?? false;
    });
  }

  // Xây dựng bảng dữ liệu từ danh sách
  Widget _xayDungBang() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Tên')),
        DataColumn(label: Text('Ngày Sinh')),
        DataColumn(label: Text('Thông Điệp')),
        DataColumn(label: Text('Check')),
        DataColumn(label: Text('Hành Động')),
      ],
      rows: _danhSachThongTin
          .asMap()
          .map((index, thongTin) {
            return MapEntry(
              index,
              DataRow(cells: [
                DataCell(Text(thongTin['name'] ?? '')),
                DataCell(Text(thongTin['dateOfBirth'] != null
                    ? thongTin['dateOfBirth'].toString().split(' ')[0]
                    : '')),
                DataCell(Text(thongTin['message'] ?? '')),
                DataCell(Checkbox(
                  value: thongTin['checked'],
                  onChanged: (value) {
                    _toggleChecked(index, value);
                  },
                )),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _suaThongTin(index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _xoaThongTin(index),
                    ),
                  ],
                )),
              ]),
            );
          })
          .values
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Dart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _tenController,
              decoration: InputDecoration(labelText: 'Nhập tên của bạn'),
            ),
            Row(
              children: [
                Text(
                  _ngaySinhDuocChon == null
                      ? 'Chọn ngày sinh của bạn'
                      : 'Ngày sinh: ${_ngaySinhDuocChon.toString().split(' ')[0]}',
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _chonNgaySinh(context),
                  child: Text('Chọn Ngày'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _guiDuLieu,
              child: Text(_viTriChinhSua == null ? 'Gửi Dữ Liệu' : 'Cập Nhật'),
            ),
            Text(_thongDiepGuiDuLieu),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: _xayDungBang(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
