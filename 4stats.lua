local _ = require"4all"
local the=_.options[[   
stats : report stats on data
(c) 2022 Tim Menzies <timm@ieee.org> BSD-2 license

Usage: lua stats.lua [Options]

Options:
 -f  --file    file with csv data = ../data/diabetes.csv
 -g  --go      start-up example   = nothing
 -h  --help    show help          = false
 -s  --seed    random number seed = 937162211

Worked example: github.com/4orc/4stats/stats.lua

Install: download to the same directory from github.com/4orc,
         4orc/4orc.lua, stats/4stats.lua,  4stats/stats.lua]]

local csv, lt, map,many = _.csv, _.lt, _.map, _.many
local obj, oo, push = _.obj, _.oo, _.push
local rnd, same,sort,slice =  _.rnd, _.same,_.sort, _.slice
local COLS,DATA,NUM,SYM=obj"COLS",obj"DATA",obj"NUM",obj"SYM"
----------------------------------------------------------------
-- `SYM`s summarize streams of symbols.
function SYM:new(  n,s) --> SYM; for summarizing list of symbols
  self.n= 0                       -- items seen
  self.at=n or 0                 -- column position
  self.name=s or ""              -- column name
  self.mode, self.most = nil, -1 -- keep most common symbol
  self.has= {} end               -- column name

function SYM:add(x) --> nil; add `x` to `self`, updating mode
  if x~="?" then 
    self.n = self.n+1 
    self.has[x] = 1 + (self.has[x] or 0) 
    if self.has[x] > self.most then
      self.mode, self.most = x, self.has[x] end end end

function SYM:mid(col) return self.mode end --> n; return the mode

function SYM:div() --> n; return entropy
  local function fun(p) return p*math.log(p,2) end
  local e=0; for _,n in pairs(self.has) do if n>0 then e=e-fun(n/self.n) end end
  return e end 
-----------------------------------------------------------------
-- `NUM`s summarize streams of numbers.
function NUM:new(  n,s) --> NUM;  for summarizing list of numbers
  self.n    = 0                -- items seen     
  self.at   = n or 0           -- column position
  self.name = s or ""          -- column name
  self.mu,self.m2 = 0,0
  self.lo   =  math.huge       -- lowest seen
  self.hi   = -math.huge  end  -- highest seen

function NUM:add(x,    pos) --> nil; add `x` to `self`
  if x~="?" then 
    self.n = self.n + 1
    self.lo= math.min(x, self.lo)
    self.hi= math.max(x, self.hi) 
    local d= x - self.mu
    self.mu= self.mu + d/self.n
    self.m2= self.m2 + d*(x - self.mu)
    self.sd= ((self.n<2 or self.m2<0) and 0) or (self.m2/(self.n-1))^0.5 end end

function NUM:mid() return self.mu end --> n; return the mean
function NUM:div() return self.sd end --> n; return entropy
 ------------------------------------------------------------
-- `COLS` is a factory that makes `SYM`s or `NUM`s (controlled by row1 of data)
function COLS:new(sNames) --> COLS; creator of column headers
  self.names=sNames -- all column names
  self.all={}      -- all the columns (including the skipped ones)
  self.klass=nil   -- the single dependent klass column (if it exists)
  self.x={}        -- independent columns (that are not skipped)
  self.y={}        -- dependent columns (that are not skipped)
  for c,s in pairs(sNames) do
    local col = push(self.all, (s:find"^[A-Z]" and NUM or SYM)(c,s))
    if not s:find"X$" then -- some columns are skipped
       push(s:find"[!+-]" and self.y or self.x, col) -- some cols are goal cols
       if s:find"!$" then self.klass=col end end end end
--------------------------------------------------------
-- `DATA` stores rows, summarized in `NUM` or `SYM` columns.
function DATA:new(src) --> DATA; store `rows` summarized (in `cols`). `src`=file name or table
  self.cols = nil -- summaries of data
  self.rows = {}  -- kept data
  local function add(row) return self:add(row) end
  if type(src) == "string" then csv(src, add) else map(src or {}, add) end end 

function DATA:add(xs) --> nil; for first row, make `cols`. else add to `rows` and summarize
 if   not self.cols 
 then self.cols = COLS(xs) 
 else local row= push(self.rows, xs) 
      for _,todo in pairs{self.cols.x, self.cols.y} do
        for _,col in pairs(todo) do 
          col:add(row[col.at]) end end end end

function DATA:stats(  places,showCols,fun,    t,v)
  showCols, fun = showCols or self.cols.y, fun or "mid"
  t={}; for _,col in pairs(showCols) do 
          v=getmetatable(col)[fun](col)
          v=type(v)=="number" and rnd(v,places or 3) or v
          t[col.name]=v end; return t end
------------------------------------------
return {the=the, DATA=DATA, NUM=NUM, SYM=SYM, COLS=COLS} 
