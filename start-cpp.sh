#!/bin/bash

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: start-cpp <project_name>"
    exit 1
fi


mkdir $PROJECT_NAME
cd $PROJECT_NAME


cat <<EOF >main.cpp
#include <iostream>

int main(){
    std::cout<< "Project $PROJECT_NAME  initialized!"<< std::endl;
    return 0;
}
EOF


git init
echo "temp_exec" > .gitignore

echo "Project '$PROJECT_NAME' is ready!"
ls -R
