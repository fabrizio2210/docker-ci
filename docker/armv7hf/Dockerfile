FROM balenalib/armv7hf-debian
ENV DOCKERVERSION=18.03.1-ce
ENV DOCKERARCH=x86_64


RUN [ "cross-build-start" ]
RUN apt-get update && \
    apt-get install -y curl python3 python-pip  \
    && apt-get clean
RUN pip install pipenv

# install docker client
RUN curl -fsSLO https://download.docker.com/linux/static/stable/${DOCKERARCH}/docker-${DOCKERVERSION}.tgz \
    && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 -C /usr/local/bin docker/docker \
    && rm docker-${DOCKERVERSION}.tgz

COPY src/* /usr/local/bin/
RUN cd /usr/local/bin/ && pipenv install
RUN [ "cross-build-end" ]

WORKDIR /usr/local/bin/
CMD pipenv run python3 /usr/local/bin/docker-ci.py
