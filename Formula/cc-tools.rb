class CcTools < Formula
  desc "Claude Code sessions, remote access, schedules, and conversation handoffs"
  homepage "https://github.com/caezium/cc-tools"
  url "https://github.com/caezium/cc-tools/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "0ea0c5fbfb7645755e7658e64624a549a8f9b38169ff37241a11da93fa16835c"
  license "MIT"

  depends_on "tmux" # cc-session runs the Claude TUI inside tmux
  depends_on "python@3.15"

  def install
    libexec.install "bin", "lib"
    %w[ccron cc-threads].each do |name|
      inreplace libexec/"bin"/name, "#!/usr/bin/env python3",
        "#!#{Formula["python@3.15"].opt_bin}/python3.15"
    end
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    assert_match "cc-session", shell_output("#{bin}/cc-session --help")
    assert_match "ccron", shell_output("#{bin}/ccron --help")
    assert_match "cc-threads", shell_output("#{bin}/cc-tools list")
    assert_match "cc-threads", shell_output("#{bin}/cc-tools threads --help")
    assert_path_exists libexec/"lib/cc_threads/web/index.html"
  end
end
