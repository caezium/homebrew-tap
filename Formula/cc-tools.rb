class CcTools < Formula
  desc "Power-user CLI tools for Claude Code: cc-session + ccron"
  homepage "https://github.com/caezium/cc-tools"
  url "https://github.com/caezium/cc-tools/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "9aefd9f36bcebed910e38ef56cbf61636c7f268b761ed7ba5991e38ac469c357"
  license "MIT"

  depends_on "tmux" # cc-session runs the Claude TUI inside tmux
  # ccron is pure-stdlib Python 3 (preinstalled on macOS)

  def install
    bin.install "bin/cc-session"
    bin.install "bin/ccron"
  end

  test do
    assert_match "persistent Claude Code sessions", shell_output("#{bin}/cc-session --help")
    assert_match "manage the cron jobs", shell_output("#{bin}/ccron --help")
  end
end
