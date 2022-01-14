
Docker for Mac
--------------
Steps to build a Docker image containing IBM MQ Explorer:
1. Download and extract the code from [GitHub](https://codeload.github.com/ibm-messaging/mq-container/zip/master), or run the following command: `git clone https://github.com/ibm-messaging/mq-container`
2. Open a Terminal window in the `mq-container` directory
3. Run `docker build -t mq-explorer -f ./Dockerfile .`

Steps to prepare your Mac with XQuartz:
1. Install XQuartz.  Version 2.7.10 works, but V2.7.11 doesn't seem to (see [this thread](https://stackoverflow.com/questions/38686932/how-to-forward-docker-for-mac-to-x11))
2. Run XQuartz
3. Open the XQuartz "Preferences" menu, go to the "Security" tab and enable "Allow connections from network clients"
4. Restart XQuartz

Steps to run IBM MQ Explorer:
1. Add your IP address to the list of allowed hosts: `xhost + 127.0.0.1`
2. Run MQ Explorer: `docker run -e DISPLAY=$host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix -u 0 -ti mq-explorer`
