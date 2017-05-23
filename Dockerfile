FROM alpine:edge
MAINTAINER John Montero <jmonteroc@gmail.com>
RUN apk --no-cache add -U musl musl-dev make gcc git erlang erlang-crypto erlang-syntax-tools \
          erlang-inets erlang-ssl erlang-public-key erlang-asn1 erlang-sasl \
          erlang-erl-interface erlang-dev erlang-parsetools erlang-eunit erlang-tools erlang-xmerl elixir

RUN apk --no-cache add -U nodejs inotify-tools \
    && mix local.hex --force \
    && mix local.rebar --force \
    && mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

RUN apk --no-cache add -U musl musl-dev ncurses-libs
RUN apk add --update nodejs nodejs-npm && npm install npm@latest -g
