#!/usr/bin/env -S awk -f

BEGIN { printf "i,time,heap,heap_extra," }

/^desc:.*$/ {
    if(match($0, /stacks=yes/)) {
	printf("stacks,")
    }
    printf("peak\n")
    FS="="
}

$1 == "time" {
    printf("%s,", $2)
}

$1 == "snapshot" {
    printf("%s,", $2)
}

$1 == "mem_heap_B" {
    printf("%s,", $2)
}

$1 == "mem_heap_extra_B" {
    printf("%s,", $2)
}

$1 == "mem_stacks_B" {
    printf("%s,", $2)
}

$1 == "heap_tree" {
    if($2 == "peak") {
        printf("1\n")
    } else {
        printf("0\n")
    }
}
