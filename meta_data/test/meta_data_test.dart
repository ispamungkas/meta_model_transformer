import 'package:flutter_test/flutter_test.dart';
import 'package:meta_data/meta_data.dart';

void main() {
  group('Result', () {
    test('Result.ok should return Success', () {
      const result = Result<int, String>.ok(
        100,
        'Success',
      );

      expect(result, isA<Success<int, String>>());

      switch (result) {
        case Success(data: final data, message: final message):
          expect(data, 100);
          expect(message, 'Success');

        case Error():
          fail('Expected Success');

        case Loading():
          fail('Expected Success');
      }
    });

    test('Result.error should return Error', () {
      const result = Result<String, String>.error(
        'Network error',
        'Failed to fetch data',
      );

      expect(result, isA<Error<String, String>>());

      switch (result) {
        case Success():
          fail('Expected Error');

        case Error(error: final error, message: final message):
          expect(error, 'Network error');
          expect(message, 'Failed to fetch data');

        case Loading():
          fail('Expected Error');
      }
    });

    test('Result.loading should return Loading', () {
      const result = Result<String, Exception>.loading();

      expect(result, isA<Loading<String, Exception>>());

      switch (result) {
        case Success():
          fail('Expected Loading');

        case Error():
          fail('Expected Loading');

        case Loading():
          expect(true, isTrue);
      }
    });
  });
}
