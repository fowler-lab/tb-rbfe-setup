#! /bin/bash

find s450l/ -name '*.gro' | parallel gzip {}
