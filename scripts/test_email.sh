#!/bin/bash
set -e

aws ses send-email \
    --from atharavkagde7@gmail.com\
    --destination success@simulator.amazonses.com \
    --message "Subject={Data='Test TechWave Email',Charset='UTF-8'},Body={Html={Data=$(cat templates/template1.html),Charset='UTF-8'}}"
echo "Test email sent"
