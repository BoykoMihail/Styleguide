# Команды для импорта ключей на билдере

```sh
sudo security -v import ~/Desktop/builder_seva.p12 -k /Library/Keychains/System.keychain -T /usr/bin/codesign -A

sudo security import ~/Desktop/builder_seva.p12 -k /Library/Keychains/System.keychain -t priv -A
```