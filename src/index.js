import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

const QUEUE_KEY = "queue";

let app = Main.embed(document.getElementById('root'));

app.ports.saveToStorage.subscribe(function(value) {
  localStorage.setItem(QUEUE_KEY, JSON.stringify(value));
});

app.ports.doLoadFromStorage.subscribe(function() {
  let data = localStorage.getItem(QUEUE_KEY)
  if (data) {
    data = JSON.parse(data)
  }
  app.ports.loadFromStorage.send(data);
});

registerServiceWorker();
