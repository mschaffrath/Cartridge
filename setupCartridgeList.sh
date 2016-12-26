#!/bin/sh

listName='.library_list.json'
folder='Library'
if [ $# -gt 0 ]
then
    folder=$1;
fi

technologyList='{"libraries": [\n'
for technology in $folder/*; do
    technologyList=$technologyList'\t{"path": "'$technology'/",\n'
    technologyList=$technologyList'\t"name": "'$(basename $technology)'",\n'
    components='\t"components": [\n'
    for cartridge in $technology/*; do
        filename=$(basename $cartridge)
        components=$components'\t\t{"name": "'${filename%.*}'",\n'
        components=$components'\t\t"file": "'$filename'"},\n'
    done;
    components=${components%???}']\n\t},\n'
    technologyList=$technologyList$components
done;
technologyList=${technologyList%???}']\n}'
echo $technologyList > $listName
