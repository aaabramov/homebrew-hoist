cask "hoist" do
  version "0.1.1"
  sha256 "7ec2e7ecf753dc9201bfb84c2b797fa1ddc28cf1f2567c1769a0e7e0b6fb56ee"

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
