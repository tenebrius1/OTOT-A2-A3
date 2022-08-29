DURATION=30 # how long should load be applied ? - in seconds
TPS=20 # number of requests per second
end=$((SECONDS+$DURATION))
#start load
while [ $SECONDS -lt $end ];
do
    for ((i=1;i<=$TPS;i++)); do
        curl -s 'http://localhost/app' > /dev/null
    done
    sleep 1
done
wait
#end load
echo "Load test has been completed"