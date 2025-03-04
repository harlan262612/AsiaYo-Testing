#!/bin/bash  
### grep the most count string in words.txt
## 去掉標點符號>全部轉換成小寫>空格轉換行字元>排列後去重取第一位
result=$(tr -d '[:punct:]' < words.txt | tr '[:upper:]' '[:lower:]'| tr ' ' '\n' | sort | uniq -c | sort -nr | head -n 1)  

echo "$result"  
