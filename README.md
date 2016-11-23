# Dockerfile for building Octave 4.2 from source

## Why?

Octave 4.2 just came out and it's not available as a published package. :(
Maybe it is now, check out https://launchpad.net/~octave/+archive/ubuntu/stable

## Stole some code from

- https://hub.docker.com/r/epflsti/octave-x11-novnc-docker/
- http://www.schoeps.org/home/2015/06/five-simple-instructions-to-compile-octave-4-on-ubuntu/

## Run

Note: might wanna configure supervisord.conf to set the size of the screen
you want.

1. `docker build jinyk/octave .`
2. `docker run -v /yourlocal/src:/src -p 5900:5900 jinyk/octave`
3. vnc into localhost:5900
4. open terminal and run `octave`
