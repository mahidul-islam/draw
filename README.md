# Drawing App

Drawing app flutter. 

## To release dmg app for MacOS release

To release for macOS dmg file. need to install npm package with
```
npm install -g appdmg     
```
Then Use the command to release a dmg
```
flutter build macos

appdmg installer/macos_dmg/config.json installer/macos_dmg/drawingbook.dmg
```
