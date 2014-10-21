# copy of https://registry.hub.docker.com/u/ansible/ubuntu14.04-ansible/dockerfile/
FROM ubuntu:14.04
MAINTAINER Toshio Kuratomi <tkuratomi@ansible.com>
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y python-yaml python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools python-pkg-resources git python-pip
RUN mkdir /etc/ansible/
RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts
RUN mkdir /opt/ansible/
RUN git clone http://github.com/ansible/ansible.git /opt/ansible/ansible
WORKDIR /opt/ansible/ansible
ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
ENV PYTHONPATH /opt/ansible/ansible/lib
ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library

# The version at f35ed8a6c0dc81b86c69348fff543d52f070ee28 seems to be the last working one. The version at
# e5116d2f9bd851949ae50e0c9c112750e7cec761 causes the problem.

RUN git reset --hard e5116d2f9bd851949ae50e0c9c112750e7cec761
ADD . /tmp/issue
RUN ansible-playbook /tmp/issue/ansible.yml -c local
