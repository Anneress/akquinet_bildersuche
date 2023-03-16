import 'package:akquinet_bildersuche/keys/pixabay_api_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Pixabay Bildersuche Http Schnittstelle für Kommunikation mit API
//
// Kommunikation mit API und wandelt Response in internes Datenformat
// Dio Client wandelt Error Response in DioError, diese werden in BildersucheController mit AsyncValue behandelt
class PixabayBildersucheRepository {
  final Dio dio; // Dio Client als Referenz übergeben für Mocking bei Test

  PixabayBildersucheRepository({required this.dio});

  // Sende Suchanfrage an API
  //
  // Gibt das Ergebnis im internen Format zurück
  // [pageIndex] anzuzeigender Seitenindex (totalHits / itemsPerPage = numberOfPages)
  // [itemsPerPage] Anzahl Ergebnisse pro Seite (Für Pagination)
  Future<void> findImages({
    required String searchPhrase,
    int pageIndex = 1,
    int itemsPerPage = 20,
  }) async {
    try {
      final response = await dio.get("/api/", queryParameters: {
        "q": searchPhrase,
        "page": pageIndex,
        "per_page": itemsPerPage,
      });
      print(response.data);
    } on DioError catch (e) {
      print(e.requestOptions);
      print(e.type);
      print(e.message);
    } catch (e) {
      print(e);
    }
  }
}

// Pixabay Bildersuche Http Schnittstelle
final pixabayBildersucheRepositoryProvider = Provider(
  (ref) => PixabayBildersucheRepository(
    dio: ref.watch(pixabayDioProvider),
  ),
);

// Http Client für Pixabay Bildersuche mit baseUrl und API Key zur Verfügung stellen
final pixabayDioProvider = Provider(
  (ref) => Dio(
    BaseOptions(
      baseUrl: "https://pixabay.com",
      queryParameters: {
        "key": pixabayApiKey,
      },
    ),
  ),
);
