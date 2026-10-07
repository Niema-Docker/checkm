# Minimal Docker image for CheckM using Alpine base
FROM alpine:latest

# install CheckM
RUN apk update && \
    apk add --no-cache bash gcc make musl-dev py3-pip python3 unzip zlib-dev && \

    # install HMMER
    wget -qO- "http://eddylab.org/software/hmmer/hmmer-3.4.tar.gz" | tar -zx && \
    cd hmmer-* && \
    ./configure && \
    make && \
    make install && \
    cd .. && \

    # install Prodigal
    wget -qO- "https://github.com/hyattpd/Prodigal/archive/refs/tags/v2.6.3.tar.gz" | tar -zx && \
    cd Prodigal-* && \
    make && \
    make install && \
    cd .. && \

    # install pplacer
    wget "https://github.com/matsen/pplacer/releases/download/v1.1.alpha23/pplacer-linux-x86_64.zip" && \
    unzip pplacer-*.zip && \
    for f in *.exe ; do mv "$f" /usr/local/bin/"${f%.*}" ; done && \

    # install CheckM
    pip install --no-cache-dir --break-system-packages checkm-genome && \

    # clean up
    rm -rf hmmer-* pplacer-*.zip Prodigal-* scripts
