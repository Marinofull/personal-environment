#!/bin/bash

read TPdevice <<< $( xinput | sed -nre '/.*Synaptics.*id=([0-9]*).*/s//\1/p' )
xinput --disable $TPdevice
