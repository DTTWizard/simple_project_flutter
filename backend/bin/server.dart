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
      .addMiddleware(logRequests()) // Ghi log tất cả các yêu cầu
      .addHandler(_router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  
  final server = await serve(handler, ip, port);
  
  print('🌍 Server đang hoạt động tại cổng ${server.port}. Sẵn sàng cho mọi yêu cầu!');
}
