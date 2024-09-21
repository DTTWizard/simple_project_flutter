# Làm quen với ứng dụng web động đơn giản sử dụng Flutter và Dart

Trong bài lab này tôi sẽ hướng dẫn phát triển ứng dụng full-stack đơn giản với Dart và Flutter bao gồm backend và frontend.

Việc sử dụng các framework hiện đại trong phát triển ứng dụng web giúp tăng tốc quá trình phát triển và dễ dàng quản lý dự án. Flutter là một công cụ phát triển ứng dụng đa nền tảng, cho phép chúng ta tạo ra các ứng dụng cho web, di động (Android, iOS) và desktop (Windows, macOS và Linux) từ cùng một dự án mã nguồn (codebase). Điều này giúp chúng ta tiết kiệm thời gian và công sức khi chúng ta chỉ cần viết mã một lần mà có thể biên dịch để chạy trên nhiều nền tảng khác nhau.

Quá trình biên dịch và phát hành ứng dụng web từ Dart và Framework sẽ tự động sinh ra mã cho backend và mã cho frontend (HTML, CSS và JavaScript) mà chúng ta không cần phải viết chúng trực tiếp. Điều này giúp chúng ta tập trung vào logic ứng dụng và giảm thiểu thời gian viết mã lặp lại. Tương tự, khi biên dịch ra các nền tảng di động hay desktop, chúng cũng sinh ra ứng dụng native trên cùng một codebase.

## Mục tiêu
- Hiểu và áp dụng được các khái niệm cơ bản về ứng dụng web động, ứng dụng đa nền tảng.
- Sử dụng Flutter framework để tạo giao diện đơn giản cho một ứng dụng.
- Sử dụng Dart và thư viện shelf, shelf_router để tạo server đơn giản xử lý các yêu cầu HTTP theo chuẩn RESTful API.
- Tích hợp giao diện với logic xử lý phản hồi từ server, thực hiện thao tác gửi dữ liệu từ client lên server thông qua HTTP POST.
- Kiểm thử đơn giản với Postman để kiểm tra phản hồi từ server đối với các yêu cầu GET và POST, bao gồm cả trường hợp hợp lệ và không hợp lệ.

## Cấu trúc thư mục
Để tiện cho việc quản lý và có thể đẩy lên GitHub, chúng ta sẽ cài đặt backend và frontend trong cùng một thư mục dự án.
```plaintext
simple_flutter_project\
|-- frontend/ # thư mục chứa mã nguồn Dart và Flutter cho frontend
|-- backend/  # thư mục chứa mã nguồn Dart cho backend
```

## Các bước thực hiện
### Bước 1: Khởi tạo dự án
1. Tạo thư mục gốc chứa dự án `simple_flutter_project`
2. Tạo thư mục `backend` và `frontend` trong thư mục `simple_flutter_project` như cấu trúc ở trên
3. Mở ứng dụng VS Code và mở thư mục `simple_flutter_project`

### Bước 2: Tạo ứng dụng server cho backend với Dart framework
1. Đi đến thư mục backend từ thư mục `simple_flutter_project`
    ```bash
    cd backend
    ```
2. Khởi tạo dự án Dart mới cho server
    ```bash
    dart create -t server-shelf . --force
    ```
    **Lưu ý:**
    - Nếu bạn chưa cài Flutter, hãy truy cập vào https://docs.flutter.dev/get-started/install/windows/web để tải về và cài đặt theo hướng dẫn. Bạn có thể chọn theo nền tảng Windows hoặc macOS của bạn.
    - Lệnh `dart create -t server-shelf . --force` sẽ tạo một dự án Dart với mẫu `-t, template` là `server-shelf` trong thư mục hiện tại `.` và tham số `--force` cho biết sẽ tạo dự án cho dù thư mục gốc đã tồn tại (mặc định là sẽ tạo mới thư mục).
3. Thêm các thư viện vào dự án backend nếu cần.
- Trong ứng dụng mẫu `server-shelf`, dự án đã sử dụng các thư viện `shelf` và `shelf-router` trong tệp `pubspec.yaml`.
- Các bạn có thể xem các thư viện khác ở trang https://pub.dev trên đó mình cũng có tạo một số package cho cộng đồng. Bạn có thể xem mô tả, ví dụ và hướng dẫn cài đặt.

### Bước 3: Tạo ứng dụng frontend bằng Flutter framework
1. Quay lại thư mục dự án chính (nếu bạn đang ở thư mục backend)
    ```bash
    cd ..
    ```
2. Chuyển đến thư mục frontend
    ```bash
    cd frontend
    ```
3. Khởi tạo dự án Flutter mới trong thư mục frontend
    ```bash
    flutter create -e .
    ```
    **Lưu ý:** Lệnh trên sẽ tạo một dự án Flutter mới trong thư mục frontend với mẫu là `Empty Application` hay tham số `-e` và tham số dấu chấm `.` cho biết sẽ khởi tạo trong thư mục hiện tại là thư mục `frontend`.
4. Thêm thư viện `http` vào dự án frontend
    ```bash
    flutter pub add http
    ```

### Bước 4: Thiết lập debug cho cả backend và frontend
- Mở tệp `frontend/lib/main.dart` trước
- Chọn `Run and Debug` ở thanh Side Bar và chọn `create a launch.json file` để tạo file cấu hình gỡ lỗi (debug).
- Tiến hành gỡ lỗi backend và frontend
**Lưu ý:** Chúng ta thiết lập cổng mặc định cho server backend là 8080 và cổng mặc định cho frontend là 8081 khi debug. Các bạn có thể thay đổi cổng.

### Bước 5: Đẩy dự án mã nguồn lên GitHub và quản lý mã nguồn
- Chọn `Source Control` ở thanh Side Bar và chọn `Publish to GitHub`.
- Quản lý mã nguồn bằng cách commit, push (Sync Changes...), pull,... từ cửa sổ `Source Control`.
**Lưu ý:** Nếu bạn chưa có Git thì hãy cài Git (tham khảo google). Các bạn cũng cần một chút kiến thức sử dụng GitHub từ google cũng khá là dễ.

### Bước 6: Phát triển backend và kiểm thử
1. Chỉnh sửa file `backend/bin/server.dart`:
- Mở file `server.dart` và chỉnh sửa:
```dart
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

final _router = Router()
  ..get('/api/v1/welcome/', _rootHandler)
  ..get('/api/v1/check/', _checkHandler)
  ..get('/api/v1/<message>', _echoHandler)
  ..post('/api/v1/submit', _submitHandler)
  ..put('/api/v1/update', _updateHandler)
  ..delete('/api/v1/delete/<id>', _deleteHandler);

// Cấu hình CORS middleware
final corsHeader = createMiddleware(
  requestHandler: (req) {
    if (req.method == 'OPTIONS') {
      return Response.ok('', headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, HEAD',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      });
    }
    return null;
  },
  responseHandler: (res) {
    return res.change(headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, HEAD',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    });
  },
);

/// Hàm xử lý yêu cầu tại đường dẫn gốc '/'
Response _rootHandler(Request req) {
  return _jsonResponse({'message': 'Xin chào! Đây là nơi bạn bắt đầu khám phá API của chúng tôi!'});
}

/// Hàm xử lý yêu cầu tại đường dẫn '/api/v1/check'
Response _checkHandler(Request req) {
  return _jsonResponse({
    'message': 'Chào mừng bạn đến với API động lực học! Mọi thứ đều ổn và bạn đã sẵn sàng khám phá.'
  });
}

/// Hàm echo để phản hồi lại với thông điệp được gửi qua URL
Response _echoHandler(Request req) {
  final message = req.params['message'];
  return _jsonResponse({'message': 'Bạn vừa gửi: "$message". Hãy tiếp tục khám phá nhé!'});
}

/// Hàm xử lý yêu cầu POST tại đường dẫn '/api/v1/submit'
Future<Response> _submitHandler(Request req) async {
  try {
    final data = await _parseJson(req);
    final name = data['name'] as String?;

    if (name != null && name.isNotEmpty) {
      return _jsonResponse({'message': 'Chào mừng $name! Cảm ơn vì đã tham gia!'});
    } else {
      return _badRequestResponse('Vui lòng cung cấp tên hợp lệ.');
    }
  } catch (e) {
    return _errorResponse('Yêu cầu không hợp lệ. ${e.toString()}', statusCode: 400);
  }
}

/// Hàm xử lý yêu cầu PUT tại đường dẫn '/api/v1/update'
Future<Response> _updateHandler(Request req) async {
  try {
    final data = await _parseJson(req);
    final name = data['name'] as String?;

    if (name != null && name.isNotEmpty) {
      return _jsonResponse({'message': 'Đã cập nhật tên thành $name.'});
    } else {
      return _badRequestResponse('Vui lòng cung cấp tên hợp lệ để cập nhật.');
    }
  } catch (e) {
    return _errorResponse('Lỗi trong quá trình cập nhật. ${e.toString()}', statusCode: 400);
  }
}

/// Hàm xử lý yêu cầu DELETE tại đường dẫn '/api/v1/delete/<id>'
Response _deleteHandler(Request req) {
  final id = req.params['id'];
  if (id != null) {
    return _jsonResponse({'message': 'Đã xóa người dùng với ID: $id.'});
  } else {
    return _badRequestResponse('Vui lòng cung cấp ID hợp lệ.');
  }
}

/// Hàm phụ để parse JSON từ request và xử lý ngoại lệ
Future<Map<String, dynamic>> _parseJson(Request req) async {
  try {
    final payload = await req.readAsString();
    return json.decode(payload) as Map<String, dynamic>;
  } catch (e) {
    throw Exception('Dữ liệu không phải là JSON hợp lệ.');
  }
}

/// Tạo phản hồi JSON chung
Response _jsonResponse(Map<String, dynamic> data, {int statusCode = 200}) {
  return Response(statusCode, body: json.encode(data), headers: _headers);
}

/// Tạo phản hồi lỗi với mã lỗi tùy chọn
Response _errorResponse(String message, {int statusCode = 500}) {
  return Response(statusCode, body: json.encode({'error': message}), headers: _headers);
}

/// Tạo phản hồi Bad Request (400)
Response _badRequestResponse(String message) {
  return _errorResponse(message, statusCode: 400);
}

// Header mặc định cho các phản hồi JSON
final _headers = {'Content-Type': 'application/json'};

/// Hàm chính để chạy server
void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;

  final handler = Pipeline()
      .addMiddleware(corsHeader) // Thêm middleware xử lý CORS
      .addMiddleware(logRequests()) // Ghi log tất cả các yêu cầu
      .addHandler(_router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  final server = await serve(handler, ip, port);

  print('🌍 Server đang hoạt động tại cổng ${server.port}. Sẵn sàng cho mọi yêu cầu!');
}

```
2. Debug backend và kiểm thử với Postman

3. Thêm Middleware xử lý CORS cho backend
- **CORS là gì?** CORS (Cross-Origin Resource Sharing) là một cơ chế bảo mật được các trình duyệt web sử dụng để ngăn chặn các trang web gửi yêu cầu đến một domain khác với domain của trang hiện tại. Điều này nhằm bảo vệ người dùng khỏi các cuộc tấn công CSRF (Cross-Site Request Forgery) và các mối đe doạn bảo mật khác.
- **Vì sao cần thêm CORS middleware?** Khi frontend (Flutter Web) gửi yêu cầu HTTP đến backend trên một domain khác, trình duyệt web sẽ chặn yêu cầu do vi phạm chính sách cùng nguồn gốc (Same-Origin Policy). Các yêu cầu từ Flutter Web (chạy trên localhost:8081) đến server backend (chạy trên localhost:8080) sẽ bị chặn nếu server không xử lý đúng các header CORS. Trình duyệt sẽ gửi một yêu cầu OPTIONS (Preflight Request) để kiểm tra xem server có cho phép không. Nếu server không phản hồi đúng, yêu cầu chính sẽ không được gửi.
- **Giải pháp:** Thêm Middleware xử lý CORS vào server backend để xử lý các yêu cầu OPTIONS bằng cách trả về các header CORS cần thiết. Thêm các header CORS vào tất cả các phản hồi từ server để trình duyệt cho phép giao tiếp giữa frontend và backend.
- Cập nhật mã nguồn hàm main của server:
```dart
void main(List<String> args) async {
  // Lắng nghe trên tất cả các địa chỉ IPv4
  final ip = InternetAddress.anyIPv4;

  final corsHeader = createMiddleware(
    requestHandler: (req) {
      if (req.method == 'OPTIONS') {
        return Response.ok('', headers: {
          // Cho phép mọi nguồn truy cập (trong môi trường dev). Trong môi trường production chúng ta nên thay * bằng domain cụ thể.
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, HEAD',
          'Access-Control-Allow-Headers': 'Content-Type, Authorization',
        });
      }
      return null; // Tiếp tục xử lý các yêu cầu khác
    },
    responseHandler: (res) {
      return res.change(headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, HEAD',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      });
    },
  );

  // Cấu hình một pipeline để logs các requests và middleware
  final handler = Pipeline()
      .addMiddleware(corsHeader) // Thêm middleware xử lý CORS
      .addMiddleware(logRequests())
      .addHandler(_router.call);

  // Để chạy trong các container, chúng ta sẽ sử dụng biến môi trường PORT.
  // Nếu biến môi trường không được thiết lập nó sẽ sử dụng giá trị từ biến
  // môi trường này; nếu không, nó sẽ sử dụng giá trị mặc định là 8080.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  // Khởi chạy server tại địa chỉ và cổng chỉ định
  final server = await serve(handler, ip, port);
  print('Server đang chạy tại http://${server.address.host}:${server.port}');
}
```

### Bước 7: Phát triển frontend và tích hợp hệ thống
1. Chỉnh sửa mã nguồn frontend
- Mở tệp `frontend/lib/main.dart` và thay thế nội dung bằng mã sau:
```dart
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Ứng dụng full-stack Flutter đơn giản',
      home: MyHomePage(),
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
      appBar: AppBar(title: const Text('Ứng dụng full-stack Flutter đơn giản')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Tên'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: isLoading ? null : sendName, // Disable button khi loading
              child: isLoading
                  ? const CircularProgressIndicator() // Hiện indicator khi loading
                  : const Text('Gửi'),
            ),
            // Hiển thị thông điệp phản hồi từ server
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                responseMessage,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```
