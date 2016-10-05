FROM manacc/geant4:latest

RUN mkdir /var/tmp/builds
WORKDIR /var/tmp/builds

# Get the dependencies we can from the package manager
RUN apt install -y git dpkg-dev binutils libxpm-dev libxft-dev libxext-dev
RUN apt install -y bison flex python zlibc && mkdir clhep
WORKDIR /var/tmp/builds/clhep
RUN wget http://proj-clhep.web.cern.ch/proj-clhep/DISTRIBUTION/tarFiles/clhep-2.1.3.1.tgz
RUN tar -xzf clhep-2.1.3.1.tgz && mkdir build
WORKDIR /var/tmp/builds/clhep/build
RUN cmake ../2.1.3.1/CLHEP && make -j5 && make install

WORKDIR /var/tmp/builds
RUN mkdir root
WORKDIR /var/tmp/builds/root
RUN wget https://root.cern.ch/download/root_v6.06.08.source.tar.gz && tar -xzf root_v6.06.08.source.tar.gz
WORKDIR /var/tmp/builds/root/root-6.06.08/

RUN ./configure --minimal --disable-python #&& sed -i 's/fchmod(int, int)/fchmod(int, mode_t)/' build/rmkdepend/main.c
RUN make && make install



#RUN mkdir bdsim
#WORKDIR /var/tmp/builds/bdsim
#RUN git clone --recursive https://bitbucket.org/jairhul/bdsim
#RUN mkdir build
#WORKDIR /var/tmp/builds/bdsim/build
#RUN cmake ../bdsim && make -j5 && make install
#WORKDIR /
#RUN rm -rf /var/tmp/builds

ENTRYPOINT /bin/bash
