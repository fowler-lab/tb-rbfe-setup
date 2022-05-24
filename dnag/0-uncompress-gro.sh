#! /bin/bash

find a90v/ -name '*.gro.gz' | parallel gunzip {}
