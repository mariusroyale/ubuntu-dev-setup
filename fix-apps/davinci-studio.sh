#!/bin/bash
sudo mkdir -p /opt/resolve/libs/disabled
sudo mv /opt/resolve/libs/libglib* /opt/resolve/libs/disabled/
sudo mv /opt/resolve/libs/libgio* /opt/resolve/libs/disabled/
sudo mv /opt/resolve/libs/libgmodule* /opt/resolve/libs/disabled/
sudo mv /opt/resolve/libs/libgobject* /opt/resolve/libs/disabled/
