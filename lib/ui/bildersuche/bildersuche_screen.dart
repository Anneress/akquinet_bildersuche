import 'package:akquinet_bildersuche/feature/bildersuche/provider/pixabay_bildersuche_provider.dart';
import 'package:akquinet_bildersuche/ui/bildersuche/bildersuche_screen_liste_bilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../style.dart';

// Seite zum Suchen und Anzeigen von Bildern aus Bildersuche
class BildersucheScreen extends ConsumerWidget {
  const BildersucheScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultSpace),
        child: Column(
          children: [
            const Flexible(
              child: BildersucheScreenListeBilder(),
            ),
            const SizedBox(
              height: defaultSpace,
            ),
            // Eingabefeld für Suchbegriff
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 450,
              ),
              child: TextField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: "Suchbegriff für Bildsuche eingeben",
                ),
                // Suche direkt bei jedem Ändern starten
                onChanged: ref
                    .read(pixabayBildersucheProvider.notifier)
                    .aenderSuchPhrase,
              ),
            ),
            const SizedBox(
              height: defaultSpace,
            ),
            // Anzeigen von wo die Bilder stammen
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: smallSpace,
              runSpacing: smallSpace,
              children: [
                const Text("Powered by"),
                Image.asset("images/pixabay_logo.png", width: 150),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
