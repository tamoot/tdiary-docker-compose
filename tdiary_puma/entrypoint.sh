#!/bin/bash -x

CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

pushd ${CURRENT_DIR}

if [ ! -L ./tdiary.conf ]; then
   ln -s ${TDIARY_CONF_FILE} ./tdiary.conf
fi

if [ ! -e ./config.ru ]; then
   cat ./config.ru.org | sed -e "s!run TDiary::Application.new!run TDiary::Application.new('${TDIARY_BASE_DIR}')!" > config.ru
fi

bundle exec rake assets:copy
bundle exec puma --config puma_config.rb -e production
PUMA_RET=$?

popd

exit ${PUMA_RET}
