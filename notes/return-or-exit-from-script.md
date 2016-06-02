
You can't run a script that has a return, but you can exit from it:

```
if ! ./exit-one.sh; then
  echo "any non-zero exit will cause this line to evaluate"
fi
```

You can source a script that has an exit but it will exit the parent too

```
if ! source ./exit-one.sh; then
  echo "this line won't be evaluated since this script will stop too"
fi
```

You can retrun a non-zero int from a source script though

```
if ! source ./exit-one.sh; then
  echo "any non-zero return value will cause this line to evaluate"
fi
```
