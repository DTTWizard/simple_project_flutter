import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Hàm main là điểm bắt đầu của ứng dụng
void main() {
  runApp(const MainApp()); // Chạy ứng dụng với widget MainApp
}

/// Widget MainApp là widget gốc của ứng dụng
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt biểu tượng debug ở góc phải trên
      title: 'Ứng dụng full-stack Flutter đơn giản',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

/// Widget MyHomePage là trang chính của ứng dụng, sử dụng StatefulWidget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// Lớp state cho MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  /// Controller để lấy dữ liệu từ Widget TextField
  final TextEditingController controller = TextEditingController();

  /// Biến để lưu thông điệp phản hồi từ server
  String responseMessage = '';

  /// Biến để kiểm tra trạng thái gửi yêu cầu
  bool isLoading = false;

  /// Sử dụng địa chỉ IP thích hợp cho backend
  String getBackendUrl() {
    if (kIsWeb) {
      return 'http://localhost:8080'; // hoặc sử dụng IP LAN nếu cần
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080'; // cho emulator
      // return 'http://192.168.1.x:8080'; // cho thiết bị thật khi truy cập qua LAN
    } else {
      return 'http://localhost:8080';
    }
  }

  /// Hàm để gửi tên tới server
  Future<void> sendName() async {
    final String name = controller.text.trim();

    // Kiểm tra xem tên có rỗng hay không
    if (name.isEmpty) {
      setState(() {
        responseMessage = 'Vui lòng nhập tên!';
      });
      return;
    }

    // Xóa nội dung trong controller sau khi lấy tên
    controller.clear();
    setState(() {
      isLoading = true; // Bắt đầu trạng thái loading
      responseMessage = ''; // Reset thông điệp
    });

    final String backendUrl = getBackendUrl();
    final Uri url = Uri.parse('$backendUrl/api/v1/submit');

    try {
      // Gửi yêu cầu POST tới server
      final http.Response response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'name': name}),
          )
          .timeout(const Duration(seconds: 10));

      // Kiểm tra nếu phản hồi có nội dung
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        // Giải mã phản hồi từ server
        final Map<String, dynamic> data = json.decode(response.body);

        // Cập nhật trạng thái với thông điệp nhận được từ server
        setState(() {
          responseMessage = data['message'];
        });
      } else {
        // Phản hồi không thành công hoặc không có nội dung
        setState(() {
          responseMessage = 'Không nhận được phản hồi từ server';
        });
      }
    } catch (e) {
      // Xử lý lỗi kết nối hoặc lỗi khác
      setState(() {
        responseMessage = 'Đã xảy ra lỗi: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false; // Kết thúc trạng thái loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ứng dụng Flutter kết nối server')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Nhập tên của bạn',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : sendName, // Disable button khi loading
              child: isLoading
                  ? const CircularProgressIndicator() // Hiện indicator khi loading
                  : const Text('Gửi tên'),
            ),
            // Hiển thị thông điệp phản hồi từ server
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                responseMessage,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
