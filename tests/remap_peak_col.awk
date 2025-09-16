BEGIN { FS="," }

{
    if ($NF == "true") $NF=1
    else if ($NF == "false") $NF=0
    for(i = 1; i <= NF; i++) {
	printf("%s%s", $i, (i == NF ? RS : FS))
    }
}
