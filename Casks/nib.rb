# Homebrew cask for Nib.
#
# This is the template for a tap (caezium/homebrew-tap). After a GitHub
# release, set `version` + `sha256` (scripts/package-release.sh in the nib repo
# prints both), copy this to `Casks/nib.rb` in the tap, and users install with:
#
#   brew install --cask caezium/tap/nib
#
cask "nib" do
  version "0.2.0"
  sha256 "ce8391b75f865360399f29a3ac8d7ecb8da5e259eaf09a98706ee8e8f297f320"

  url "https://github.com/caezium/nib/releases/download/v#{version}/Nib-#{version}.zip"
  name "Nib"
  desc "Hand-drawn editorial illustrations starring your own character"
  homepage "https://github.com/caezium/nib"

  # Homebrew 5.1.11 (May 2026) changed `depends_on macos: :sonoma` from
  # "exactly Sonoma" to "Sonoma or newer" and deprecated the `">= :sonoma"`
  # string form (a hard error under HOMEBREW_DEVELOPER). Branch so both old
  # and new Homebrew get "macOS 14 or newer" with no warning.
  # TODO: drop the legacy branch once pre-5.1.11 Homebrew is rare (~2027).
  if Version.new(HOMEBREW_VERSION.split("-").first) >= Version.new("5.1.11")
    depends_on macos: :sonoma
  else
    depends_on macos: ">= :sonoma"
  end
  depends_on arch: :arm64

  app "Nib.app"

  # Pre-1.0 builds are self-signed (not notarized yet), so clear the quarantine
  # flag to avoid a Gatekeeper block on first launch. Remove once notarized.
  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{appdir}/Nib.app"], sudo: false
  end

  uninstall quit: "dev.henryzh.nib"

  caveats <<~EOS
    Nib is an unsigned pre-1.0 build. If macOS still blocks it, right-click the
    app and choose Open, or run:  xattr -cr "#{appdir}/Nib.app"

    Image generation needs a backend: sign in to the Codex CLI to generate free
    on your ChatGPT subscription, or add an OpenRouter API key in Settings.
  EOS

  zap trash: [
    "~/Library/Application Support/dev.henryzh.nib.Nib",
    "~/Library/Preferences/dev.henryzh.nib.plist",
  ]
end
