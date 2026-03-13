cask "hoist" do
  version "6.0.0"
  sha256 "caebb226babe2679060b6da3eff637bccf202cc078579674fc70d1a1c0c9d413"

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
