# Dockerfile for tetrad
# https://github.com/eaton-lab/tetrad

FROM continuumio/miniconda3:4.9.2

MAINTAINER Joel Nitta joelnitta@gmail.com

# Build tetrad conda environment
RUN conda update --name base --channel defaults conda && \
    conda create -n tetrad -c eaton-lab -c conda-forge tetrad=0.9.13 && \
    conda clean --all --yes
    
# Make wrapper script for tetrad
ENV TOOLNAME tetrad
RUN echo '#!/bin/bash' >> /usr/local/bin/$TOOLNAME && \
  echo "source /opt/conda/etc/profile.d/conda.sh" >> /usr/local/bin/$TOOLNAME && \
  echo "conda activate tetrad" >> /usr/local/bin/$TOOLNAME  && \
  echo "$TOOLNAME \"\$@\"" >> /usr/local/bin/$TOOLNAME  && \
  chmod 755 /usr/local/bin/$TOOLNAME
  
CMD ["tetrad"]
