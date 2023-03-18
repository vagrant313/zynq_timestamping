#----------------------------------------------------------------------------------------------------------------------------

# installation
first update the pluto firmware version https://wiki.analog.com/university/tools/pluto/users/firmware
a. check the current verion
   iio_info -s
   should be v0.23
b. https://github.com/analogdevicesinc/plutosdr-fw/releases/tag/v0.34
   copy all te files of plutosdr-fw-v0.34.zip
   to plutoSDR drive
   
   Eject usb 
   
   wait for blibking led about 4minuts
   
   reboot pluto


1. install libiio ver 0.23 which is compatible with srs 2019.1 bitfile
    https://github.com/analogdevicesinc/plutosdr-fw/releases/tag/v0.34
2. install libiio-ad936x
    wget http://swdownloads.analog.com/cse/travis_builds/master_latest_libad9361-iio-ubuntu-18.04-amd64.deb
    dpkg -i *.deb
3. run /app/prepare.sh
   this will install srs binaries
   we can use run_txrx_test.sh

4. copy srs release system_top.bit.bin to bootfiles
   run bitfileUpdate.sh
5. ssh plutosdr
   dmesg  -> check bitfile programmed and driver rebinded
    
6. run /app/scripts$ ./run_txrx_plutosdr.sh
+ sudo LD_LIBRARY_PATH=/home/ei/srs-zynq-timestamping/zynq_timestamping/app/scripts/../bin_app nice -20 ../bin_app/txrx_test -f 2400000000 -a n_prb=6,context=ip:192.168.2.1 -p 6 -g 50 -o test_txrx_pluto.bin
Opening RF device...
Active RF plugins: libsrsran_rf_iio.so
Inactive RF plugins:
Supported RF device list: iio
Trying to open RF device 'iio'
CH0 n_prb=6
CH0 context=ip:192.168.2.1
RF device 'iio' successfully opened
Subframe len:   1920 samples
Time advance:   0.000000 us
Set TX/RX rate: 1.92 MHz
Set RX gain:    50.0 dB
Set TX gain:    40.0 dB
Set TX/RX freq: 2400.00 MHz
Rx subframe 0
Transmitting Signal
Rx subframe 1
Rx subframe 2
Rx subframe 3
Transmitting Signal
Rx subframe 4
Rx subframe 5
Rx subframe 6
Rx subframe 7
Rx subframe 8
Transmitting Signal
Rx subframe 9
Rx subframe 10
Rx subframe 11
Rx subframe 12
Rx subframe 13
Rx subframe 14
Rx subframe 15
Rx subframe 16
Rx subframe 17
Rx subframe 18
Rx subframe 19
Done

/app/scripts$ python3 show.py test_txrx_pluto.bin 

#----------------------------------------------------------------------------------------------------------------------------
# bitfile update:
install sshpass
check ip adress of pluto

copy system_top.bit to /bootfiles
install bootgen from xilinx repo
copy bootgen to /bootfiles
./bootgen -image boot.bif -arch zynq -o i system_top.bit.bin -w
sudo ./bitfileUpdate



#----------------------------------------------------------------------------------------------------------------------------

# Zynq timestamping solution

This repository contains the source code of a timestamping mechanism developed by [SRS](http://www.srs.io) for both Zynq MPSoC and RFSoC devices, including RTL and C code, project generation scripts and extensive documentation. The solution is targeting a typical SDR implementation in which the transmission and reception of I/Q samples is triggered by a call to a software function. Two different approaches are supported towards this end:

1. **Use the Zynq-based board as an SDR front-end**: that is, the Zynq-board directly interfaces the RF and implements the timestamping solution, whereas the SDR application runs in a host that is connected to it via Ethernet/USB. For this use case, the following platforms are explicitly supported:

  - [MicroPhase AntSDR](/projects/antsdr/)
  - [ADALM-PLUTO](/projects/pluto/)

2. **Use the Zynq-based board as a fully embedded SDR solution**: that is, the Zynq-board directly interfaces the RF (or has it embedded it in the SoC; e.g., RFSoC), implements the timestamping solution (in the FPGA, where you could also accelerate other DSP functions) and also hosts the SDR application (in the embedded ARM). For this use case, the following platforms are explicitly supported:

  - [Xilinx Zynq UltraScale+ MPSoC ZCU102 Evaluation Kit](/projects/zcu102/)
  - [Xilinx Zynq UltraScale+ RFSoC ZCU111 Evaluation Kit](/projects/zcu111/)

For the sake of convenience this repository includes the code which is specific to the Zynq timestamping solution and uses submodules for the related code that is external to it, including the [srsRAN 4G/5G software radio suite](https://www.srsran.com) and [Analog Devices HDL library](https://wiki.analog.com/resources/fpga/docs/hdl). The latter is used because the timestamping solution is targeting AD936x-based front-ends for MPSoC architectures.

The full details of the Zynq timestamping solution can be found in the [documentation page](https://srsran.github.io/zynq_timestamping/). Additionally, dedicated application notes are covering all required steps from build to test:

- End-to-end 4G testing with the [AntSDR](https://srsran.github.io/zynq_timestamping/app/antsdr.html).
- Tx-Rx testing with the [ADALM-PLUTO](https://srsran.github.io/zynq_timestamping/app/plutosdr.html).
- Petalinux build, software cross-compilation and Tx-Rx testing with [ZCU102/ZCU111](https://srsran.github.io/zynq_timestamping/app/zcu.html) boards.

We recommend you to go through the application notes, as the detailed steps can be (often easily) modified/reused to target different boards and/or SDR applications.

Please, use the [Zynq timestamping Discussions space](https://github.com/srsran/zynq_timestamping/discussions) for discussion and community support. Make sure to read the [overview](https://github.com/srsran/zynq_timestamping/discussions/1) and to follow the guidelines when opening a new discussion point.

# Requirements

- The solution has been developed, validated and tested using:

  * Vivado 2019.2
  * SRS Python Tools:

    ```
    cd python_tools
    sudo pip3 install -U pip
    pip3 install .
    ```
  * [optional] For documentation:
    ```
    npm install teroshdl
    ```

- To clone the repository and the utilized submodules:

  ```
  git clone --recursive
  ```

# Pre-built images

Pre-built images for all supported boards can be found attached as an asset to the [released code](https://github.com/srsran/zynq_timestamping/releases).
