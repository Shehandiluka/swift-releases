# Swift releases

Catalog and installers used by **Swift Hub** (install & update all SwiftPayPOS software).

- `catalog.json` — the list of apps Swift Hub shows. **Add a new app here and it appears in every Swift Hub automatically.**
- `<app>/latest.json` — newest version of each app (`version`, `url`, `sha256`, `size`, `date`, `notes`).
- `icons/<app>.png` — app icons.
- Installers are attached to GitHub Releases named `<app>-v<version>`.

## Publish a new version
```
tools/publish.sh swiftclean ../swiftclean/dist/SwiftClean-Setup-1.0.3.exe ../swiftclean/dist/latest.json
git commit -am "SwiftClean 1.0.3" && git push
```

## Add a new app
Add an entry to `catalog.json`:
```json
{ "id": "myapp", "name": "My App", "category": "Utilities", "tagline": "…", "description": "…",
  "features": ["…"], "regKey": "MyApp", "exe": "MyApp.exe",
  "manifest": "https://raw.githubusercontent.com/Shehandiluka/swift-releases/main/myapp/latest.json",
  "icon": "https://raw.githubusercontent.com/Shehandiluka/swift-releases/main/icons/myapp.png" }
```
`regKey` is the uninstall registry key name the app's installer writes
(`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\<regKey>` with `DisplayVersion`, `InstallLocation`, `QuietUninstallString`),
and the installer must support silent install with `/S`.
