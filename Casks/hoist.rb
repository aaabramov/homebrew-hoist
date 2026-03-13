cask "hoist" do
  version "0.1.0"
  sha256 "28208db6d37001cf82834a86f169e2d3028ca059b8f17600afbfc00da5c9acd4"

  url "https://github.com/aaabramov/Hoist/releases/download/v#{version}/Hoist.dmg"
  name "Hoist"
  desc "macOS utility that automatically raises and focuses windows on mouse hover"
  homepage "https://github.com/aaabramov/Hoist"

  app "Hoist.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{appdir}/Hoist.app"]
  end

  zap trash: "~/.config/hoist"
end
