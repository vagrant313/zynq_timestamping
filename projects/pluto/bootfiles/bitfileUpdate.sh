#!/usr/bin/env bash
#set -x
#trap read debug

export BOARD_USER="root"
export BOARD_PASS="analog"
export BOARD_IP="192.168.2.1"

#sshpass -p $BOARD_PASS ssh plutosdr

ssh-keygen -f "/root/.ssh/known_hosts" -R "192.168.2.1"
sshpass -p $BOARD_PASS scp -oStrictHostKeyChecking=no ./bootfiles/system_top.bit.bin $BOARD_USER@$BOARD_IP:/lib/firmware/system_top.bit.bin
sshpass -p $BOARD_PASS ssh -oStrictHostKeyChecking=no $BOARD_USER@$BOARD_IP "cd /lib/firmware; echo system_top.bit.bin > /sys/class/fpga_manager/fpga0/firmware"

sshpass -p $BOARD_PASS ssh -oStrictHostKeyChecking=no $BOARD_USER@$BOARD_IP "echo 79024000.cf-ad9361-dds-core-lpc > /sys/bus/platform/drivers/cf_axi_dds/unbind"
sshpass -p $BOARD_PASS ssh -oStrictHostKeyChecking=no $BOARD_USER@$BOARD_IP "echo 79020000.cf-ad9361-lpc > /sys/bus/platform/drivers/cf_axi_adc/unbind"
sshpass -p $BOARD_PASS ssh -oStrictHostKeyChecking=no $BOARD_USER@$BOARD_IP "echo 7c400000.dma > /sys/bus/platform/drivers/dma-axi-dmac/unbind"
sshpass -p $BOARD_PASS ssh -oStrictHostKeyChecking=no $BOARD_USER@$BOARD_IP "echo 7c420000.dma > /sys/bus/platform/drivers/dma-axi-dmac/unbind"
sshpass -p $BOARD_PASS ssh -oStrictHostKeyChecking=no $BOARD_USER@$BOARD_IP "echo 7c420000.dma > /sys/bus/platform/drivers/dma-axi-dmac/bind"
sshpass -p $BOARD_PASS ssh -oStrictHostKeyChecking=no $BOARD_USER@$BOARD_IP "echo 7c400000.dma > /sys/bus/platform/drivers/dma-axi-dmac/bind"
sshpass -p $BOARD_PASS ssh -oStrictHostKeyChecking=no $BOARD_USER@$BOARD_IP "echo 79024000.cf-ad9361-dds-core-lpc > /sys/bus/platform/drivers/cf_axi_dds/bind"
sshpass -p $BOARD_PASS ssh -oStrictHostKeyChecking=no $BOARD_USER@$BOARD_IP "echo 79020000.cf-ad9361-lpc > /sys/bus/platform/drivers/cf_axi_adc/bind"
