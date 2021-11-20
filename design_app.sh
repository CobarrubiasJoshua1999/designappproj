#!/bin/bash

mkdir -p tempdir
mkdir -p tempdir/templates
mkdir -p tempdir/static

cp design_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "FROM python" > tempdir/Dockerfile
echo "COPY  ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY  design_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "RUN python3 -m pip install flask requests" >> tempdir/Dockerfile 
echo "CMD python3 /home/myapp/design_app.py" >> tempdir/Dockerfile

cd tempdir
docker build -t design_app .
docker run -t -d -p 5050:5050 --name design_apprunning design_app
