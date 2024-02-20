#!/bin/bash
# set -x

TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > overloaded.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > hsdir.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > guards.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > guard-exit.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > guard-hsdir-exit.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > relays-v4.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > relays-v6.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > dual-or.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > dual-or-v6.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > 2-or.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > 2-or-v6.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > above2-or.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > above2-or-v6.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > above1-or.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > above1-or-v6.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > exits-v4.txt
TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > exits-v6.txt

curl -s 'https://onionoo.torproject.org/details?type=relay&running=true' > multi-no-or.txt
cat multi-no-or.txt | grep overload_general | sed 's/.*or_addresses\":[[]\"//g' | sed 's/:.*//' | sort >> overloaded.txt
cat multi-no-or.txt | grep \"HSDir\" | sed 's/.*or_addresses\":[[]\"//g' | sed 's/:.*//' | sort >> hsdir.txt
cat multi-no-or.txt | grep \"Guard\" | sed 's/.*or_addresses\":[[]\"//g' | sed 's/:.*//' | sort >> guards.txt
cat multi-no-or.txt | grep \"Guard\"| grep \"Exit\" | sed 's/.*or_addresses\":[[]\"//g' | sed 's/:.*//' | sort >> guard-exit.txt
cat multi-no-or.txt | grep \"Guard\"| grep \"HSDir\"| grep \"Exit\" | sed 's/.*or_addresses\":[[]\"//g' | sed 's/:.*//' | sort >> guard-hsdir-exit.txt
/bin/rm -r multi-no-or.txt


curl -s "https://onionoo.torproject.org/details?type=relay&running=true&fields=or_addresses" > multi.txt

cat multi.txt | sed -r 's/.{18}//;s/[:].*$//g' | sed -e '1,4d' | sed '/[]]/,$d' >> relays-v4.txt
cat multi.txt | awk -F[ '{print $3}' | awk NF | sed 's/[]].*//' >> relays-v6.txt
cat relays-v4.txt | sed -e '1,3d' | sort | uniq -c | grep -v ' 1 ' | awk '{ print $2 }' >> dual-or.txt
cat relays-v6.txt | sed -e '1,3d' | sort | uniq -c | grep -v ' 1 ' | awk '{ print $2 }' >> dual-or-v6.txt
cat relays-v4.txt | sed -e '1,3d' | sort | uniq -c | grep ' 2 ' | awk '{ print $2 }' >> 2-or.txt
cat relays-v6.txt | sed -e '1,3d' | sort | uniq -c | grep ' 2 ' | awk '{ print $2 }' >> 2-or-v6.txt
cat relays-v4.txt | sed -e '1,3d' | sort | uniq -c | grep -v ' 1 ' | grep -v ' 2 ' | awk '{ print $2 }' >> above2-or.txt
cat relays-v6.txt | sed -e '1,3d' | sort | uniq -c | grep -v ' 1 ' | grep -v ' 2 ' | awk '{ print $2 }' >> above2-or-v6.txt
cat relays-v4.txt | sed -e '1,3d' | sort | uniq -c | grep -v ' 1 ' | awk '{ print $2 }' >> above1-or.txt
cat relays-v6.txt | sed -e '1,3d' | sort | uniq -c | grep -v ' 1 ' | awk '{ print $2 }' >> above1-or-v6.txt

/bin/rm -r multi.txt


curl -s "https://onionoo.torproject.org/details?type=relay&running=true&fields=or_addresses&flag=Exit" > multi-ex.txt
cat multi-ex.txt | sed -r 's/.{18}//;s/[:].*$//g' | sed -e '1,4d' | sed '/[]]/,$d' >> exits-v4.txt
cat multi-ex.txt | awk -F[ '{print $3}' | awk NF | sed 's/[]].*//' >> exits-v6.txt
/bin/rm -r multi-ex.txt
