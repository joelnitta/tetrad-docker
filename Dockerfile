FROM python:3

WORKDIR /usr/src/

# copy patch to fix https://github.com/eaton-lab/tetrad/issues/5
COPY snps-hdf5-patch .

# clone repo, checkout most recent version, apply patch
ENV VERSION 0.9.14

RUN git clone https://github.com/eaton-lab/tetrad && \
  cd tetrad && \
  git fetch --tags && \
  git checkout tags/$VERSION -b patch && \
  cd tetrad && \
  git apply /usr/src/snps-hdf5-patch

# install patched app
RUN cd tetrad && \
  pip install -e .
  
CMD ["tetrad"]
