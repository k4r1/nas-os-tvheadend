# TVHeadEnd for Seagate NAS OS
This project is an app for the Seagate PersonalCloud NAS which:
 - Adds kernel support for USB TV Tuners
 
 - Installs an instance of [TVHeadEnd](https://tvheadend.org/) server
 
This allows you to connect a USB TV Tuner to your NAS and use it to record live TV, as well as stream it over your network. 

## Installation
To install, go to [http://personalcloud.local/?appdev=1#app_manager](http://personalcloud.local/?appdev=1#app_manager) and select "Manual Install". Upload the `.rbw` file found in the `releases` directory (or `build/armv7` if you built yourself) and click install.

## Tuner Support
This repo contains modules I have compiled for the [Hauppuage WinTV Duet](http://www.hauppauge.co.uk/site/products/data_duet.html).

To add support for your own DVB tuner, you must build your own kernel modules, and then rebuild and repackage the app.

 - Build your kernel modules (See my guide in `kernel/README`)
 
 - Connect to your NAS with SSH:
   - To enable SSH on your NAS, navigate to `http://personalcloud.local?appdev=1#device_manager-services` and enable "SSH Access". Note the `appdev=1` query string - this is [required](https://www.seagate.com/nasos/SDK/0.7/debug/index.html) to make the setting visible. 

   - Use `ssh username@personalcloud.local` (if this doesn't work, try to find the IP of your NAS and use that)

 - Seagate's "container" system is called `rainbow`. This must be run as root.
 
   - `rainbow --list` shows the list of running containers.

   - `rainbow --enter co.karltaylor.tvheadend` will allow you to "enter" the container. 

     - Seagate is using a simple `chroot` to achieve this. 
     
     - The new root is stored in `/media/internal-1/rainbow/XXXXX-tvheadend/` (or similar).

     - All containers have access to `/shares/*`. To copy files into your container, I recommend copying them there.

     - In order to bind a directory from the host to the container, before entering use the `mount --bind` command.

   - Attempt to insert your new kernel modules using `insmod NAME.ko`. Use `dmesg` to debug as described in my kernel guide.

     - If dmesg is complaining about a missing `*.fw`, you can usually find this ready-made on Google, or build it yourself.
     
   - Once you have this working, you need to integrate the kernel modules into your app

## Integrating Changes
Once you have manually made changes in your container to get it to work for your particular setup, the next step is to intgerate your changes back into the app and re-package it.

The relevant files for doing so are:

- Build script `build.sh`
- Startup script `source/etc/rc.local`
- Setup script `source/dvb/setup.sh`

## Building
To build, run `make clean` followed by `make` from inside the NAS OS Development [VMWare image](https://www.seagate.com/nasos/SDK/0.7/downloads/index.html#sdk). This is taken from the NAS OS SDK documentation [here](https://www.seagate.com/nasos/SDK/0.7/getting_started/index.html#installing-the-sdk).

The SDK image also contains the toolchain required to build the kernel modules, and so it is useful to also build those within the VM.

