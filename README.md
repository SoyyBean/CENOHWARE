<p align="center">
  <img src="assets/logo.png" width="128" alt="CENOHWARE logo">
</p>

<h1 align="center">CENOHWARE</h1>

<p align="center">
  An all-in-one Windows app: an autoclicker, shotgun keyboard sounds, a safe disk cleaner, a Minecraft server manager,
  an AI-text humanizer, and a pretend-money casino. One window, custom themes, and everything stays on your PC.
</p>

---

## Download

Grab **`CENOHWARE.exe`** from the [Releases](../../releases) page (or from this repository) and run it. There is
nothing to install.

- **Needs:** Windows 10 or 11. It uses the .NET Framework 4.8 that comes with Windows.
- **First launch:** the exe is not code-signed, so Windows SmartScreen may say *"Windows protected your PC"*. Click
  **More info → Run anyway**.

## What's inside

### 🖱️ Hold Click
An autoclicker in a small window that stays on top of your game.
- **Hold** any mouse button down, or **autoclick** it at any speed, from as fast as possible to once an hour.
- **Two keys** mode presses two keys one after another (for example Q, E, Q, E…).
- Your own keybind starts and stops it. **Pause/Break** always stops it in an emergency.

### 🔫 Shotgun Keys
Every key you press fires a shotgun blast, and Backspace racks the gun. You can set the volume, and choose whether
blasts overlap or restart. It listens to key presses only to play the sound; nothing is recorded or saved.

### 🧹 Disk Cleaner
Frees up drive space without guessing. Nothing is touched until you tick it and confirm.
- **Junk:** temp files, browser, Discord, Steam and Epic caches, graphics shader caches, crash dumps and the Recycle Bin.
- **Deep clean** (asks for administrator permission once): old Windows updates, update downloads, Delivery
  Optimization files, Windows logs, Windows.old, the hibernation file and old restore points.
- **Leftovers:** old installers in Downloads, and folders left behind by programs you have uninstalled.
- **Old files, Big files, Duplicates, Folders:** find what is eating your space in any folder.
- Your own files always go to the **Recycle Bin**, so you can get them back.

### ⛏️ Minecraft Server
Manage a Minecraft server running on another PC on your network.
- Status, players online, TPS and graphs.
- Console and commands, gamerule shortcuts, and per-player actions (for example switching gamemode).
- Backups, restarts and join alerts.
- It connects over **RCON**. An optional helper program (saved from the tab) runs on the server PC so you can start and
  stop the server remotely.

### ✍️ Humanizer
Rewrites stiff, AI-sounding text so it reads like a person wrote it. It uses Claude with **your own Anthropic API
key**, which is stored encrypted for your Windows account only. Without a key it uses the built-in offline rules.

### 🎰 Cacenoh
Five casino games: **Rocket, Mines, Slots, Blackjack and Plinko**. They are played with **CenohCoins**, which are
pretend money. CenohCoins are not real, cannot be bought and cannot be cashed out. Use **your own pictures** as the
rocket, gems, slot symbols, face cards and balls, or play with the built-in symbols.

### 🎨 Themes
Frutiger Aero, Dragon Ball, Janemba, Zachery, ten preset colours, or any colour you pick. You can also choose your own
background picture, and reorder the tabs in the sidebar.

## Privacy

- **No accounts and no tracking.** Nothing is sent anywhere.
- **Network:** CENOHWARE only goes online when you use a feature that needs it. The Minecraft tab talks to your own
  server, and the Humanizer talks to the Claude API with your key.
- **Your settings** are kept in `%APPDATA%\CENOHWARE` and `%APPDATA%\HoldClick`.

## Uninstall

Delete `CENOHWARE.exe`. To remove your settings too, delete the folders `%APPDATA%\CENOHWARE` and `%APPDATA%\HoldClick`.

## Build from source

You only need Windows. The C# compiler that comes with the .NET Framework is enough, so there's no Visual Studio to
install.

```powershell
powershell -ExecutionPolicy Bypass -File build.ps1
```

The exe lands in `build\CENOHWARE.exe`.

- **Shotgun Keys sounds:** the two sound files are not in the repository. Put your own `ks_blast.wav` (the shot) and
  `ks_cock.wav` (the rack) in `assets\` before building to include them.
- **Layout:**

  | Path | What's in it |
  |---|---|
  | `src\Hub.cs` | The main window, sidebar, Home page and intro |
  | `src\Ui.cs` | Themes, buttons and cards |
  | `src\Cacenoh.cs`, `src\CasinoLogo.cs` | The casino |
  | `src\DiskCleaner.cs` | Disk Cleaner |
  | `src\ShotgunKeys.cs` | Shotgun Keys |
  | `src\MinecraftServer.cs`, `src\Mc*.cs` | The Minecraft tab |
  | `src\mchelper\McHelper.cs` | The helper for the server PC |
  | `src\Humanizer.cs` | Humanizer |
  | `src\holdclick\` | Hold Click |
  | `src\MakeIcon.cs` | Draws the exe icon |

## License

[MIT](LICENSE). You can use, change and share the code, as long as the license notice stays with it.

## Notes

- **Games:** autoclickers and key repeaters may be against the rules of some online games. Use them where they are
  allowed.
- **Disk Cleaner:** the Deep clean steps for Windows.old, the hibernation file and restore points cannot be undone.
  They are never ticked unless you tick them.

---

<p align="center">Made by Cenoh</p>
