#! /bin/bash

find a90v/ -name '*.gro' | parallel gzip {}
