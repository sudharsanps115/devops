#! /bin/bash

awk 'NR<5 { print }
NR>=5 {
    if ($0 ~ /welcome/) {
        gsub(/give/, "learning")
        print
    } else {
        print
    }
}' input.txt > output.txt

