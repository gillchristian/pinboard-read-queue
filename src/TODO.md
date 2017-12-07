## TODO

- v1: MVP
  - Finish persist to local storage
  - Allow to remove checked items
  - Copy links
- v2: add BE
  - Allow to create users
  - Connect with & export to: Pinboard, Pocket
  - Scrape website & get title
  
  
New window with export

```js
 // javascript:

q = location.href;

if (document.getSelection){
  d = document.getSelection();
} else { d=''; };

p = document.title;

const url = 
  `https://pinboard.in/add?showtags=yes&url=${encodeURIComponent(q)}` + 
  `&description=${encodeURIComponent(d)}` + 
  `&title=${encodeURIComponent(p)}`

void(open(url, 'Pinboard','toolbar=no,scrollbars=yes,width=750,height=700'));
```