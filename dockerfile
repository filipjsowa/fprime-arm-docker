FROM nasafprime/fprime-arm:latest
USER root
RUN sudo pip install -U -r https://raw.githubusercontent.com/nasa/fprime/refs/tags/v4.1.1/requirements.txt