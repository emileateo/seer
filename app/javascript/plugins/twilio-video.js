import { connect } from 'twilio-video';

let roomObj;
const attachTrackToPublication = (publication) => {
  const room = document.querySelector('#twilio-room');

  if (publication.track) {
    room.appendChild(publication.track.attach());
  }

  if (publication.isSubscribed) {
    const track = publication.track;
    room.appendChild(track.attach());
  }
}

const subscribeTrack = (track) => {
  document.querySelector('#twilio-room').appendChild(track.attach());
}

const connectParticipant = (participant) => {
  console.log(`Participant "${participant.identity}" connected`);
  participant.tracks.forEach(attachTrackToPublication);
  participant.on('trackSubscribed', subscribeTrack);
}

const newParticipant = (participant) => {
  participant.tracks.forEach(attachTrackToPublication);
  participant.on('trackSubscribed', subscribeTrack);
}

const handleRoomCreation = (room) => {
  roomObj = room;
  roomObj.on('participantConnected', connectParticipant, error => {
    console.error(`Unable to connect to Room: ${error.message}`);
  });

  roomObj.on('disconnected', room => {
  // Detach the local media elements
    console.log(`Participant "${participant.identity}" disconnected`);
    room.localParticipant.tracks.forEach(publication => {
      const attachedElements = publication.track.detach();
      attachedElements.forEach(element => element.remove());
    });
  });

  roomObj.participants.forEach(newParticipant);
}

const initTwilioVideo = () => {
  const videoContainer = document.querySelector('.video-container');

  if (videoContainer) {
    const { accessToken, roomName } = videoContainer.dataset;

    connect(accessToken, {
      audio: true,
      name: roomName,
      video: { width: 320 }
    }).then(handleRoomCreation);
  }
}

// need to remove participant upon disconnecting

export default initTwilioVideo;

