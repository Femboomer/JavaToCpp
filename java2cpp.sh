#!/bin/bash
# If you're reading this, I'm probably already dead due to getting assassinated for coding badly. Or maybe not, who knows.
# Even if I am alive, I won't come back to fix it in case it ever breaks. I have lots of other useless projects to work on.
# You should not make scripts like this. I am not proud of it, but it works.
export java2cpp_tmp_path=$1
sed 's/^  /\0/' $java2cpp_tmp_path > java2cpp_tmp0.txt
echo -n '{"jsonText":' > java2cpp_tmp.txt
cat java2cpp_tmp0.txt | jq -Rsa '.' >> java2cpp_tmp.txt
echo -n "}" >> java2cpp_tmp.txt
curl -s -D - https://www.javainuse.com/java2cpp > java2cpp_tmp.html
cat java2cpp_tmp.html | grep -o -P '(?<=\_csrf\" value\=\").*(?=\" \/\>)' > java2cpp_csrf.txt
cat java2cpp_tmp.html | grep -o -P '(?<=Set-Cookie: ).*(?=; Path)' > java2cpp_cookie.txt
curl -H 'Referer: https://www.javainuse.com/java2cpp' -H 'Origin: https://www.javainuse.com' -H 'sec-ch-ua-platform: "Windows"' -H 'Sec-Fetch-Dest: empty' -H 'Sec-Fetch-Site: same-origin' -H 'Sec-Fetch-Mode: cors' -H 'sec-ch-ua: "Google Chrome";v="111", "Not(A:Brand";v="8", "Chromium";v="111"' -H "X-Requested-With: XMLHttpRequest" -H "Pragma: no-cache" -H "Sec-Fetch-Site: same-origin" -H "Cache-Control: no-cache" -H "Connection: keep-alive" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36" -H "Accept: */*" -H "Content-Type: application/json;charset=UTF-8" -H "X-CSRF-TOKEN: `cat java2cpp_csrf.txt`" -b "`cat java2cpp_cookie.txt`" --data "`cat java2cpp_tmp.txt`" -s "https://www.javainuse.com/java2cpp" > java2cpp_tmp.txt
cat java2cpp_tmp.txt | jq -r .[0]
rm java2cpp_tmp.html
rm java2cpp_tmp0.txt
rm java2cpp_tmp.txt
rm java2cpp_csrf.txt
rm java2cpp_cookie.txt
