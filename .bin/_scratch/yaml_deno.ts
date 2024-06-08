#!/usr/bin/env -S deno run -A

import {
  parse as yamlParse,
  parseAll as yamlParseAll,
  stringify as yamlStringify,
} from "https://deno.land/std@0.82.0/encoding/yaml.ts";

const env = Deno.env.toObject()
const cfgString = await Deno.readTextFile(`${env.HOME}/.config/alacritty/alacritty.yml`)
const cfg = yamlParse(cfgString)

console.log(yamlStringify(cfg, { lineWidth: -1}))
