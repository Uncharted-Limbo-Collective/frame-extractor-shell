@echo off

echo -------------------------------------------------
echo ----- Frame_Extractor_By_George_Adamopoulos -----
echo -------------------------------------------------
echo.

timeout 1 > nul
echo Hello Friend.
timeout 1 > nul

cd C:\Program Files (x86)\VideoLAN\VLC

rem Asks user for a video file. If the video file is invalid, it tries again.
:AskForFile
set /p _filePath= Please drag the video file you want to extract frames from, and press Enter...

rem Remove quotes
set _filePath=%_filePath:"=%

if exist "%_filePath%" (
  echo.
  echo Good.
  echo.
  timeout 1 > nul
  goto AskForFolder
) else (
  echo.
  echo You did not give me a file, but something else, that I don't want at all.
  goto AskForFile
)

rem Asks user for a folder. If the folder is invalid, it tries again.
:AskForFolder
set /p _framesPath= Please drag the folder that you want the images to be saved in, and press Enter...

rem Remove quotes
set _framesPath=%_framesPath:"=%

if exist "%_framesPath%" (
  echo.
  echo Good.
  echo.
  timeout 1 > nul
  goto AskForInterval
) else (
  echo.
  echo You did not give me a folder, but something else, that I don't want at all.
  goto AskForFolder
)



rem Asks user for an integer. If the integer is invalid, it tries again.
:AskForInterval
set /p _frameInterval= We will capture 1 frame every [...] frames (5 is a good number)...
echo %_frameInterval%| findstr /r "^[1-9][0-9]*$">nul

IF %errorlevel% equ 0 (
  goto Extracting
) else (
  echo.
  echo You did not give me a number, but something else, that I don't want at all.
  goto AskForInterval
)


rem Starts extracting after 3 seconds.
:Extracting
echo.

echo All good! We will start in:
echo ...3...
timeout 1 > nul
echo ...2...
timeout 1 > nul
echo ...1...
timeout 1 > nul
echo Extracting!
timeout 1 > nul

vlc.exe "%_filePath%" --vout=any --quiet --video-filter=scene --scene-format=jpg --scene-ratio=%_frameInterval% --scene-path="%_framesPath%" --play-and-exit

rem Goodbye message.
echo.
echo Finished extracting. This window will safely self-destruct in:
timeout 1 > nul
echo ...3...
timeout 1 > nul
echo ...2...
timeout 1 > nul
echo ...1...
timeout 1 > nul
echo Bye!
echo.
timeout 1 > nul
