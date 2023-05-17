FROM python:3.9
ENV https_proxy 172.22.108.7:80
WORKDIR /usr/src
COPY ./requirements.txt .
RUN pip3 install -r requirements.txt
COPY ./convert_to_csv2.py .
CMD ["./convert_to_csv2.py"] 
