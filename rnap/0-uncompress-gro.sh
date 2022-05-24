#! /bin/bash

find s450l/ -name '*.gro.gz' | parallel gunzip {}
