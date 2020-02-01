FROM haskell as builder

RUN apt-get update && apt-get install --yes xz-utils make upx

COPY ./servius .

RUN stack setup && stack install && stack build

RUN strip /root/.local/bin/servius && \
    upx --ultra-brute -qq /root/.local/bin/servius && \
    upx -t /root/.local/bin/servius

FROM fpco/haskell-scratch:integer-gmp

COPY --from=builder /root/.local/bin/servius /bin/

ENTRYPOINT ["/bin/servius"]

