import 'package:flutter_test/flutter_test.dart';
import 'package:meta_model_transformer/example/isi.dart';
import 'package:meta_model_transformer/example/sample.dart';
import 'package:meta_model_transformer/example/usu.dart';
import 'package:meta_model_transformer/global/model/generated/meta_transformer_generator.x.dart';

void main() {
  group('IsiToObj Extension Test Scenarios', () {
    
    // =========================================================================
    // SCENARIO 1: Mengetes Pengembalian Tipe Data List<T> (Skenario Sukses)
    // =========================================================================
    group('List<T> Mapping Scenarios', () {
      test('Harus sukses mengembalikan List<Sample> ketika data berisi List of Maps', () {
        // Mock data input berupa mentahan JSON List
        final mockRawData = [
          {'id': 1},
          {'id': 2}
        ];
        
        // Inisialisasi objek Isi dengan generic tipe berupa List<Sample>
        final isiContainer = Aca<List<Sample>>(data: mockRawData);
        
        // Eksekusi fungsi extension
        final result = isiContainer.getData();
        
        // Asersi/Validasi
        expect(result, isA<List<Sample>>(), reason: 'ss');
        expect(result.length, equals(2));
      });

      test('Harus sukses mengembalikan List<Usu> ketika data berisi List of Maps', () {
        final mockRawData = [
          {'name': 'Ucup'}
        ];
        
        final isiContainer = Aca<List<Usu>>(data: mockRawData);
        final result = isiContainer.getData();
        
        expect(result, isA<List<Usu>>());
        expect(result.length, equals(1));
      });
    });

    // =========================================================================
    // SCENARIO 2: Mengetes Pengembalian Tipe Data Tunggal T / Map (Skenario Sukses)
    // =========================================================================
    group('Single Object T (Map) Mapping Scenarios', () {
      test('Harus sukses mengembalikan objek tunggal Sample2 ketika data berupa Map', () {
        // Mock data input berupa Map tunggal
        final mockRawData = {'key': 'value'};
        
        // Inisialisasi objek Isi dengan generic tipe berupa Sample2 tunggal
        final isiContainer = Aca<Sample2>(data: mockRawData);
        
        // Eksekusi fungsi extension
        final result = isiContainer.getData();
        
        // Asersi/Validasi
        expect(result, isA<Sample2>());
      });

      test('Harus sukses mengembalikan objek tunggal Usu ketika data berupa Map', () {
        final mockRawData = {'status': 'success'};
        
        final isiContainer = Aca<Usu>(data: mockRawData);
        final result = isiContainer.getData();
        
        expect(result, isA<Usu>());
      });
    });

    // =========================================================================
    // SCENARIO 3: Skenario Kegagalan & Batas (Edge Cases & Error Handling)
    // =========================================================================
    group('Edge Cases & Error Scenarios', () {
      test('Harus melempar Exception ketika tipe data tidak didukung (misal: String)', () {
        // Input berupa String biasa, yang mana tidak masuk kriteria List atau Map di switch
        final isiContainer = Aca<Sample>(data: 'Ini data teks sembarangan');
        
        // Asersi memastikan fungsi melempar Exception 'Unsupported type'
        expect(
          () => isiContainer.getData(),
          throwsA(isA<Exception>().having(
            (e) => e.toString(), 
            'message', 
            contains('Unsupported type'),
          )),
        );
      });

      test('Harus melempar TypeError / Exception jika T tidak sesuai dengan data di registry', () {
        final mockRawData = {'key': 'value'};
        
        // Mengisi kelas yang tidak terdaftar di blok generator _registry() Anda
        // Misal kita menggunakan tipe Int karena Int tidak ada di '_registry()' Anda
        final isiContainer = Aca<int>(data: mockRawData);
        
        // Karena _registry()['_int'] mengembalikan null, melakukan 'as int' pada null akan memicu error
        expect(
          () => isiContainer.getData(),
          throwsA(anything), 
        );
      });
    });

  });
}