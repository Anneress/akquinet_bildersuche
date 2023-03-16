# akquinet_bildersuche

Für den Bewerbungsprozess bei akquinet soll ein Projekt ausgearbeitet werden, um die Heransgehensweise und Fähigkeiten bei der Entwicklung darzustellen.

## Aufgabenstellung:
Dauer: Ca 3-4 Stunden.

Es soll eine kleine Webanwendung gebaut werden. Die Technologie ist flutter. Die Webanwendung soll über einen Webserver verfügbar sein, der gerne auf einem lokalen Entwicklungsrechner laufen kann. Es reicht keine lokale Datei, die vom Browser geladen wird.

Nach Eingabe eines Suchbegriffs in der Anwendung sollen mehrere Bilder als Suchergebnis angezeigt werden. Wenn z.B. nach "Obama" gesucht wird, sollen Bilder von Obama angezeigt werden.

Die Bilder sollen in mehreren Spalten oder als Liste angezeigt werden.

Bei Klick auf ein Bild sollen auf einem weiteren Screen ein paar beliebige Details zum Bild angezeigt werden (z.B. Höhe, Breite, Autor, Datum).

Als Backend soll eine Bildersuchservice mit einer REST Schnittstelle angebunden werden. Auswahl:
- https://docs.microsoft.com/en-us/azure/cognitive-services/bing-image-search/
- https://pixabay.com/api/docs/
- etc.

Zu der Arbeitsprobe gehört auch eine gute Präsentation der Ergebnisse. Diese sollte wie bei einem Zwischenergebnis vor dem Kunden oder den Kollegen des Projektteams durchgeführt werden.

## Umsetzung
Der Einfachheit halber wird die Webapp mit dem Python http.server lokal gehostet (siehe https://docs.flutter.dev/deployment/web). Zu Demonstrationszwecken steht diese ebenfalls über Github Pages zur Verfügung.

Es wird außerdem auf eine Willkommensseite, Einstellungen, Caching und verschiedene Sprachen verzichtet. Diese Webapp ist weder hundert prozent sicher noch durchgehend getestet.

> Dieses Projekt sollte nicht zu Produktivzwecken verwendet werden.

### Statemanagement und Fehlerbehandlung
Für die Datenbereistellung und Trennung zwischen UI und Buisness Logik wird das Package Riverpod verwendet. Dieses bringt zudem die AsyncValue Klasse mit, welche sich sehr gut für die Fehlerbehandlung eignet. Fehler werden geloggt. Alle für den Nutzer relvanten Fehlermeldungen werden entsprechend dargestellt.

### Pagination
Da beide vorgeschlagenen Bildersuchservices Pagination mitbringen, wird dieses entsprechend implementiert.

### Api Keys
Die verwendeten Api Keys sind lokal im Ordner lib/keys als .dart Dateien gespeichert. Ein Eintrag in .gitignore verhindert das veröffentlichen dieser. 