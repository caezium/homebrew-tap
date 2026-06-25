class CcTools < Formula
  desc "Power-user CLI tools for Claude Code: cc-session + ccron"
  homepage "https://github.com/caezium/cc-tools"
  url "https://github.com/caezium/cc-tools/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "48386625925d96a6ec8d6f58329b5482bec9c72a5f1c79e91bb2044a053512a6"
  license "MIT"

  depends_on "tmux" # cc-session runs the Claude TUI inside tmux
  # ccron is pure-stdlib Python 3 (preinstalled on macOS)

  def install
    bin.install "bin/cc-session"
    bin.install "bin/cc-remote"
    bin.install "bin/ccron"
  end

  test do
    assert_match "persistent Claude Code sessions", shell_output("#{bin}/cc-session --help")
    assert_match "manage the cron jobs", shell_output("#{bin}/ccron --help")
  end
end
