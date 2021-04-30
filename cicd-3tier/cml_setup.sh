#!/bin/bash


echo "First clear existing CML labs"
python clear_cml.py

echo "Launching CML simulations ... "
root_dir=$(pwd)
cd $root_dir/cml
virl up --provision > /dev/null &
TEST=$!
wait $TEST
cd $root_dir


echo "Test Network Summary"
cd $root_dir/cml
virl ls
virl nodes

