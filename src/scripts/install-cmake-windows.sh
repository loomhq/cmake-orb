#!/bin/bash

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
url="${baseUrl}/v$CMAKE_VERSION/cmake-$CMAKE_VERSION-windows-x86_64.zip"

echo "Downloading from: $url"
curl -sSL -o /tmp/cmake.zip "$url"
tar -C "${CMAKE_INSTALL_DIR:?}" --strip-components 1 -zxf /tmp/cmake.zip

# Remove unnecessary files
rm -rf "${CMAKE_INSTALL_DIR:?}"/{doc,man}
