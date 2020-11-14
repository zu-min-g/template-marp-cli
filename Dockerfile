FROM marpteam/marp-cli

WORKDIR /home/marp/app

USER root

COPY package-lock.json package-lock.json
COPY package.json package.json

RUN mkdir /home/marp/app/node_modules && chown -R marp:marp /home/marp/app

USER marp

RUN yarn add puppeteer-core@chrome-$(chromium-browser --version | sed -r 's/^Chromium ([0-9]+).+$/\1/') || true
RUN yarn install && yarn cache clean

ENTRYPOINT ["npm", "run"]
CMD ["start"]
