#!/usr/bin/env -S deno run -A

import {
  Cookie,
  CookieJar,
  wrapFetch,
} from "https://deno.land/x/another_cookiejar@v5.0.3/mod.ts";

const fetch = wrapFetch();

type torrent_info = {
  magnet_uri: string;
  completion_on: string;
  name: string;
  hash: string;
};

export class ResponseError extends Error {
  override name: "ResponseError" = "ResponseError";
  constructor(public response: Response, msg?: string) {
    super(msg);
  }
}

const res = await fetch("http://localhost:4321/api/v2/auth/login", {
  body: "username=admin&password=adminadmin",
  headers: {
    "Content-Type": "application/x-www-form-urlencoded",
  },
  method: "POST",
});
// const res = await fetch("https://httpbin.org/status/300");
if (!res.ok) {
  throw new ResponseError(
    res,
    `Response returned an error code, ${res.status}`,
  );
}

const cookies = res.headers.get("set-cookie");
if (!cookies) {
  throw new Error("set-cookie not found");
}

const headers = new Headers();
headers.set("Cookie", cookies); // get from jar
console.log(cookies);
// const setCookieHeaders = [...headers.entries()].filter(([k]) => k === 'set-cookie').map(([k, v]) => v);

const res_info = await fetch("http://localhost:4321/api/v2/torrents/info", {
  headers,
});
const res_body = await res_info.json();
const completed = await res_body.filter((x: torrent_info) => {
  return x.completion_on != "-32400" && !x.magnet_uri.includes("ab.site");
  // return true
});

for (const c of completed) {
  console.log(c.hash, c.name);
  // const res = await fetch(
  //   `http://localhost:4321/api/v2/torrents/recheck?hashes=${c.hash}`,
  //   { headers, method: "POST" },
  // );
  // if (!res.ok) {
  //   throw new ResponseError(
  //     res,
  //     `Response returned an error code in recheck ${res.status}`,
  //   );
  // }

  const res2 = await fetch(`http://localhost:4321/api/v2/torrents/delete`, {
    headers,
    method: "POST",
    body: `hashes=${c.hash}&deleteFiles=false`,
  });
  if (!res2.ok) {
    console.log(res2.ok);
    throw new ResponseError(
      res,
      `Response returned an error code in delete ${res2.status}`,
    );
  }
}

// await completed.forEach((x: torrent_info) =>
//   const res_info = await fetch(`http://localhost:4321/api/v2/torrents/recheck?hashes=${x.hash}`, { headers });
// );

// http://localhost:4321/api/v2/torrents/info
// /api/v2/torrents/recheck?hashes=8c212779b4abde7c6bc608063a0d008b7e40ce32|54eddd830a5b58480a6143d616a97e3a6c23c439
