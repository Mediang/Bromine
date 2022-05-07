# Bromine

## Features

- Asynchronous entity tracker
- Fixed book banning

## Downloads

The latest jar file can be found [here](https://github.com/Mediang/Bromine/releases/tag/release).
The direct download link is [here](https://github.com/Mediang/Bromine/releases/download/release/Bromine-paperclip-1.18.2-R0.1-SNAPSHOT-reobf.jar).

## Building

You need to run these commands in a linux environment, or WSL.
At least JDK 7 is required to be installed.

```shell
./gradlew applyPatches
./gradlew createReobfPaperclipJar
```

The execution time may vary depending on your hardware.
The reobfuscated paperclip jar file can be found in `build/libs`.

## License

Patches are licensed under [GPL-3.0](PATCH-LICENSE), everything else under MIT.
