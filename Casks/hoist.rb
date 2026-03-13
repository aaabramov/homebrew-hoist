cask "hoist" do
  version "6.0.2"
  sha256 "efacb59097bd9f60292390f4cdc66b5d9dbe8c6b11e9d59ebd0af2555c408f96"

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
