#!/usr/bin/env bash

run_test() {
    if [[ $# != 1 ]]; then
	return 1
    fi
    local f="$1"
    local td
    td=$(mktemp -d)
    local t="$td/t"
    local t1="$td/fromawk.csv"
    local t2="$td/fromcpp.csv"

    awk -f ../massif2csv.awk "$f" > "$t"

    awk -f remove_time_col.awk "$t" > "$t1"
    awk -f remap_peak_col.awk "$f".csv > "$t2"
    sed -i "1d" "$t1" "$t2"

    rc=1
    if cmp -s "$t1" "$t2"; then
	rc=0
    fi

    rm -r "$td"

    if [[ $rc = 1 ]]; then
	printf "Error: Test failed for %s.\n" "$f"
	exit $rc
    fi
}

run_test massif.out
run_test massif_no_stacks.out
printf "All tests passed successfully.\n"
