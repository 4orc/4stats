#!/usr/bin/env lua
-- Test engine and examples.
-- (c)2022 Tim Menzies <timm@ieee.org> BSD2
local _  = require"4all"
local cli,oo,rand,rint,rnd = _.cli, _.oo, _.rand, _.rint, _.rnd
local run,sort,srand    = _.run, _.sort, _.srand

local _ = require"4stats"
local the,NUM,SYM,DATA = _.the, _.NUM, _.SYM, _.DATA

local eg={}

function eg.dists()
  local data =DATA("../data/auto93.csv")
  oo(data:stats()) end
--------------------------------------------------------
the = cli(the)
os.exit(run(the,eg)) 
