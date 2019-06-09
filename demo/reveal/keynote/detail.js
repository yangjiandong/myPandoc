const getQueryObj = () => {
  var obj = {};
  var str = decodeURI(location.search.replace('?', ''));
  var arr = str.split('&');
  arr.forEach(value => {
    let k = value.match(/(.+)=.+|$/)[1];
    let v = decodeURI(value.match(/.+=(.+)|$/)[1]);
    if (k && v) obj[k] = v;
  });
  return obj;
};

document.addEventListener('DOMContentLoaded', () => {
  let node = document.getElementById('stage');
  let queryObj = getQueryObj();
  let path = queryObj['path'];
  document.title = queryObj['title'];
  node.dataset.markdown = path;
  Reveal.initialize({
    slideNumber: true,
    width: "100%", //1366, 960,
    height: "100%", //768,
	  // theme: Reveal.getQueryHash().theme || "sky" ,
	  transition: "concave", // default/cube/page/concave/zoom/linear/fade/none

    // Factor of the display size that should remain empty around the content
    margin: 0.1,

    // Bounds for smallest/largest possible scale to apply to content
    minScale: 0.2,
    maxScale: 1.5,

    history: true,

    dependencies: [
      { src: 'tools/lib/js/classList.js', condition: function() { return !document.body.classList; } },
      { src: 'tools/plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
      { src: 'tools/plugin/markdown/showdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
      { src: 'tools/plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
      { src: 'tools/plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
      { src: 'tools/plugin/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },
      { src: 'tools/plugin/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } }


      // {src: 'tools/plugin/markdown/marked.js'},
      // {src: 'tools/plugin/markdown/markdown.js'},
      // { src: 'tools/plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
      // {src: 'tools/plugin/notes/notes.js'},
      // {src: 'tools/plugin/zoom-js/zoom.js'},
      // // MathJax
      // { src: 'tools/plugin/math/math.js', async: true }
    ]
  });
}, false);
