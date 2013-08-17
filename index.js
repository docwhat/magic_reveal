/* Generated at 2013-08-17 13:24:17 -0400 */
var config = {
  controls: true,
  progress: true,
  history: true,
  overview: true,
  center: true,
  theme: "sky",
  transition: "default",
  plugins: ["highlight","notes","zoom"],
"dependencies": [
{ src: "lib/js/classList.js", condition: function() { return !document.body.classList; } },
{ src: "plugin/highlight/highlight.js", async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
{ src: "plugin/zoom-js/zoom.js", async: true, condition: function() { return !!document.body.classList; } },
{ src: "plugin/notes/notes.js", async: true, condition: function() { return !!document.body.classList; } }
]

};
Reveal.initialize(config);