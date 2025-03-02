
```sh
docker run --rm -it -p 8080:80 -v "$(pwd)/index.html:/usr/share/nginx/html/index.html:ro" -v "$(pwd)/nginx.conf:/etc/nginx/nginx.conf" nginx
# or on Windows:
docker run --rm -it -p 8080:80 -v "$(pwd -W)/index.html:/usr/share/nginx/html/index.html:ro" -v "$(pwd -W)/nginx.conf:/etc/nginx/nginx.conf" nginx
```

Sample query:

```
Write a hello-world HTTP server in TypeScript for Node.js
```
