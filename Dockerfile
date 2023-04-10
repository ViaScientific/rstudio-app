FROM openanalytics/shinyproxy-rstudio-ide-demo:2021.09.2_382__4.1.2
LABEL author="alper@viascientific.com" description="Docker image containing all requirements for the Via Scientific DESeq analysis module and RStudio"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && \
    apt-get install -y vim wget bzip2 ca-certificates curl git \
    libtbb-dev gcc g++ libcairo2-dev pandoc cargo libglpk-dev \
    libcurl4-openssl-dev libssl-dev libxml2-dev cmake \              
    texlive-base texlive-latex-base texlive-fonts-recommended \
    libfontconfig1-dev libcairo2-dev libhdf5-dev libmagick++-dev \
    libharfbuzz-dev libfribidi-dev
RUN apt install -y --no-install-recommends software-properties-common dirmngr
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
RUN apt install -y r-base r-base-core r-recommended r-base-dev
RUN cp /usr/bin/R* /usr/local/bin/. 

RUN R -e "install.packages(c('BiocManager', 'devtools', 'knitr', 'rmarkdown', 'markdown', 'curl', 'httr', 'tidyverse', 'ggrepel', 'ggbeeswarm', 'pheatmap', 'scales', 'Rcurl', 'DT'))"
RUN R -e "BiocManager::install(version = '3.16')"
RUN R -e "BiocManager::install(c('DESeq2', 'debrowser'))"



