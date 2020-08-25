FROM python:3.6.12-alpine3.12

RUN addgroup -S smallcase && adduser -S smallcase -G smallcase
RUN mkdir -p /home/smallcase/app  && chown -R smallcase:smallcase /home/smallcase/app

USER smallcase 

WORKDIR /home/smallcase/app 

COPY --chown=smallcase:smallcase requirements.txt . 

RUN pip3 install -r requirements.txt

COPY --chown=smallcase:smallcase . .

CMD ["python3", "app.py"]