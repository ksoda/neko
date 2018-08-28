FROM ruby:2.5

ARG CRF_FILE_ID=0B4y35FiV1wh7QVR6VXJ5dWExSTQ
ARG CABO_CHA_FILE_ID=0B4y35FiV1wh7SDd1Q1dUQkZQaUU
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    build-essential \
    libmecab-dev \
    mecab \
    mecab-ipadic \
    mecab-ipadic-utf8

RUN set -ex; \
    curl -L -o crf.tar.gz "https://drive.google.com/uc?export=download&id=${CRF_FILE_ID}"; \
    tar xf crf.tar.gz; \
    cd CRF++-*; \
    ./configure; \
    make; \
    make install; \
    ldconfig

RUN set -ex; \
    curl -L -o cabocha.tar.bz2 "https://drive.google.com/uc?export=download&id=${CABO_CHA_FILE_ID}"; \
    tar xf cabocha.tar.bz2; \
    cd cabocha-*; \
    ./configure; \
    make; \
    make check; \
    make install; \
    ldconfig

RUN echo 'dicdir = /var/lib/mecab/dic/ipadic-utf8' >> /etc/mecabrc
RUN echo 'mecabrc = /etc/mecabrc' > $HOME/.cabocharc

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
COPY . .
CMD ['ruby']
