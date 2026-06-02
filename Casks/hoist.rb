cask "hoist" do
  version "0.1.3"
  sha256 "09b3945e5f9ff50b5998f0dba8298f6297134f9513a5bf88c2e747318269db8b"

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
