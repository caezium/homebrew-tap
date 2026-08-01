# caezium/homebrew-tap

A [Homebrew](https://brew.sh) tap for [caezium](https://github.com/caezium)'s macOS apps.

```bash
brew install --cask caezium/tap/<name>
```

(That auto-adds the tap; no separate `brew tap` needed.)

## Apps

| Cask | Description |
|---|---|
| [`wisp`](https://github.com/caezium/wisp) | On-device inline AI autocomplete for any macOS text field |
| [`burrow`](https://github.com/caezium/Burrow) | Native macOS GUI for the Mole (`mo`) CLI |
| [`nib`](https://github.com/caezium/nib) | Hand-drawn editorial illustrations starring your own character |

Update or remove any app the usual way:

```bash
brew upgrade --cask <name>
brew uninstall --cask <name>
```

## Notes

- Cask definitions live in [`Casks/`](Casks); each app's source lives in its own repo.
- Burrow's current cask is Developer ID signed and notarized. It preserves
  quarantine so Gatekeeper can validate Apple's notarization ticket.
- Wisp and Nib are currently self-signed pre-1.0 builds, so their casks clear
  quarantine automatically. If macOS still blocks either app, right-click it
  and choose **Open**.
- Issues and feedback belong on the individual app's repo.

## Adding an app (maintainer note)

1. Cut a GitHub release with a zipped `.app` (most repos have a `package-release` script that prints the `sha256`).
2. Drop `Casks/<name>.rb` here with the release `url` + `sha256`.
3. Add a row to the table above.
