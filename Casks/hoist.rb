cask "hoist" do
  version "0.1.2"
  sha256 "b457fee81d08719c7b6804bb99714175534eb8f0e9874e2edb323376135d8e4f"

  url "https://github.com/aaabramov/Hoist/releases/download/v#{version}/Hoist.dmg"
  name "Hoist"
  desc "macOS utility that automatically raises and focuses windows on mouse hover"
  homepage "https://github.com/aaabramov/Hoist"

  app "Hoist.app"

  postflight do
    # Clear recursive quarantine flags
    system_command "/usr/bin/xattr", args: ["-rd", "com.apple.quarantine", "#{appdir}/Hoist.app"]
    # Re-sign locally so macOS TCC trusts the app across reboots
    system_command "/usr/bin/codesign", args: ["--force", "--deep", "-s", "-", "#{appdir}/Hoist.app"]
  end

  zap trash: "~/.config/hoist"
end
