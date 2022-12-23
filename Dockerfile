#extractor build
FROM ubuntu:rolling

# Set shell to bash instead of dash
RUN export DEBIAN_FRONTEND=noninteractive
RUN echo "dash dash/sh boolean false" | debconf-set-selections && dpkg-reconfigure dash

# Binwalk installation instructions from:
# https://github.com/ReFirmLabs/binwalk/blob/master/INSTALL.md
RUN apt-get update && apt-get install -y --no-install-recommends \
    arj \
    apt-utils \
    binwalk \
    build-essential \
    zip \
    unzip \
    bzip2 \
    cabextract \
    cramfsswap \
    default-jdk \
    git-core \
    gzip \
    lhasa \
    liblzma-dev \
    liblzo2-dev \
    liblzo2-dev \
    lzop \
    mtd-utils \
    p7zip \
    p7zip-full \
    python3 \
    python3-lzo \
    python3-pip \
    sleuthkit \
    squashfs-tools \
    srecord \
    tar \
    wget \
    zlib1g-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    

	COPY . .

# Install sasquatch to extract non-standard SquashFS images
RUN git clone https://github.com/Trickery710/sasquatch /tmp/sasquatch && \
    cd /tmp/sasquatch && \
    ./build.sh && \
    cd / && \
    rm -rf /tmp/sasquatch

# Install jefferson to extract JFFS2 file systems
RUN pip3 install cstruct && \
    git clone https://github.com/Trickery710/jefferson /tmp/jefferson && \
    cd /tmp/jefferson && \
    python3 setup.py install && \
    cd / && \
    rm -rf /tmp/jefferson

# Install ubi_reader to extract UBIFS file systems
RUN git clone https://github.com/Trickery710/ubi_reader /tmp/ubi_reader && \
    cd /tmp/ubi_reader && \
    python3 setup.py install && \
    cd / && \
    rm -rf /tmp/ubi_reader

# Install yaffshiv to extract YAFFS file systems
RUN git clone https://github.com/Trickery710/yaffshiv /tmp/yaffshiv && \
    cd /tmp/yaffshiv && \
    python3 setup.py install && \
    cd / && \
    rm -rf /tmp/yaffshivWORKDIR /root

# Install unstuff (closed source) to extract StuffIt archive files
#/RUN mkdir -p /tmp/unstuff && \
#    cd /tmp/unstuff && \
#    wget -O - https://downloads.tuxfamily.org/sdtraces/stuffit520.611linux-i386.tar.gz | tar -zxv && \
#    install -m 0755 bin/unstuff /usr/local/bin/ && \
#   rm -rf /tmp/unstuff
#
# Workspace volume from host
VOLUME [ "/extract" ]
WORKDIR /extract
COPY . .
# Call binwalk executable with arguments
ENTRYPOINT [ "extract.sh" ]
CMD [ "ls" ]
