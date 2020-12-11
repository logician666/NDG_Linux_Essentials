## Solution:

`
f=/etc/services/
F=uniqueservices.txt

grep '^[a-zA-Z_-]' $f | tr -s [[:blank:]] '\t' | cut -f1 | sort -u > $F && wc -l $F

head $F
tail $F
`
