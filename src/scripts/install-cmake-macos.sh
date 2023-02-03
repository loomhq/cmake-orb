#!/bin/bash

# shellcheck disable=SC1090
source "${BASH_ENV:?}"

echo "PATH $PATH"

if which cmake; then
  if cmake --version | grep "$CMAKE_VERSION"; then
    echo "CMake is already installed."
    exit 0
  else
    echo "CMake is already installed but it is the wrong version."
    cmake --version
  fi
fi
rm -rf "${CMAKE_INSTALL_DIR:?}/*"

echo "Installing the requested version of CMake."
baseUrl="https://github.com/Kitware/CMake/releases/download/"
url="${baseUrl}/v$CMAKE_VERSION/cmake-$CMAKE_VERSION-macos-universal.tar.gz"

echo "Downloading from: $url"
curl -sSL -o /tmp/cmake.tar.gz "$url"
tar -C "${CMAKE_INSTALL_DIR:?}" --strip-components 1 -zxf /tmp/cmake.tar.gz

# copy binary
ln -s "${CMAKE_INSTALL_DIR:?}/CMake.app/Contents/bin" "${CMAKE_INSTALL_DIR:?}/bin"

# remove unnecessary files