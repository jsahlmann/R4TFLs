# Einleitung

Dieses Repo bezieht sich auf das Tutorium "TFLs mit R: Neue Wege für SAS-Veteranen", das bei der KSFE 2023 in Wiesbaden gehalten werden soll.

## TFLs mit R: Neue Wege für SAS-Veteranen

### Aktuelle Lage

Sie arbeiten bereits lange mit SAS und können alle Programmieraufgaben, die im Rahmen der Auswertung von klinischen Studien auftreten, problemlos erledigen.

Überraschend ändert sich in Ihrer Firma, in der Sie arbeiten, die Firmenpolitik, und es soll einen Wechsel von SAS zu R geben.
Die Rationale für diesen Wechsel ist nicht offensichtlich.

Was tun? Fight or flight?

Dieses Tutorium zeigt Ihnen anhand typischer Beispiele in der TFL-Programmierung, wie Standardausgaben mit R erstellt werden können.

### Lernziele

Am Ende des Tutoriums können Sie folgende Ausgaben erstellen:

- "Table 1"-Tabellen mit der behandlungsarmweisen Darstellung stetiger und kategorieller Variablen
- Adverse Event-Tabellen in verschiedenen Varianten
- Lineares Modell: Estimate-Tabelle als Prototyp für andere Modelle
- Mean-Plot
- Survival-Plot
- Demographie-Listing
- Adverse Events-Listings

Bei ausreichender Zeit am Ende des Tutoriums wird noch gezeigt, wie die SDTM-Domäne DM nach CDISC mit R erstellt werden kann.

### Voraussetzungen

Voraussetzungen für die Teilnahme an dem Tutorium ist ein Laptop mit installierter R-Umgebung bestehend aus

- R in der Version 4.2.2 (<https://www.r-project.org/>) und
- RStudio in der Version 2022.12 (<https://posit.co/download/rstudio-desktop/>)
- Installierte Packages
  - tidyverse
  - ggplot2
  - flextable
  - officer
  - rmarkdown (NEU hinzugefügt 05.03.2023)
  - survminer (NEU hinzugefügt 05.03.2023)
  - foreign (NEU hinzugefügt am 10.03.2023)
  - safetyData (NEU hinzugefügt am 10.03.2023)
  - survival (NEU hinzugefügt am 10.03.2023)
  - weitere Pakete werden bis spätestens zum 13.03.2023 an dieser Stelle ergänzt
- Kursunterlagen

Der Kurs wird in einer Windows-Umgebung durchgeführt.
Auf etwaige Besonderheiten einer Linux- oder einer MacOS-Umgebung kann im Rahmen des Tutoriums nicht eingegangen werden.

### Bereitstellung von Kursunterlagen und weiteren Informationen

Auf der Github-Seite <https://github.com/jsahlmann/R4TFLs/> werden nach Anmeldeschluss weitere Dokumente bereitgestellt.
Hierzu gehören auch die Kursunterlagen.

Zusätzlich gibt es eine Zusammenfassung der wichtigsten R-Befehle, die für das Tutorium benötigt werden.
Das Lesen dieser Zusammenfassung und die Kenntnis dieser R-Befehle ist ebenfalls Voraussetzung für die Teilnahme an diesem Tutorium.

Der Status des Repos wird zu diesem Zeitpunkt von offen auf geschlossen gewechselt und jeder Teilnehmer des Tutoriums bekommt einen Zugang.
Hierfür ist eine Anmeldung bei Github notwendig.

### Vorbereitender Onlinetermin (optional)

In den zwei Wochen vor dem Tutorium wird es Onlinetermine geben, in denen die Installation überprüft werden kann,
und in dem die Zusammenfassung der R-Befehle durchgegangen und besprochen wird. 

* Mi, 15.03.2023 16:00 - 18:00 Uhr. Vorbereitung Teil 1
* Fr, 17.03.2023 17:00 - 19:00 Uhr. Vorbereitung Teil 1 (Alternativtermin)
* Mi, 22.03.2023 16:00 - 18:00 Uhr. Vorbereitung Teil 2
* Fr, 24.03.2023 17:00 - 19:00 Uhr. Vorbereitung Teil 2 (Alternativtermin)

### Nachbereitung (optional)

Nach der KSFE wird es einen Termin zur Nachbereitung geben, an dem offene Fragen diskutiert werden können und 
ggf. weitere Tutorien geplant werden können.

* Mi, 05.04.2023 16:00 - 18:00 Uhr. Nachbereitung

