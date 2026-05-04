FROM nasafprime/fprime-arm:latest
USER root
RUN sudo pip install -U -r https://raw.githubusercontent.com/nasa/fprime/refs/tags/v4.2.2/requirements.txt