FROM mysql:5.7.23

RUN apt-get update && apt-get install openssh-client -y

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["tail -f /dev/null"]