class CcTools < Formula
  desc "Power-user CLI tools for Claude Code: cc-session + ccron"
  homepage "https://github.com/caezium/cc-tools"
  url "https://github.com/caezium/cc-tools/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "25d5b54230b0c5425a39e1dfb4ce481f496d288987a106ceca85c8fbfa01ee8a"
  license "MIT"

  depends_on "tmux" # cc-session runs the Claude TUI inside tmux
  # ccron is pure-stdlib Python 3 (preinstalled on macOS)

  def install
    bin.install "bin/cc-tools"
    bin.install "bin/cc-session"
    bin.install "bin/cc-remote"
    bin.install "bin/ccron"
  end

  test do
    assert_match "persistent Claude Code sessions", shell_output("#{bin}/cc-session --help")
    assert_match "manage the cron jobs", shell_output("#{bin}/ccron --help")
  end
end
