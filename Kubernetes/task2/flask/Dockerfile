FROM python:3.7.3

ARG FAM="Red Hat"
ARG TIM
ENV FAMILY=${FAM}
ENV TIME=${TIM}
ENV PARAMETER="cUstOm pArametEr"
RUN pip install Flask
COPY . /
ENV FLASK_APP=app2.py
EXPOSE 5000

CMD flask run --host=0.0.0.0




