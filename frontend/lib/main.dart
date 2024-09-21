import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ứng dụng Kết Nối Server',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearOfBirthController = TextEditingController();
  String responseMessage = '';
  bool isLoading = false;

  String getBackendUrl() {
    if (kIsWeb) {
      return 'http://localhost:8080';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080';
    } else {
      return 'http://localhost:8080';
    }
  }

  Future<void> submit() async {
    final String name = nameController.text.trim();
    final String yearOfBirth = yearOfBirthController.text.trim();

    if (name.isEmpty || yearOfBirth.isEmpty || int.tryParse(yearOfBirth) == null) {
      setState(() {
        responseMessage = 'Vui lòng nhập tên và năm sinh hợp lệ!';
      });
      return;
    }

    setState(() {
      isLoading = true;
      responseMessage = '';
    });

    final String backendUrl = getBackendUrl();
    final Uri url = Uri.parse('$backendUrl/api/v1/submit');

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'name': name, 'yearOfBirth': int.parse(yearOfBirth)}));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          responseMessage = data['message'];
        });
      } else {
        setState(() {
          responseMessage = 'Không nhận được phản hồi từ server';
        });
      }
    } catch (e) {
      setState(() {
        responseMessage = 'Đã xảy ra lỗi: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ứng dụng Kết Nối Server')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông tin sinh viên
            Align(
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('Mã SV: 123456', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Họ tên: Nguyễn Văn A', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nhập tên của bạn'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: yearOfBirthController,
              decoration: const InputDecoration(labelText: 'Nhập năm sinh của bạn'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: isLoading ? null : submit,
              child: isLoading ? const CircularProgressIndicator() : const Text('Gửi thông tin'),
            ),
            const SizedBox(height: 20),
            Text(
              responseMessage,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
