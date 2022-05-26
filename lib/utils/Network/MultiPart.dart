import 'dart:async';
import 'dart:convert';
import 'package:coffe_admin/configuration/NetworkConfiguration.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import 'RestController.dart';

class MultipartRequest extends http.MultipartRequest {
  final void Function(int bytes, int totalBytes) onProgress;

  /// Creates a new [MultipartRequest].
  MultipartRequest(
    String method,
    Uri url, {
    required this.onProgress,
  }) : super(method, url);

  /// Freezes all mutable fields and returns a single-subscription [ByteStream]
  /// that will emit the request body.
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;
    final total = this.contentLength;
    int bytes = 0;
    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress(bytes, total);
        if (total >= bytes) {
          sink.add(data);
        }
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}

class RemoteFileManager {
  RemoteFileManager();
  late final void Function(String url) onComplete;
  late final void Function(double progress) onProgress;

  void uploadFile(
      {required onComplete,
      required onProgress,
      required String filename}) async {
    this.onComplete = onComplete;
    this.onProgress = onProgress;
    var uri = Uri.parse(NetworkConfiguration().address +
        NetworkConfiguration().controllersMap['upload_file']);

    final request = MultipartRequest(
      'POST',
      uri,
      onProgress: (int bytes, int total) {
        this.onProgress(bytes / total);
      },
    );
    request.headers['HeaderKey'] = 'header_value';
    request.fields['form_key'] = 'form_value';
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        filename,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.send().then((response) {
      if (response.statusCode == 200)
        response.stream.transform(utf8.decoder).listen((value) {
          this.onComplete(value);
        });
    });
  }

  void deleteFile({url}) {
    RestController().sendPostRequest(
        onComplete: ({required String data}) {
          print('deletedFile' + '$data');
        },
        onError: ({required String data}) {},
        controller: 'delete_file',
        data: '{"url":"' + url + '"}');
  }
}
