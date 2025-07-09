import 'package:result_dart/result_dart.dart';

final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

class MemoryClient {
  Future<Result<List<String>>> getItems() async {
    await Future.delayed(Duration(seconds: 2));
    return Success(items);
  }
}
