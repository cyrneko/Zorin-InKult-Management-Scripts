# Zorin-InKult-Management-Scripts

# Neugeschriebene version vom Skript:

## **Siehe in den "Rewrite" Ordner, und du siehst 3 weitere Dateien.**
### Darunter:
- ***InKultManagement.sh***
    - InKultManagement.sh ist der Management Skript, für generelle system-maintenance, siehe zb Pipewire oder Pulseaudio neustarten, oder beschleunigte Updates
- ***InKultRewritten.sh***
    - InKultRewritten.sh ist der installations/Setup Skript, er wird benutzt um Zorin 16 Core/Lite, oder andere Debian-basierte distributionen einzurichten, komplett Automatisch
- ***README.md***
    spoiler
    - README.md ist eine weitere README Datei, welche ein wenig mehr information über die Skripte gibt

---
## Ab hier beginnt das alte README.md
---

Hier verstaue/speichere ich scripts für das InKult und Zorin Installationen, um Management für Mitarbeiter, Ehrenamtliche, oder auch leute welche nur kurz einspringen zu erleichtern.

## Dieses Repository wird so lange geupdated wie ich im InKult aktiv bin und/oder es existiert

Sollte ein "nachfolger" nach diesen scripts gefragt haben, und weiß nicht weiter/wie man diesen Script benutzt, und/oder wie man ihn auf neuere versionen von Zorin upgraded, kontaktiere mich auf [Telegram](https://telegram.dog/HowToRush), und ich werde dir gerne weiterhelfen.

---

## basic benutzung

Core mit GUI:

```bash
chmod +x ./inkultsetup.sh && ./inkultsetup.sh
```

Lite mit GUI:

```bash
chmod +x ./inkultsetup.sh && ./inkultsetup.sh
```

Du Kannst auch variabeln vor `./inkultsetup.sh` stellen, um verhalten zu ändern, zum beispiel so:
```bash
MCJAVA=1 ./inkultsetup.sh
```
Hiermit wird dann Minecraft Java Edition installiert zusammen mit allen anderen Programmen und Änderungen.

---

## Liste von Variabeln welche eingesetzt werden können, und was diese bewirken:

| Variabel     | Effekt auf das Endergebnis                                                              |
|--------------|-----------------------------------------------------------------------------------------|
| MCJAVA=1     | Installiert Minecraft Java Edition                                                      |
| CLI=1/0      | Aktiviert/Deaktiviert CLI Modus (Keine Benutzeroberfläche)                              |
| LITE=1       | Überspringt die installation von Zorin-Dash (nicht für Lite verfügbar)                  |
| UPGRADABLE=1 | Noch nicht Implementiert, wird in späteren versionen für's updaten der software benutzt |