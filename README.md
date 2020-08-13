# flutter-android-docker

Flutter, Node, Firebase, Android SDK, Java SDK.
Can be used for github actions, vscode .devcontainer, etc


```bash
docker pull andreujuanc/flutter-android
```


## USB debugging

I use this image as a base on my vscode .devcontainer, for which I have to add:

```json
//devcontainer.json
runArgs" : [
	"--cap-add=ALL", 
	"--privileged"
],
```

Of if you need just a quick debug session for example with ADB, you can just: 
```
  docker run -it --cap-add=ALL --privileged  --entrypoint bash andreujuanc/flutter-android
```
and it will open a bash session with all the tools installed and usb connection to your devices
