BEGIN { FS="," }

{
    $2 = ""
    for(i = 1; i <= NF; i++) {
	if (i == 2) continue;
	printf("%s%s", $i, (i == NF ? RS : FS))
    }
}
