FROM python
ADD ./requirements.txt /ansible/
WORKDIR /ansible
RUN pip install -r requirements.txt
ADD ./ansible.cfg /etc/ansible/ansible.cfg
ENTRYPOINT []

