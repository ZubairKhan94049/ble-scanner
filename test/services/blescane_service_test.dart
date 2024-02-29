import 'package:flutter_test/flutter_test.dart';
import 'package:ble_scanner/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('BlescaneServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
