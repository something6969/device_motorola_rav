#!/vendor/bin/sh

notice()
{
	echo "$*"
	echo "$scriptname: $*" > /dev/kmsg
}

typeset -l carrier=$(getprop ro.carrier)
brazil="timbr tefbr amxbr retbr"

path=/vendor/etc/acdbdata
device=row

# use audio parameter specialized for Brazilian market

# For channel NA sku, use seprate parameter files.
if [ "`getprop ro.vendor.hw.radio`" == "NA" ]
then
	device=na
fi
index=0
for file in $(ls $path/$device/); do
    setprop persist.vendor.audio.calfile$index $path/$device/$file
    index=$((index+1))
done
notice "hw.radio: [`getprop ro.vendor.hw.radio`], calfile6: [`getprop persist.vendor.audio.calfile6`]"
