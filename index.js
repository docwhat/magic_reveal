/* Generated at 2014-03-04 23:10:27 -0500 */
var config = {
  controls: true,
  progress: true,
  history: true,
  overview: true,
  center: true,
  theme: "sky",
  transition: "default",
  github: "docwhat/magic_reveal",
  plugins: ["highlight","notes","zoom"],
"dependencies": [
{ src: "lib/js/classList.js", condition: function() { return !document.body.classList; } },
{ src: "plugin/highlight/highlight.js", async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
{ src: "plugin/zoom-js/zoom.js", async: true, condition: function() { return !!document.body.classList; } },
{ src: "plugin/notes/notes.js", async: true, condition: function() { return !!document.body.classList; } }
]

};
Reveal.initialize(config);