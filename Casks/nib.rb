# Homebrew cask for Nib.
#
# This is the template for a tap (caezium/homebrew-tap). After a GitHub
# release, set `version` + `sha256` (scripts/package-release.sh in the nib repo
# prints both), copy this to `Casks/nib.rb` in the tap, and users install with:
#
#   brew install --cask caezium/tap/nib
#
cask "nib" do
  version "0.2.2"
  sha256 "c67f6700c34da4b1dd797b4b38d2f93558c65e2cb97adc5da10838bedf54215e"

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

  uninstall quit: "dev.henryzh.nib"

  caveats <<~EOS
    Image generation needs a backend: sign in to the Codex CLI to generate free
    on your ChatGPT subscription, or add an OpenRouter API key in Settings.
  EOS

  zap trash: [
    "~/Library/Application Support/dev.henryzh.nib.Nib",
    "~/Library/Preferences/dev.henryzh.nib.plist",
  ]
end
