# Homebrew cask for Wisp.
#
# This is the template for a tap (caezium/homebrew-tap). After a GitHub
# release, set `version` + `sha256` (scripts/package-release.sh prints both),
# copy this to `Casks/wisp.rb` in the tap, and users install with:
#
#   brew install --cask caezium/tap/wisp
#
cask "wisp" do
  version "0.1.0-beta"
  sha256 "aa831c9b970779c771060d8a1201e1bebf6e113901c7471171ebcdeea909ec00"

  url "https://github.com/caezium/wisp/releases/download/v#{version}/Wisp-#{version}.zip"
  name "Wisp"
  desc "On-device inline AI autocomplete for any macOS text field"
  homepage "https://github.com/caezium/wisp"

  depends_on macos: ">= :sonoma"

  app "Wisp.app"

  # Pre-1.0 builds are self-signed (not notarized yet), so clear the quarantine
  # flag to avoid a Gatekeeper block on first launch. Remove once notarized.
  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{appdir}/Wisp.app"], sudo: false
  end

  uninstall quit: "app.local.wisp"

  caveats <<~EOS
    Wisp needs Accessibility access (and Screen Recording, only if you use
    Screen Context): System Settings → Privacy & Security. If macOS still
    blocks it, right-click the app and choose Open, or run:
      xattr -cr "#{appdir}/Wisp.app"

    On-device models: pick a recommended .gguf in Settings → Predictor, or use
    Apple Intelligence / an OpenAI-compatible endpoint.
  EOS

  zap trash: [
    "~/Library/Application Support/Wisp",
    "~/Library/Logs/Wisp",
    "~/Library/Preferences/app.local.wisp.plist",
  ]
end
