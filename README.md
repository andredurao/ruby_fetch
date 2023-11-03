# ruby_fetch
A simple ruby http fetch script

How to run:
`./fetch https://example.com`
or
`./fetch --metadata https://example.com`


## Using docker

docker build:

```
docker build -t my-ruby-app .
```

docker run:
```
docker run -it --rm -v $(pwd):/usr/src/app my-ruby-app https://google.com
or
docker run -it --rm -v $(pwd):/usr/src/app my-ruby-app --metadata https://google.com
```

