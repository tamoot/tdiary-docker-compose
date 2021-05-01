FROM nginx:latest

ARG SERVER_NAME
ARG TDIARY_BASE_DIR

RUN rm -f /etc/nginx/conf.d/*
ADD tdiary.conf /etc/nginx/conf.d/tdiary.conf

RUN cd /etc/nginx/conf.d  && \
   sed -i.org -e "s!__SERVER_NAME__!${SERVER_NAME}!g" tdiary.conf && \
   sed -i.renamed_servername -e "s!__TDIARY_BASE_DIR__!${TDIARY_BASE_DIR}!g" tdiary.conf

RUN mkdir -p /var/www/${SERVER_NAME}

RUN ln -s /tdiary/tdiary-core/public /var/www/${SERVER_NAME}/d
