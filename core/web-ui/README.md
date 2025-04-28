# Ollama Web UI

This web app is a simple™️ 100-ish line vanilla HTML file that provides
ChatGPT-esque chat capability with ollama.

This component is **optional**,
but it provides a more similar feel for developers used to ChatGPT and the like.

The intention of the web application is that you should be able to inspect/review
the entirety of the code pretty quickly to validate that there isn't
some kind of backdoor or other malicious code trying to run in the browser.

If you don't trust the third party libraries at the top,
you can just remove them as well, and the app should still function
(though less pretty).
The web app will continue to work (e.g. in a disconnected environment)
even if these links cannot be reached.
