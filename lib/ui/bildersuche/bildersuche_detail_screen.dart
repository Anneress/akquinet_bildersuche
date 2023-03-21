import 'package:akquinet_bildersuche/feature/bildersuche/provider/pixabay_bildersuche_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../style.dart';

// Anzeige von Bilddetails in separater Seite, könnte auch auf größeren Bildschirmen neben Liste angezeigt werden
class BildersucheDetailScreen extends ConsumerWidget {
  const BildersucheDetailScreen({super.key, required this.index});

  // Routename für Navigation
  static const routeName = "/bild_detail";

  // Index in Liste der Bilder
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bildersucheResponse = ref.watch(pixabayBildersucheProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(defaultSpace),
        child: bildersucheResponse.when(
          data: (data) => data.bilder.isEmpty
              ? const Center(
                  child: Text("Keine Bilder gefunden"),
                )
              : Center(
                  child: Column(
                    children: [
                      Flexible(
                        child: Image.network(data.bilder[index].webformatURL),
                      ),
                      const SizedBox(
                        height: defaultSpace,
                      ),
                      Text("Höhe: ${data.bilder[index].imageHeight}"),
                      const SizedBox(
                        height: defaultSpace,
                      ),
                      Text("Breite: ${data.bilder[index].imageWidth}"),
                      const SizedBox(
                        height: defaultSpace,
                      ),
                      Text("Autor: ${data.bilder[index].user}"),
                      const SizedBox(
                        height: defaultSpace,
                      ),
                      Text("Likes: ${data.bilder[index].likes}"),
                    ],
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
        ),
      ),
    );
  }
}
