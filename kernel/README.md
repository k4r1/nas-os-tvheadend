# Building Custom Kernel Modules

Since NAS OS is designed to be as light-weight as possible, the default linux kernel does not include support for many kinds of external devices, including DVB. This makes sense as it is unusual for users to use their NAS with a DVB tuner.

In order to support our tuner then, we must build and insert kernel modules. In order to do this, we require the kernel source for the particular version of linux the NAS is running. Since Linux is licensed under GPL, manufacturers are obliged to make their full linux source public (however many fail to do so). Luckily, Seagate has complied with this requirement, and the kernel source used in this project is available here:

- [Kernel Source Code Direct Link](https://www.seagate.com/files/www-content/support-content/network-attached-storage/business-storage/seagate-nas-pro/_shared/masters/SeagateNAS_GPL_4.3.16.0.zip)

- [Downloads Page - See "Seagate NAS GPL Source Code"](https://www.seagate.com/gb/en/support/network-attached-storage/business-storage/seagate-nas/)

Once you unzip the file, you'll find the kernel in `SeagateNAS_GPL_X.X.XX.X/linux.tar.bz2`.

## Configuration

The configuration I used is available in this directory `.config`. You can simply copy this into the root of the linux repo, or you can build your own config:

`sudo make ARCH=arm menuconfig`

Most of the modules you will need can be found in `Device Drivers -> Multimedia Support -> Media USB Adapters`. I would suggest that you make use of the search functionality `/` to find the method the dependencies of the options you want to enable. Set the options you need to `M` to build them as a kernel module.

## Compiling

To compile your kernel modules run:

`make modules ARCH=arm CROSS_COMPILE=arm-marvell-linux-gnueabi- -j8`

The resultant `.ko` files can be found next to their respective source files in the directory tree, e.g:

- `drivers/media/dvb-frontends/dib0070.c`
- `drivers/media/dvb-frontends/dib0070.o`
- `drivers/media/dvb-frontends/dib0070.ko` - This is the file you want to package with your NAS App

## Troubleshooting

To load your module into the running kernel, use the `insmod NAME.ko` command. If you have an error, examine the output of the `dmesg` command - it is usually a dependend kernel module which has not been inserted.

You can use `modprobe --show-depends NAME.ko` to list the dependencies of a particular module, and then use `menuconfig` to find the option to build each of them until you have everything you need.

Note: In order to get my dvb card to work, I also had to insert the `evdev` module.
