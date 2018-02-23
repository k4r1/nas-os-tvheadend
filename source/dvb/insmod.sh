echo "Insmod script has been called" >> /home/status

cd /home/dvb

insmod evdev.ko
insmod rc-core.ko
insmod dvb-core.ko
insmod dvb-usb.ko
insmod dibx000_common.ko
insmod dib7000m.ko
insmod dib7000p.ko
insmod dib8000.ko
insmod dib0090.ko 
insmod dib0070.ko 
insmod dib3000mc.ko
insmod dvb-usb-dib0700.ko

echo "Insmod complete" > /home/status
