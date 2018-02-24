echo "Insmod script has been called" >> /home/status

cd /home/dvb

insmod modules/evdev.ko
insmod modules/rc-core.ko
insmod modules/dvb-core.ko
insmod modules/dvb-usb.ko
insmod modules/dibx000_common.ko
insmod modules/dib7000m.ko
insmod modules/dib7000p.ko
insmod modules/dib8000.ko
insmod modules/dib0090.ko 
insmod modules/dib0070.ko 
insmod modules/dib3000mc.ko
insmod modules/dvb-usb-dib0700.ko

echo "Insmod complete" > /home/status
