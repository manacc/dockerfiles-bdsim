FROM manacc/geant4:latest

# Get the dependencies we can from the package manager
RUN apt install -y git dpkg-dev binutils libxpm-dev libxft-dev libxext-dev
RUN apt install -y bison flex python zlibc

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 10
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 10
RUN update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-4.9 10

RUN mkdir /var/tmp/builds
WORKDIR /var/tmp/builds

#RUN mkdir root
#WORKDIR /var/tmp/builds/root

#RUN wget https://root.cern.ch/download/root_v6.06.08.source.tar.gz && tar -xzf root_v6.06.08.source.tar.gz

#WORKDIR /var/tmp/builds/root/root-6.06.08/

#RUN ./configure --minimal --disable-python #&& sed -i 's/fchmod(int, int)/fchmod(int, mode_t)/' build/rmkdepend/main.c
#RUN make
#ENV ROOTSYS /var/tmp/builds/root/root-6.06.08

#WORKDIR /var/tmp/builds

RUN mkdir bdsim
WORKDIR /var/tmp/builds/bdsim
RUN git clone --recursive https://bitbucket.org/jairhul/bdsim
WORKDIR /var/tmp/builds/bdsim/bdsim
RUN git checkout v0.8
WORKDIR /var/tmp/builds/bdsim
RUN mkdir build
WORKDIR /var/tmp/builds/bdsim/build
RUN cmake ../bdsim -DUSE_ROOT=OFF 
RUN make -j5 && make install
WORKDIR /
#RUN cp -r /var/tmp/builds/root/root-6.06.08 /usr/local
RUN rm -rf /var/tmp/builds

ENV G4LEVELGAMMADATA=/usr/local/share/Geant4-10.1.1/data/PhotonEvaporation3.1
ENV G4NEUTRONXSDATA=/usr/local/share/Geant4-10.1.1/data/G4NEUTRONXS1.4
ENV G4LEDATA=/usr/local/share/Geant4-10.1.1/data/G4EMLOW6.41
ENV G4NEUTRONHPDATA=/usr/local/share/Geant4-10.1.1/data/G4NDL4.5
ENV G4RADIOACTIVEDATA=/usr/local/share/Geant4-10.1.1/data/RadioactiveDecay4.2
ENV G4ABLADATA=/usr/local/share/Geant4-10.1.1/data/G4ABLA3.0
ENV G4PIIDATA=/usr/local/share/Geant4-10.1.1/data/G4PII1.3
ENV G4SAIDXSDATA=/usr/local/share/Geant4-10.1.1/data/G4SAIDDATA1.1
ENV G4REALSURFACEDATA=/usr/local/share/Geant4-10.1.1/data/RealSurface1.0
WORKDIR /workspace
ENTRYPOINT ["/usr/local/bin/bdsim"]
