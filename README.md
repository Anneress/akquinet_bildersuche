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
Um den zeitlichen Rahmen des Projekts nicht zu überschreiten wird auf verschiedene Dinge, wie eine Willkommensseite, Einstellungen, verschiedene Sprachen, Tests, u.ä., verzichtet. 

### Hosting
Der Einfachheit halber wird die Webapp mit dem Python http.server lokal gehostet (siehe https://docs.flutter.dev/deployment/web).

> Problem Preflight Request wegen nicht erlaubter Options Methode, siehe https://stackoverflow.com/questions/64955435/flutter-web-cors-issue

Zu Demonstationszwecken als Chrome Release ausführen, verzichtet auf Preflight Request.

### Backend
Als Backend habe ich mich für Pixabay aus folgenden Gründen entschieden.

- Einfacher Aufbau
- gute Dokumentation
- keine Kosten bei Überschreitung von Suchanfragen

Über eine Abstraktion der Bildersuche, ließe sich die Webapp leicht an andere Backends anpassen. 

### Statemanagement
Für die Datenbereistellung und Trennung zwischen UI und Buisness Logik wird das Package Riverpod verwendet. 

### Fehlerbehandlung
Riverpod bringt zudem die AsyncValue Klasse mit, welche sich sehr gut für die Fehlerbehandlung eignet. Alle für den Nutzer relvanten Fehlermeldungen werden entsprechend dargestellt. 
Zusätlich werden alle Fehler geloggt.

### Api Keys
Die verwendeten API Keys sind lokal im Ordner lib/keys als .dart Dateien gespeichert. Ein Eintrag in .gitignore verhindert das veröffentlichen dieser. 

### Pagination
Da das Backend Pagination mitbringt und dies aus meiner Sicht bei einer langen Liste an Bildern unabdingbar ist, habe ich dieses als Infinite Scroll implementiert.
