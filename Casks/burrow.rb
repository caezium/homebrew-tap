# Homebrew cask for Burrow.
#
# This is a template for a tap (e.g. caezium/homebrew-tap). After a GitHub
# release, set `version` + `sha256` (scripts/release.sh prints both), copy
# this to `Casks/burrow.rb` in the tap, and users install with:
#
#   brew install --cask caezium/tap/burrow
#
cask "burrow" do
  version "0.6.0"
  sha256 "72f7953b454d9d2e6361e8695e82d24f6711f7b24eb5150505bb7c4377be0083"

  url "https://github.com/caezium/Burrow/releases/download/v#{version}/Burrow-#{version}.zip"
  name "Burrow"
  desc "Free, open-source native GUI for the Mole CLI"
  homepage "https://github.com/caezium/Burrow"

  depends_on formula: "mole"
  depends_on macos: ">= :sonoma"

  app "Burrow.app"

  # Pre-1.0 builds aren't notarized yet, so clear the quarantine flag to
  # avoid a Gatekeeper block on first launch. Remove this once the app
  # ships signed + notarized.
  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{appdir}/Burrow.app"], sudo: false
  end

  caveats <<~EOS
    Burrow is an unsigned pre-1.0 build. If macOS still blocks it, right-click
    the app and choose Open, or run:  xattr -cr "#{appdir}/Burrow.app"
  EOS

  zap trash: [
    "~/Library/Application Support/Burrow",
    "~/Library/Preferences/dev.caezium.Burrow.plist",
  ]
end
