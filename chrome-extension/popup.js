function listenClick() {
  const button = document.getElementById('send-data');
  const horoscope = document.getElementById('horoscope');
  button.addEventListener('click', () => {
    // chrome.tabs.executeScript({
    //   file: 'scripts/send-data.js'
    // });
    fetch('https://thingproxy.freeboard.io/fetch/https://seer-io.herokuapp.com/horoscopes/show.json')
    // http://localhost:3000/horoscopes/show.json for local testing
    // change to https://seer-io.herokuapp.com/horoscopes/show.json for heroku
      .then(res => res.json())
      .then(data => {
        horoscope.innerText = data.horoscope
        button.remove();
        document.getElementsByTagName('h1')[0].style.display = 'none';
        document.getElementsByTagName('img')[0].style.display = 'none';
      })
    })
}
listenClick();
