# 4stats
#	4stats.lua	

`SYM`s summarize streams of symbols.	

| What | Notes |
|:---|:---|
| <b>SYM:new(  n:`num`?, s:`str`?) &rArr;  SYM</b> |  for summarizing list of symbols |
| <b>SYM:add(x) &rArr;  nil</b> |  add `x` to `self`, updating mode |
| <b>SYM:mid(col) &rArr;  n</b> |  return the mode |
| <b>SYM:div() &rArr;  n</b> |  return entropy |


`NUM`s summarize streams of numbers.	

| What | Notes |
|:---|:---|
| <b>NUM:new(  n:`num`?, s:`str`?) &rArr;  NUM</b> |   for summarizing list of numbers |
| <b>NUM:add(x) &rArr;  nil</b> |  add `x` to `self` |
| <b>SYM:mid() &rArr;  n</b> |  return the mean |
| <b>SYM:div() &rArr;  n</b> |  return entropy |


`COLS` is a factory that makes `SYM`s or `NUM`s (controlled by row1 of data)	

| What | Notes |
|:---|:---|
| <b>COLS:new(sNames:`(str)+`) &rArr;  COLS</b> |  creator of column headers |


`DATA` stores rows, summarized in `NUM` or `SYM` columns.	

| What | Notes |
|:---|:---|
| <b>DATA:new(src:`str`) &rArr;  DATA</b> |  store `rows` summarized (in `cols`). `src`=file name or table |
| <b>DATA:add(xs:`tab`) &rArr;  nil</b> |  for first row, make `cols`. else add to `rows` and summarize |



#	4stats.lua	

`SYM`s summarize streams of symbols.	

| What | Notes |
|:---|:---|
| <b>SYM:new(  n:`num`?, s:`str`?) &rArr;  SYM</b> |  for summarizing list of symbols |
| <b>SYM:add(x) &rArr;  nil</b> |  add `x` to `self`, updating mode |
| <b>SYM:mid(col) &rArr;  n</b> |  return the mode |
| <b>SYM:div() &rArr;  n</b> |  return entropy |


`NUM`s summarize streams of numbers.	

| What | Notes |
|:---|:---|
| <b>NUM:new(  n:`num`?, s:`str`?) &rArr;  NUM</b> |   for summarizing list of numbers |
| <b>NUM:add(x) &rArr;  nil</b> |  add `x` to `self` |
| <b>SYM:mid() &rArr;  n</b> |  return the mean |
| <b>SYM:div() &rArr;  n</b> |  return entropy |


`COLS` is a factory that makes `SYM`s or `NUM`s (controlled by row1 of data)	

| What | Notes |
|:---|:---|
| <b>COLS:new(sNames:`(str)+`) &rArr;  COLS</b> |  creator of column headers |


`DATA` stores rows, summarized in `NUM` or `SYM` columns.	

| What | Notes |
|:---|:---|
| <b>DATA:new(src:`str`) &rArr;  DATA</b> |  store `rows` summarized (in `cols`). `src`=file name or table |
| <b>DATA:add(xs:`tab`) &rArr;  nil</b> |  for first row, make `cols`. else add to `rows` and summarize |


