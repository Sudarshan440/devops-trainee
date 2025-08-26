#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <number1>"
  echo "somethin went wrong!"
  exit 1
fi

VERSION=$1
JAVA_VERSION="jdk-${VERSION}"
DOWNLOAD_DIR="/home/ncs/Downloads"
INSTALL_DIR="/home/ncs/sudarshan"
TAR_FILE="${JAVA_VERSION}_linux-x64_bin.tar.gz"
DOWNLOAD_URL="https://download.oracle.com/java/${VERSION}/latest/${TAR_FILE}"

echo "Downloading Java package..."
wget -P "$DOWNLOAD_DIR" "$DOWNLOAD_URL"

if [ -f "$INSTALL_DIR/$TAR_FILE" ]; then
    echo "FILE IS ALREADY THERE!!!"
    rm "$DOWNLOAD_DIR/$TAR_FILE"
    echo "Removed temporary downloaded file"
    exit 1
else
    echo "Extracting the Java package..."
    tar -xf "$DOWNLOAD_DIR/$TAR_FILE" -C "$INSTALL_DIR"
    echo "Java package extracted!"
fi

EXTRACTED_DIR=$(find "$INSTALL_DIR" -type d -name "${JAVA_VERSION}*" | head -n 1)

export JAVA_HOME="$EXTRACTED_DIR"

export PATH="$JAVA_HOME/bin:$PATH"

echo "export JAVA_HOME=\"$EXTRACTED_DIR\"" >> ~/.bashrc
echo "export PATH=\"\$JAVA_HOME/bin:\$PATH\"" >> ~/.bashrc
source ~/.bashrc

echo $JAVA_HOME
echo $PATH
echo "Java version:"
java --version

echo "package downloaded in ${INSTALL_DIR}"

rm "$DOWNLOAD_DIR/$TAR_FILE"
echo "Removed temporary download file."

exit 0