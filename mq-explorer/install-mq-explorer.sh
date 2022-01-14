#!/bin/bash
# -*- mode: sh -*-
# © Copyright IBM Corporation 2015, 2020
#
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

# Fail on any non-zero return code
set -ex

test -f /usr/bin/rpm && RPM=true || RPM=false
test -f /usr/bin/apt-get && UBUNTU=true || UBUNTU=false

# Only install the SDK package as part of the build stage
INSTALL_SDK=${INSTALL_SDK:-0}

# MQ unzippable server is mounted already and unzipped
DIR_TMP=/tmp/mq/MQServer
cd ${DIR_TMP}

# Install the packages
# MQSeriesRuntime*.rpm MQSeriesJRE*.rpm MQSeriesExplorer*.rpm
rpm -ivh ./MQSeriesRuntime*.rpm
rpm -ivh ./MQSeriesJRE*.rpm
rpm -ivh ./MQSeriesExplorer*.rpm
rm -Rf ${DIR_TMP}
# Accept the MQ license
/opt/mqm/bin/mqlicense -accept

# Optional: Update the command prompt with the MQ version
#$UBUNTU && echo "mq:$(dspmqver -b -f 2)" > /etc/debian_chroot

# Create the mount point for volumes, ensuring MQ has permissions to all directories
install --directory --mode 2775 --owner mqm --group mqm /mnt
install --directory --mode 2775 --owner mqm --group mqm /mnt/mqm
install --directory --mode 2775 --owner mqm --group mqm /mnt/mqm/data
install --directory --mode 2775 --owner mqm --group mqm /mnt/mqm-log
install --directory --mode 2775 --owner mqm --group mqm /mnt/mqm-log/log
install --directory --mode 2775 --owner mqm --group mqm /mnt/mqm-data
install --directory --mode 2775 --owner mqm --group mqm /mnt/mqm-data/qmgrs

# Create the directory for MQ configuration files
install --directory --mode 2775 --owner mqm --group mqm /etc/mqm

# Create the directory for MQ runtime files
install --directory --mode 2775 --owner mqm --group mqm /run/mqm

# Create a symlink for /var/mqm -> /mnt/mqm/data
ln -s /mnt/mqm/data /var/mqm


#Update the license file to include UBI 8 instead of UBI 7
sed -i 's/v7.0/v8.0/g' /opt/mqm/licenses/non_ibm_license.txt

# Copy MQ Licenses into the correct location
mkdir -p /licenses
cp /opt/mqm/licenses/*.txt /licenses/
