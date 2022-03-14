FROM registry.gitlab.com/fdroid/ci-images-base

COPY signing-key.asc /

RUN gpg --import /signing-key.asc

RUN python3 -m pip install --upgrade pip wheel setuptools \
    && python3 -m pip install git+https://gitlab.com/fdroid/fdroidserver.git

# Install additional utilities required by actual builds (list subject to future expansion)
# build-tools 32.0.0 is needed for a good apksigner
RUN apt-get update && apt-get install --yes \
		patch \
		autoconf libtool pkg-config \
		gradle ant \
	&& echo y | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;32.0.0" \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*


VOLUME ["/repo"]
WORKDIR /repo

ENTRYPOINT ["/usr/local/bin/fdroid"]
CMD ["--help"]

