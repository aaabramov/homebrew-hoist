cask "hoist" do
  version "0.1.4"
  sha256 "ddf0cf3c0a713cc03e5ae8a54d15f5a6b7e226b4f4febffe5e1a3a94b9d05759"

  url "https://github.com/aaabramov/Hoist/releases/download/v#{version}/Hoist.dmg"
  name "Hoist"
  desc "Utility that automatically raises and focuses windows on mouse hover"
  homepage "https://github.com/aaabramov/Hoist"

  depends_on :macos

  app "Hoist.app"

  postflight do
    # Clear recursive quarantine flags
    system_command "/usr/bin/xattr", args: ["-rd", "com.apple.quarantine", "#{appdir}/Hoist.app"]

    # Re-sign locally with a stable identifier so the ad-hoc signature keeps a
    # consistent bundle identity (matches the CI release signing).
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--identifier", "com.iamandrii.hoist", "-s", "-",
                          "#{appdir}/Hoist.app"]

    # An ad-hoc signature is pinned to the binary's cdhash, which changes every
    # release. macOS keeps the old (now-mismatched) Accessibility grant, so the
    # app silently can't control windows AND no permission prompt appears.
    # Reset it so the next launch shows a clean prompt and re-grants correctly.
    system_command "/usr/bin/tccutil",
                   args:         ["reset", "Accessibility", "com.iamandrii.hoist"],
                   must_succeed: false
  end

  zap trash: "~/.config/hoist"

  caveats <<~EOS
    Hoist needs Accessibility permission to raise and focus windows:
      System Settings → Privacy & Security → Accessibility

    After installing or upgrading, relaunch Hoist and grant it when prompted.
    If Hoist still can't control windows after an upgrade, remove it from the
    Accessibility list (–) and add /Applications/Hoist.app again.
  EOS
end
