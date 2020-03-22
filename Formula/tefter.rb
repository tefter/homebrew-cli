# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Tefter < Formula
  desc "The command-line client for Tefter"
  homepage "https://tefter.io"
  url "https://github.com/tefter/cli/archive/v0.2.0.tar.gz"
  sha256 "b2d429236c78eb9c476f7e7074bb86d8bf4385b8b1ba57c75c0b3c1192317654"
  depends_on "elixir" => "1.9"
  depends_on "erlang" => "21.3.2"

  def install
    ENV['MIX_ENV'] = 'prod'

    system "mix", "local.hex", "--force"
    system "mix", "local.rebar", "--force"
    system "mix", "deps.get"
    system "mix", "release", "--overwrite"

    File.write "tefter", <<~EOF
    #!/bin/sh

    cd #{bin}/prod/rel/tefter_cli/bin

    ./tefter_cli start
    EOF

    bin.install "_build/prod"
    bin.install "tefter"
  end

  test do
    system "false"
  end
end

