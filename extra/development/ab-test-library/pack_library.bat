@echo off
echo **************************************************
echo Compressing JavaScript...
echo **************************************************

SET yuicompressor=java -jar yuicompressor-2.4.8.jar 

copy /b header.js + xregexp.js + html.js + library.js library_tmp.js

for %%d in ("library_tmp.js", "nadapter.js") do (
  %yuicompressor% --line-break 0 -o "%%~nd.min.js" "%%d"
  echo -------------------------------------
  echo %%~nxd was %%~zd bytes
  for %%a in (%%~nd.min.js) do echo and now it is %%~za bytes
)

for /D %%d in ("..\ab-stark-typical-provider\"      ^
      "..\ab-typical-provider\"                     ^
      "..\ab-nadapter-typical-provider\"            ^
      "..\ab-test-rand\"                            ^
      "..\"                                         ^
      ) do (
  copy /Y library_tmp.min.js %%~pdlibrary.js
)

for /D %%d in ("..\"								^
      "..\ab-nadapter-typical-provider\"            ^
	  ) do (
  copy /Y nadapter.min.js "%%~pd"nadapter.js
)

del *.min.js
del *_tmp.js
