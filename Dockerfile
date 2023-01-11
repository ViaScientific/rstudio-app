FROM rocker/rstudio:4.2.2
LABEL author="alper.kucukural@umassmed.edu" description="Docker image containing all requirements for the dolphinnext/rstudio-app "

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && \
    apt-get install -y vim wget bzip2 ca-certificates curl git \
    libtbb-dev gcc g++ libcairo2-dev pandoc \
    libcurl4-openssl-dev libssl-dev libxml2-dev \              
    texlive-base texlive-latex-base texlive-fonts-recommended \
    libfontconfig1-dev libcairo2-dev libhdf5-dev

RUN echo "www-root-path=$WWW_ROOT_PATH" >> /etc/rstudio/rserver.conf

COPY install_packages.R /
RUN Rscript /install_packages.R
