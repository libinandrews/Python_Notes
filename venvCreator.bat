@echo off
setlocal enabledelayedexpansion

REM Get current directory
set "CURRENT_DIR=%cd%"

REM Check if `.venv` exists
if exist "%CURRENT_DIR%\.venv\" (
    echo ".venv" folder found. Activating virtual environment...
    call "%CURRENT_DIR%\.venv\Scripts\activate.bat"
    goto :EOF
)

REM Try to find Python in PATH
set "found_python="
for /f "tokens=*" %%A in ('where python 2^>nul') do (
    set "found_python=%%A"
)

if defined found_python (
    echo Found Python at: !found_python!
    REM Get version
    for /f "usebackq tokens=*" %%v in (`"!found_python!" -V 2^>nul`) do (
        set "py_version=%%v"
        echo Using Python version: !py_version!
    )
    set "PYTHON_EXE=!found_python!"
) else (
    echo No Python found in system PATH.
    echo Please enter the full path to the Python executable (e.g., C:\Python39\python.exe)
    set /p "PYTHON_EXE=Path: "
    REM Optional: Validate the path exists
    if not exist "%PYTHON_EXE%" (
        echo The specified path does not exist or is not valid. Exiting.
        goto :EOF
    )
    REM Get version
    for /f "usebackq tokens=*" %%v in (`"%PYTHON_EXE%" -V 2^>nul`) do (
        set "py_version=%%v"
        echo Using Python version: !py_version!
    )
)

REM Now proceed to create a virtual environment
echo Creating virtual environment...
"%PYTHON_EXE%" -m venv "%CURRENT_DIR%\.venv"

REM Activate the virtual environment
echo Activating virtual environment...
call "%CURRENT_DIR%\.venv\Scripts\activate.bat"
echo Virtual environment created and activated: .venv

exit /b