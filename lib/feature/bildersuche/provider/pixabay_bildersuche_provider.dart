import 'package:akquinet_bildersuche/common/logger.dart';
import 'package:akquinet_bildersuche/feature/bildersuche/models/pixabay_bildersuche_response.dart';
import 'package:akquinet_bildersuche/keys/pixabay_api_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// Anzahl an Bidern pro Suche für Pagination
const bilderProSeite = 10;

// Pixabay Bildersuche Provider
final pixabayBildersucheProvider = StateNotifierProvider<
    PixabayBildersucheStateNotifier, AsyncValue<PixabayBildersucheResponse>>(
  (ref) => PixabayBildersucheStateNotifier(
    ref: ref,
  ),
);

// Pixabay BildersucheStateNotifier
//
// Kommunikation mit API und wandelt Response in internes Datenformat
// Dio Client wandelt Error Response in DioError, diese werden in BildersucheController mit AsyncValue behandelt
class PixabayBildersucheStateNotifier
    extends StateNotifier<AsyncValue<PixabayBildersucheResponse>> {
  final Ref ref; // Provider Referenz für dio Client und Logger
  final Dio _dio; // Http Client für Netzwerkanfragen
  final Logger _logger;
  String
      _suchPhrase; // Standard leerer String gibt alle Bilder von Pixabay zurück
  int _seitenIndex = 1; // Für Seitenindex von Pagination

  PixabayBildersucheStateNotifier({required this.ref, String suchPhrase = ""})
      : _suchPhrase = suchPhrase,
        _dio = ref.read(pixabayDioProvider),
        _logger = ref.read(loggerProvider),
        super(const AsyncLoading()) {
    _onInit();
  }

  // suche Bilder direkt nach dem Erstellen
  void _onInit() {
    _logger.d("_onInit -> findImages");
    sucheBilder();
  }

  // Ändern der Suchphrase setzt Seitenindex zurück und startet erste Suche
  void aenderSuchPhrase(String suchPhrase) {
    _suchPhrase = suchPhrase;
    _seitenIndex = 1;
    sucheBilder();
  }

  // Nächste Seite von Bildsuche Pagination laden
  void ladeNaechsteSeite() {
    _seitenIndex++;
    sucheBilder();
  }

  // Sende Suchanfrage an API
  //
  // Sendet per http Client Anfrage an API
  // Wandelt das Ergebnis in internes Format und setzt dieses als state des Providers
  // Fehler werden geloggt und im state für UI gesetzt
  Future<void> sucheBilder() async {
    try {
      _logger.d(
        "findImages by: $_suchPhrase, page: $_seitenIndex, itemsPerPage: $bilderProSeite",
      );

      // Wenn bereits Daten vorhanden sind soll kein Loading state gesetzt werden.
      if (_seitenIndex == 1) {
        state = const AsyncLoading();
      }

      // Suchanfrage an Server mit baseUrl, key und query senden
      final response = await _dio.get("/api/", queryParameters: {
        "q": _suchPhrase,
        "page": _seitenIndex,
        "per_page": bilderProSeite,
      });
      _logger.d(response.data);

      // Ergebnis von konvertiertet JsonMap in internes Format
      final bildersucheResponse =
          PixabayBildersucheResponse.fromMap(response.data);

      // state setzen um UI upzudaten
      if (_seitenIndex == 1) {
        state = AsyncData(
          bildersucheResponse,
        );
      } else {
        // falls bereits Daten vorhanden sind, die Bilder aus neuem Ergebnis hinzufügen
        var bilderCopy = state.value!.bilder;
        bilderCopy.addAll(bildersucheResponse.bilder);
        state = AsyncData(state.value!.copyWith(
          bilder: bilderCopy,
        ));
      }
    } on DioError catch (e, stackTrace) {
      // Netzwerkfehler separat behandeln
      _logger.e(e.requestOptions);
      _logger.e(e.type);
      _logger.e(e.message);
      state = AsyncError(e, stackTrace);
    } catch (e, stackTrace) {
      // alle anderen Fehler
      _logger.e(e);
      state = AsyncError(e, stackTrace);
    }
  }
}

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
