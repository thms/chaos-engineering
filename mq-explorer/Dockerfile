# © Copyright IBM Corporation 2015, 2019
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# FROM registry.redhat.io/ubi8/ubi-minimal AS mq-explorer
FROM registry.access.redhat.com/ubi8/ubi-minimal AS mq-explorer

# The URL to download the MQ installer from in tar.gz format
ARG MQ_URL="https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/mqadv_dev924_linux_x86-64.tar.gz"

# The MQ packages to install
ENV MQ_PACKAGES="MQSeriesRuntime*.rpm MQSeriesJRE*.rpm MQSeriesExplorer*.rpm"

RUN microdnf install -y gtk3 libXtst xorg-x11-fonts-Type1 libglvnd-glx tar gzip \
  && microdnf clean all

RUN mkdir -p /tmp/mq
ADD mqadv_dev924_linux_x86-64.tar.gz /tmp/mq/

ADD install-mq-explorer.sh /usr/local/bin/
ADD install-mq-server-prereqs.sh /usr/local/bin

RUN chmod u+x /usr/local/bin/install-mq-server-prereqs.sh \
  && sleep 1 \
  && install-mq-server-prereqs.sh

# Install MQ Explorer.  To avoid a "text file busy" error here, we sleep before installing.
# Need to re-instate the `/var/mqm` directory after installation, to avoid MQ
# errors with some commands (e.g. `dspmqver`)
RUN chmod u+x /usr/local/bin/install-mq-explorer.sh \
  && sleep 1 \
  && install-mq-explorer.sh \
  && rm -rf /var/mqm \
  && /opt/mqm/bin/crtmqdir -f -s

ENV LANG=en_US.UTF-8
ENV LD_LIBRARY_PATH=/opt/mqm/lib64
ENV PATH="${PATH}:/opt/mqm/bin"

# Run as mqm
USER mqm

ENTRYPOINT ["MQExplorer", "-configuration", "/mnt/mqm/"]
