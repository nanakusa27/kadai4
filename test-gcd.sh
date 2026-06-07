#!/bin/bash

tmp=/tmp/$$

echo "ERR: 引数が2つではない" > $tmp-err_args
echo "ERR: 引数が数値ではない" > $tmp-err_num
echo "ERR: 引数の数値が1以上ではない" > $tmp-err_nat

# ERROR関数
ERROR_EXIT () {
  echo "$1" >&2
  rm -f $tmp-*
  exit 1
}

TARGET="./gcd.sh"

# 異常系

# test1: 引数の数が不足
$TARGET 2> $tmp-ans && ERROR_EXIT "error in test1-1"
diff $tmp-ans $tmp-err_args || ERROR_EXIT "error in test1-2"

# test2: 引数の数が多い
$TARGET 12 18 30 2> $tmp-ans && ERROR_EXIT "error in test2-1"
diff $tmp-ans $tmp-err_args || ERROR_EXIT "error in test2-2"

# test3: 文字列
$TARGET 12 abc 2> $tmp-ans && ERROR_EXIT "error in test3-1"
diff $tmp-ans $tmp-err_num || ERROR_EXIT "error in test3-2"

# test4: 小数
$TARGET 1.5 5 2> $tmp-ans && ERROR_EXIT "error in test4-1"
diff $tmp-ans $tmp-err_num || ERROR_EXIT "error in test4-2"

# test5: 0
$TARGET 12 0 2> $tmp-ans && ERROR_EXIT "error in test5-1"
diff $tmp-ans $tmp-err_nat || ERROR_EXIT "error in test5-2"

# test6: 負の数
$TARGET -12 6 2> $tmp-ans && ERROR_EXIT "error in test6-1"
diff $tmp-ans $tmp-err_nat || ERROR_EXIT "error in test6-2"


# 正常系

# test7: 互いに素な数
echo "1" > $tmp-expected
$TARGET 13 8 > $tmp-ans 2>&1 || ERROR_EXIT "error in test7-1"
diff $tmp-ans $tmp-expected || ERROR_EXIT "error in test7-2"

# test8: 一方が他方の約数
echo "6" > $tmp-expected
$TARGET 24 6 > $tmp-ans 2>&1 || ERROR_EXIT "error in test8-1"
diff $tmp-ans $tmp-expected || ERROR_EXIT "error in test8-2"

# test9: 通常
echo "6" > $tmp-expected
$TARGET 12 18 > $tmp-ans 2>&1 || ERROR_EXIT "error in test9-1"
diff $tmp-ans $tmp-expected || ERROR_EXIT "error in test9-2"

# test10: 同じ数
echo "55" > $tmp-expected
$TARGET 55 55 > $tmp-ans 2>&1 || ERROR_EXIT "error in test10-1"
diff $tmp-ans $tmp-expected || ERROR_EXIT "error in test10-2"

echo "all ok"

# 後始末
rm $tmp-*
