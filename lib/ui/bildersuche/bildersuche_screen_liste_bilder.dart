import 'package:akquinet_bildersuche/common/logger.dart';
import 'package:akquinet_bildersuche/feature/bildersuche/provider/pixabay_bildersuche_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'bildersuche_detail_screen.dart';

// Liste mit Bildern aus Suche
class BildersucheScreenListeBilder extends ConsumerStatefulWidget {
  const BildersucheScreenListeBilder({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BildersucheState();
}

class _BildersucheState extends ConsumerState<BildersucheScreenListeBilder> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Über Scrollposition prüfen, wann Daten per Pagination nachgeladen werden sollen
    scrollController.addListener(() {
      ref.read(loggerProvider).d("Prüfe ob Daten nachgeladen werden sollen");
      final max = scrollController.position.maxScrollExtent;
      final current = scrollController.position.pixels;
      const delta = 150; // Abstand von unterem Rand
      if (max - current <= delta) {
        ref.read(pixabayBildersucheProvider.notifier).ladeNaechsteSeite();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bilderSucheResponse = ref.watch(pixabayBildersucheProvider);
    return bilderSucheResponse.when(
      data: (data) => data.anzahlErgebnisse <= 0
          ? const Center(
              child: Text("Keine Ergebnisse"),
            )
          : ListView.builder(
              controller: scrollController,
              itemCount: data.bilder.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  // Detailseite aufrufen
                  onTap: () => Navigator.pushNamed(
                    context,
                    BildersucheDetailScreen.routeName,
                    arguments: index,
                  ),
                  // Bild über Netzwerk laden und cachen
                  title: Image.network(
                    bilderSucheResponse.value!.bilder[index].webformatURL,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
