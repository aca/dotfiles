function korean-chk
  deno eval ( printf "let %s; console.log(JSON.stringify(data));" (curl -s 'http://speller.cs.pusan.ac.kr/results' --data "text1=$argv" | grep data | head -n 1) ) | jq .
end
