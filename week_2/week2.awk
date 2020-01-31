#!/bin/awk

BEGIN {starting=0.00; count=0; balance=0.00}

$1 ~ /^[0-9]+\.[0-9]{2}$/ {
	starting = $1;
	balance=$1;
	print "Original_Balance:: ", starting
}

($1 ~ /^[0-9]+/) && ($2 ~ /^[a-zA-Z0-9\.]+/) {
	balance -= $3;
	count += 1;
	printf("%s %s %0.2f Balance %0.2f\n", $1, gensub(/^([a-zA-Z0-0\.]+).*/, "\\1", "g", $2), $3, balance)
}

END {
	print "Total Expense ", (starting-balance);
	printf("Average expense %0.2f\n", ((starting - balance) / count))
}
