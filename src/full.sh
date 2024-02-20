#!/bin/bash
# set -x
       TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > authorities-v4.txt
       TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > authorities-v6.txt
       TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > snowflake.txt
       TZ="UTC" date | awk 'BEGIN {print "Updated:"} {print$1,$2,$3,$6,$4,$5} END {print "----------------------------"}' > snowflake-v6.txt
       curl -s "https://onionoo.torproject.org/details?type=relay&running=true&flag=authority&fields=or_addresses" > authorities
       cat authorities | sed -r 's/.{18}//;s/[:].*$//g' | sed -e '1,4d' | sed '/[]]/,$d' >> authorities-v4.txt
       echo "193.187.88.42" >> snowflake.txt
       echo "193.187.88.43" >> snowflake.txt
       echo "193.187.88.44" >> snowflake.txt
       echo "193.187.88.45" >> snowflake.txt
       echo "193.187.88.46" >> snowflake.txt
       echo "141.212.118.18" >> snowflake.txt
       cat authorities | awk -F[ '{print $3}' | awk NF | sed 's/[]].*//' >> authorities-v6.txt
       echo "2a0c:dd40:1:b::42" >> snowflake-v6.txt
       echo "2a0c:dd40:1:b::43" >> snowflake-v6.txt
       echo "2a0c:dd40:1:b::44" >> snowflake-v6.txt
       echo "2a0c:dd40:1:b::45" >> snowflake-v6.txt
       echo "2a0c:dd40:1:b::46" >> snowflake-v6.txt
       echo "2607:f018:600:8:be30:5bff:fef1:c6fa" >> snowflake-v6.txt
       /bin/rm -r authorities
