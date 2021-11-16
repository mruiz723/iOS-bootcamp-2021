import Foundation

class Player<Item> {

    private let notificationCenter: NotificationCenter

    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }

    /// update
    private var state = State.idle {
        // We add a property observer on 'state', which lets us
        // run a function on each value change.
        didSet {
            stateDidChange()
        }
    }

    func play(_ item: Item) {
        state = .playing(item)
        // startPlayback(with: item)
    }

    func pause() {
        switch state {
        case .idle:
            // Calling pause when we're not in a playing state
            // could be considered a programming error, but since
            // it doesn't do any harm, we simply break here.
            break
        case .playing(let item), .paused(let item):
            state = .paused(item)
            // pausePlayback()
        }
    }

    func stop() {
        state = .idle
        // stopPlayback()
    }

    /// notify
    func stateDidChange() {
        switch state {
        case .idle:
            notificationCenter.post(name: .playbackStopped, object: nil)
        case .playing(let item):
            notificationCenter.post(name: .playbackStarted, object: item)
        case .paused(let item):
            notificationCenter.post(name: .playbackPaused, object: item)
        }
        
    }
}

private extension Player {
    enum State {
        case idle
        case playing(Item)
        case paused(Item)
    }
}

extension Notification.Name {
    static var playbackStarted: Notification.Name {
        return .init(rawValue: "Player.playbackStarted")
    }

    static var playbackPaused: Notification.Name {
        return .init(rawValue: "Player.playbackPaused")
    }

    static var playbackStopped: Notification.Name {
        return .init(rawValue: "Player.playbackStopped")
    }
}

class NowPlaying {

    let notificationCenter: NotificationCenter

    init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
        notificationCenter.addObserver(self, selector: #selector(playerDidNotify), name: .playbackPaused, object: nil)
        notificationCenter.addObserver(self, selector: #selector(playerDidNotify), name: .playbackStarted, object: nil)
        notificationCenter.addObserver(self, selector: #selector(playerDidNotify), name: .playbackStopped, object: nil)
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    @objc private func playerDidNotify(_ notification: Notification) {
        print("notification: ", notification.name.rawValue)

        if let item = notification.object {
            print("- with item: ", item)
        }
    }

}

extension NowPlaying {


}

let nowPlaying = NowPlaying(notificationCenter: .default)
let player = Player<Any>()

player.play("Despacito 4")
player.pause()
player.stop()
