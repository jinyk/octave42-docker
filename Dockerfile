# A Dockerfile to build Octave 4.2 from source and access it VNC

FROM phusion/baseimage:0.9.19

MAINTAINER Jinyoung Kim <jinyoungkim@gmail.com>

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get -y install \
	xvfb \
	x11vnc \
	supervisor \
	fluxbox \
	git-core \
	git \
  firefox \
  wget \
  gcc \
  g++ \
  gfortran \
  make \
  libblas-dev \
  liblapack-dev \
  libpcre3-dev \
  libarpack2-dev \
  libcurl4-gnutls-dev \
  epstool \
  libfftw3-dev \
  transfig \
  libfltk1.3-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libgl2ps-dev \
  libglpk-dev \
  libreadline-dev \
  gnuplot \
  libgraphicsmagick++1-dev \
  libhdf5-serial-dev \
  openjdk-8-jdk \
  libsndfile1-dev \
  llvm-dev \
  lpr \
  texinfo \
  libglu1-mesa-dev \
  pstoedit \
  libjack0 \
  libjack-dev \
  portaudio19-dev \
  libqhull-dev \
  libqrupdate-dev \
  libqscintilla2-dev \
  libqt4-dev \
  libqtcore4 \
  libqtwebkit4 \
  libqt4-network \
  libqtgui4 \
  libsuitesparse-dev \
  zlib1g-dev \
  libxft-dev \
  autoconf \
  automake \
  bison \
  flex \
  gperf \
  gzip \
  librsvg2-bin \
  icoutils \
  libtool \
  perl \
  rsync \
  tar \
  libosmesa6-dev \
  libqt4-opengl-dev

RUN apt-get autoclean

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV DISPLAY :0

# Change work directory to build Octave 4.2 from source
WORKDIR /tmp

RUN wget https://ftp.gnu.org/gnu/octave/octave-4.2.0.tar.gz \
  tar -xvf octave-4.2.0.tar.gz \
  rm octave-4.2.0.tar.gz \
  cd octave-4.2.0 \
  /tmp/octave-4.2.0/configure \
  make -j4 \
  make install \
  rm -rf /tmp/*

WORKDIR /src

# Can be configured to set octave settings
# COPY qt-settings /root/.config/octave/qt-settings

EXPOSE 5900

CMD ["/usr/bin/supervisord"]
