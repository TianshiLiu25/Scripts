FROM ubuntu
# install dependencies
COPY sources.list /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y unzip openjdk-11-jdk nodejs
# install and config sdk
RUN mkdir -p /root/tools
WORKDIR /root/tools
COPY ohcommandlinetools-linux-tool-1.0.0.200.zip ohcommandlinetools-linux-tool-1.0.0.200.zip
RUN unzip ohcommandlinetools-linux-tool-1.0.0.200.zip -d ohcommandlinetools-linux-tool
RUN rm ohcommandlinetools-linux-tool-1.0.0.200.zip
COPY config.properties /root/tools/ohcommandlinetools-linux-tool/oh-command-line-tools/ohsdkmanager/conf/config.properties
RUN mkdir -p /root/tools/oh-sdk
ENV ohsdkmgr=/root/tools/ohcommandlinetools-linux-tool/oh-command-line-tools/ohsdkmanager/bin/ohsdkmgr
RUN $ohsdkmgr install ets:9 toolchains --accept-license
ENV OHOS_SDK_HOME=/root/tools/oh-sdk
ENV PATH="${OHOS_SDK_HOME}/toolchains:${PATH}"
RUN npm config set @ohos:registry=https://repo.harmonyos.com/npm/
ENV NODE_HOME="/usr/bin"
WORKDIR /root/tools/oh-sdk/ets/3.2.2.5/build-tools/ets-loader/bin/ark/build
RUN npm install
# download sign_tool
ENV SIGN_TOOL_DIR='/root/tools/sign_tool'
WORKDIR ${SIGN_TOOL_DIR}
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y git
RUN git clone https://gitee.com/openharmony/signcenter_tool --depth=1
COPY sign_hap.sh sign_hap.sh
COPY UnsignedReleasedProfileTemplate.json UnsignedReleasedProfileTemplate.json
COPY hap-sign-tool.jar hap-sign-tool.jar
# build hap
WORKDIR /root/oh_hap_to_build
COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh
ENTRYPOINT [ "/root/start.sh" ]