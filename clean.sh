#!/bin/bash

if [ -f Makefile ]; then
    make clean
fi

find . -name "Makefile" -delete
rm -f config.status config.h config.log
rm -rf autom4te.cache
