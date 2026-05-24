cask "talkmode" do
  version "0.4.16"
  # Run `bash scripts/release.sh` and paste the printed SHA256 here on every version bump.
  sha256 "7eb01ac7bf90cd9148825711b6989dc764ef708514618252f5dd1c566ef9060d"

  url "https://talkmode.baryon.ai/download/TalkMode-#{version}.zip"
  name "TalkMode"
  desc "Korean-friendly real-time voice assistant for macOS (multimodal endpointing)"
  homepage "https://talkmode.baryon.ai"

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  # 앱이 Sparkle 로 자체 업데이트 처리. Homebrew 는 Cask 버전 차이를 자동 갱신 사유로
  # 보지 않고, 사용자에게 brew upgrade 강요도 하지 않는다.
  auto_updates true

  app "TalkMode.app"

  # `brew uninstall --zap` removes user data + cached models / recordings under ~/.talk_mode_mac/
  zap trash: [
    "~/.talk_mode_mac",
    "~/Library/Preferences/app.talkmode.mac.plist",
    "~/Library/Application Support/app.talkmode.mac",
    "~/Library/Caches/app.talkmode.mac",
    "~/Library/Saved Application State/app.talkmode.mac.savedState",
  ]

  caveats <<~EOS
    TalkMode needs the following macOS permissions on first launch:
      • Microphone, Speech Recognition  (always)
      • Camera                          (only if you turn on gaze tracking)
      • Input Monitoring                (only if you use right-Option to stop TTS)
      • Calendars (Full Access)         (only if you use the calendar skills)
      • Full Disk Access                (only if you use the messages.list_recent skill)

    Open System Settings → Privacy & Security and grant each as needed.
  EOS
end
