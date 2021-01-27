FROM buildpack-deps:focal-scm
MAINTAINER Brishen Hawkins

RUN apt-get -y update && \
	DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common apt-transport-https && \
	curl -fsSL https://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
	dpkg --add-architecture i386 && \
	add-apt-repository https://dl.winehq.org/wine-builds/ubuntu/ && \
	apt-get -y update && \
	DEBIAN_FRONTEND=noninteractive apt-get -y install --install-recommends winehq-stable winetricks
	
RUN useradd -m wine
USER wine
RUN winetricks vcrun2017 vcrun2015 vcrun2013 dotnet48 dotnet472 dotnet35sp1
WORKDIR /home/wine
ENV HOME /home/wine

CMD ["/bin/bash"]
