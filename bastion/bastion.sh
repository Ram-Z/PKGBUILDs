#!/bin/bash
cd /opt/Bastion
[[ "$1" == "--mesa" ]] && export force_s3tc_enable=true && shift
./Bastion.bin.x86_64 $@
