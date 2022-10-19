#!/usr/bin/env lua
-- Test engine and examples.
-- (c)2022 Tim Menzies <timm@ieee.org> BSD2
local _  = require"4all"
local cli,fmt,o,rand,rint,rnd = _.cli, _.fmt,_.o, _.rand, _.rint, _.rnd
local run,sort,srand    = _.run, _.sort, _.srand

local _ = require"4stats"
local the,DATA = _.the, _.DATA

local eg={}

function eg.dists()
  local data =DATA("../data/auto93.csv")
  for _,cols in pairs{"x", "y"} do
     print""
     for _,fun in pairs{"mid","div"} do
        print(fmt("%s %s %s",cols,fun, 
              o(data:stats(2,data.cols[cols],fun)))) end end end 
--------------------------------------------------------
the = cli(the)
os.exit(run(the,eg)) 
