//
//  VideoCall.swift
//  
//
//  Created by Ty on 5/28/19.
//

import Foundation

import TwilioVideo

class VideoCall: UIView {

    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var remoteVideoView: TVIVideoView!
    var localVideoView: TVIVideoView!
    
    var camera: TVICameraSource?
    var localVideoTrack: TVILocalVideoTrack?
    var localAudioTrack: TVILocalAudioTrack?
    
    var remoteParticipant: TVIRemoteParticipant?
    
    var token: String = ""
    var room: TVIRoom?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
}
extension VideoCall {
    func commonInit(){
        Bundle.main.loadNibNamed("VideoCall", owner: self, options: nil);
        
        self.addSubview(contentView)
        contentView.fixInView(self)
        localVideoView = TVIVideoView.init(frame: CGRect(x: 30, y: 3, width: 120, height: 250))
        remoteVideoView.addSubview(localVideoView)
        
        prepareLocalMedia()
    }
}

extension VideoCall {
    
    func prepareLocalMedia() {
        
        // We will share local audio and video when we connect to the Room.
        // Create an audio track.
        if (localAudioTrack == nil) {
            localAudioTrack = TVILocalAudioTrack.init(options: nil, enabled: true, name: "Microphone")
            
            if (localAudioTrack == nil) {
                
            }
        }
        
        // Create a video track which captures from the camera.
        if (localVideoTrack == nil) {
            self.startPreview()
        }
    }
    
    func startPreview(){
        
        let cameraOptions = TVICameraSourceOptions { (builder) in
        
        }
        let frontCamera = TVICameraSource.captureDevice(for: .front)
        let backCamera = TVICameraSource.captureDevice(for: .back)
        
        // Create a video track with the capturer.
        if let camera = TVICameraSource(options: cameraOptions, delegate: self) {
            localVideoTrack = TVILocalVideoTrack.init(source: camera)

            camera.startCapture(with: frontCamera ?? backCamera!) { (captureDevice, videoFormat, error) in
                if error != nil {
                 
                } else {
                    self.localVideoTrack?.addRenderer(self.localVideoView)
                    self.localVideoView.shouldMirror = (captureDevice.position == .front)
                    self.fetchToken()
                }
            }
        }
        
    }
    
}

extension VideoCall: TVICameraSourceDelegate {
    func cameraSource(_ source: TVICameraSource, didFailWithError error: Error) {
        logMessage(messageText: "Camera source failed with error: \(error.localizedDescription)")
    }

}

extension VideoCall : TVIVideoViewDelegate {
    func videoView(_ view: TVIVideoView, videoDimensionsDidChange dimensions: CMVideoDimensions) {
//        self.view.setNeedsLayout()
    }
}

extension VideoCall: TVIRoomDelegate {
    func fetchToken() {
        AppTwilioChatClient.shared.fetchAccessToken { (token) in
            self.token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzZjYjViMmM4YjM1NDNhNzU2NGZmMjEwMGI0ZjU5NTQ5LTE1NTkwMzk5NTIiLCJpc3MiOiJTSzZjYjViMmM4YjM1NDNhNzU2NGZmMjEwMGI0ZjU5NTQ5Iiwic3ViIjoiQUM2MWQxODYxM2NmMjY2ZDM2NzM1Yzk4YmY4ZGFiNTgwYiIsImV4cCI6MTU1OTA0MzU1MiwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiNjAiLCJ2aWRlbyI6eyJyb29tIjoiVGVzdFN3aWZ0In19fQ._rQImGhN70An3R4b-Wxt_8By1FqVctRv9-79Veg_OaY";
            self.connect()
        }
    }
    func logMessage(messageText: String) {
        NSLog(messageText)
    }
    
    func connect() {
        
        
        
        let option = TVIConnectOptions.init(token: token) { (builder) in
            builder.roomName = "TestSwift"
            builder.videoTracks = [self.localVideoTrack] as! [TVILocalVideoTrack]
            builder.audioTracks = [self.localAudioTrack] as! [TVILocalAudioTrack]
            
            
        }
        
        room = TwilioVideo.connect(with: option, delegate: self)
    }
    
    func didConnect(to room: TVIRoom) {
        
        // At the moment, this example only supports rendering one Participant at a time.
        
        logMessage(messageText: "Connected to room \(room.name) as \(String(describing: room.localParticipant?.identity))")
        
        if (room.remoteParticipants.count > 0) {
            self.remoteParticipant = room.remoteParticipants[0]
            self.remoteParticipant?.delegate = self
        }
    }
    
    func room(_ room: TVIRoom, didDisconnectWithError error: Error?) {
        logMessage(messageText: "Disconnected from room \(room.name), error = \(String(describing: error))")
        
//        self.cleanupRemoteParticipant()
        self.room = nil
        
//        self.showRoomUI(inRoom: false)
    }
    
    func room(_ room: TVIRoom, didFailToConnectWithError error: Error) {
       print(error)
        self.room = nil
        
//        self.showRoomUI(inRoom: false)
    }
    
    func room(_ room: TVIRoom, isReconnectingWithError error: Error) {
        logMessage(messageText: "Reconnecting to room \(room.name), error = \(String(describing: error))")
    }
    
    func didReconnect(to room: TVIRoom) {
        logMessage(messageText: "Reconnected to room \(room.name)")
    }
    
    func room(_ room: TVIRoom, participantDidConnect participant: TVIRemoteParticipant) {
        if (self.remoteParticipant == nil) {
            self.remoteParticipant = participant
            self.remoteParticipant?.delegate = self
        }
        logMessage(messageText: "Participant \(participant.identity) connected with \(participant.remoteAudioTracks.count) audio and \(participant.remoteVideoTracks.count) video tracks")
    }
    
    func room(_ room: TVIRoom, participantDidDisconnect participant: TVIRemoteParticipant) {
//        if (self.remoteParticipant == participant) {
//            cleanupRemoteParticipant()
//        }
        logMessage(messageText: "Room \(room.name), Participant \(participant.identity) disconnected")
    }
}
extension VideoCall : TVIRemoteParticipantDelegate {
    
    func remoteParticipant(_ participant: TVIRemoteParticipant,
                           publishedVideoTrack publication: TVIRemoteVideoTrackPublication) {
        
        // Remote Participant has offered to share the video Track.
        
        logMessage(messageText: "Participant \(participant.identity) published \(publication.trackName) video track")
    }
    
    func remoteParticipant(_ participant: TVIRemoteParticipant,
                           unpublishedVideoTrack publication: TVIRemoteVideoTrackPublication) {
        
        // Remote Participant has stopped sharing the video Track.
        logMessage(messageText: "Participant \(participant.identity) unpublished \(publication.trackName) video track")
    }
    
    func remoteParticipant(_ participant: TVIRemoteParticipant,
                           publishedAudioTrack publication: TVIRemoteAudioTrackPublication) {
        
        // Remote Participant has offered to share the audio Track.
        logMessage(messageText: "Participant \(participant.identity) published \(publication.trackName) audio track")
    }
    
    func remoteParticipant(_ participant: TVIRemoteParticipant,
                           unpublishedAudioTrack publication: TVIRemoteAudioTrackPublication) {
        
        // Remote Participant has stopped sharing the audio Track.
        logMessage(messageText: "Participant \(participant.identity) unpublished \(publication.trackName) audio track")
    }
    
    func subscribed(to videoTrack: TVIRemoteVideoTrack,
                    publication: TVIRemoteVideoTrackPublication,
                    for participant: TVIRemoteParticipant) {
        
        // We are subscribed to the remote Participant's video Track. We will start receiving the
        // remote Participant's video frames now.
        
        logMessage(messageText: "Subscribed to \(publication.trackName) video track for Participant \(participant.identity)")
        
        if (self.remoteParticipant == participant) {
            videoTrack.addRenderer(self.remoteVideoView!)
        }
    }
    
    func unsubscribed(from videoTrack: TVIRemoteVideoTrack,
                      publication: TVIRemoteVideoTrackPublication,
                      for participant: TVIRemoteParticipant) {
        
        // We are unsubscribed from the remote Participant's video Track. We will no longer receive the
        // remote Participant's video.
        
        logMessage(messageText: "Unsubscribed from \(publication.trackName) video track for Participant \(participant.identity)")
        
        if (self.remoteParticipant == participant) {
            videoTrack.removeRenderer(self.remoteVideoView!)

        }
    }
    
    func subscribed(to audioTrack: TVIRemoteAudioTrack,
                    publication: TVIRemoteAudioTrackPublication,
                    for participant: TVIRemoteParticipant) {
        
        // We are subscribed to the remote Participant's audio Track. We will start receiving the
        // remote Participant's audio now.
        
        logMessage(messageText: "Subscribed to \(publication.trackName) audio track for Participant \(participant.identity)")
    }
    
    func unsubscribed(from audioTrack: TVIRemoteAudioTrack,
                      publication: TVIRemoteAudioTrackPublication,
                      for participant: TVIRemoteParticipant) {
        
        // We are unsubscribed from the remote Participant's audio Track. We will no longer receive the
        // remote Participant's audio.
        
        logMessage(messageText: "Unsubscribed from \(publication.trackName) audio track for Participant \(participant.identity)")
    }
    
    func remoteParticipant(_ participant: TVIRemoteParticipant,
                           enabledVideoTrack publication: TVIRemoteVideoTrackPublication) {
        logMessage(messageText: "Participant \(participant.identity) enabled \(publication.trackName) video track")
    }
    
    func remoteParticipant(_ participant: TVIRemoteParticipant,
                           disabledVideoTrack publication: TVIRemoteVideoTrackPublication) {
        logMessage(messageText: "Participant \(participant.identity) disabled \(publication.trackName) video track")
    }
    
    func remoteParticipant(_ participant: TVIRemoteParticipant,
                           enabledAudioTrack publication: TVIRemoteAudioTrackPublication) {
        logMessage(messageText: "Participant \(participant.identity) enabled \(publication.trackName) audio track")
    }
    
    func remoteParticipant(_ participant: TVIRemoteParticipant,
                           disabledAudioTrack publication: TVIRemoteAudioTrackPublication) {
        logMessage(messageText: "Participant \(participant.identity) disabled \(publication.trackName) audio track")
    }
    
    func failedToSubscribe(toAudioTrack publication: TVIRemoteAudioTrackPublication,
                           error: Error,
                           for participant: TVIRemoteParticipant) {
        logMessage(messageText: "FailedToSubscribe \(publication.trackName) audio track, error = \(String(describing: error))")
    }
    
    func failedToSubscribe(toVideoTrack publication: TVIRemoteVideoTrackPublication,
                           error: Error,
                           for participant: TVIRemoteParticipant) {
        logMessage(messageText: "FailedToSubscribe \(publication.trackName) video track, error = \(String(describing: error))")
    }
}
