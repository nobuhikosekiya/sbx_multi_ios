#!/usr/bin/env python3
#
# Python bindings for the Cisco VIRL 2 Network Simulation Platform
#
# This file is part of VIRL 2
#
# Copyright 2020 Cisco Systems Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

from virl2_client import ClientLibrary
import sys
import os

url = 'https://10.10.20.161'
username = 'developer'
password = 'C1sco12345'

# setup the connection and clean everything
cl = ClientLibrary(url, username, password, ssl_verify=False)
cl.is_system_ready(wait=True)

lab_list = cl.get_lab_list()
for lab_id in lab_list:
    lab = cl.join_existing_lab(lab_id)
    lab.stop()
    lab.wipe()
    cl.remove_lab(lab_id)


