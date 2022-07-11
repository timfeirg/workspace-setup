IFS='
'
for n in `workon`
do
  PYTHON=/Users/timfeirg/.virtualenvs/$n/bin/python
  $PYTHON -c 'import sys'
  exit_code=$?
  if [ $exit_code -ne 0 ]
  then
    echo "removing virtualenv $n"
    rmvirtualenv $n
  fi
done
