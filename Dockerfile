FROM rocker/rstudio:4.0.5
# NB: this file is only used by rocker if the env var DISABLE_AUTH: true is specified in the application.yml
RUN echo "www-frame-origin=same" >> /etc/rstudio/disable_auth_rserver.conf
RUN echo "www-verify-user-agent=0" >> /etc/rstudio/disable_auth_rserver.conf

ADD userconf.sh /rocker_scripts/userconf.sh
ADD userconf.sh /etc/cont-init.d/userconf

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

#RUN apt-get update --fix-missing && \
#    apt-get install -y vim wget bzip2 ca-certificates curl git \
#    libtbb-dev gcc g++ libcairo2-dev pandoc cargo \
#    libcurl4-openssl-dev libssl-dev libxml2-dev cmake \              
#    texlive-base texlive-latex-base texlive-fonts-recommended \
#    libfontconfig1-dev libcairo2-dev libhdf5-dev libmagick++-dev

RUN R -e "install.packages(c('knitr', 'rmarkdown', 'curl', 'httr'))"
RUN R -e "install.packages('Seurat')"
RUN R -e "install.packages(c('anndata', 'xml2', 'tidyverse', 'dplyr', 'Matrix', 'scales', 'RCurl', 'svglite', 'patchwork', 'readr', 'ggpubr', 'DT', 'remotes'))"
RUN R -e "install.packages('BiocManager')"
RUN R -e 'BiocManager::install("debrowser")' 
RUN R -e 'BiocManager::install(c("SingleCellExperiment", "zellkonverter", "limma", "UCell", "scuttle", "SingleR", "celldex"))'
RUN R -e "install.packages('devtools')"
RUN R -e 'devtools::install_github("mojaveazure/seurat-disk", upgrade = "always")'
RUN R -e 'devtools::install_github("umms-biocore/markdownapp")'
RUN R -e 'remotes::install_github("chris-mcginnis-ucsf/DoubletFinder", upgrade = F)'
