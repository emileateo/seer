// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
});

// Following code is for twilio video chat

// const { connect } = require('twilio-video');

// connect('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzNjMmMzODYzY2I1M2YwNjMwNTM3NWM0OWY1OGUzODlkLTE2MjE4NDA5NzUiLCJpc3MiOiJTSzNjMmMzODYzY2I1M2YwNjMwNTM3NWM0OWY1OGUzODlkIiwic3ViIjoiQUNlNDM5OWEyNzNjNGNhZjY0ZWYxZjYwMDA0Njg4MGVmMCIsImV4cCI6MTYyMTg0NDU3NSwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiQ29uc3VsdGF0aW9uIiwidmlkZW8iOnt9fX0.XJyRCmGscBLbR7JwZVd2VqsGQ37zMQ4YNttLeJR-fjY', { name:'Consultation' }).then(room => {
//   console.log(`Successfully joined a Room: ${room}`);
//   room.on('participantConnected', participant => {
//     console.log(`A remote Participant connected: ${participant}`);
//   });
// }, error => {
//   console.error(`Unable to connect to Room: ${error.message}`);
// });

