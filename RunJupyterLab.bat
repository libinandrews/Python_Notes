@echo off
REM Get the current directory
set "CURRENT_DIR=%cd%"

REM Check for any folder starting with ".venv"
set "VENV_PATH="
for /d %%i in (.venv*) do (
    set "VENV_PATH=%%i"
)

if defined VENV_PATH (
    echo Found virtual environment folder: %VENV_PATH%
    REM Activate the virtual environment
    call "%VENV_PATH%\Scripts\activate.bat"
) else (
    echo No virtual environment folder found. Please create one.
    goto :end
)

REM Check if pip is available
python -m pip --version > NUL 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo pip is not available. Ensure pip is installed in the virtual environment.
    goto :end
)

REM Update pip
echo Updating pip...
python -m pip install --upgrade pip

REM Check if Jupyter Lab is installed
python -c "import jupyterlab" > NUL 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Jupyter Lab is not installed. Installing now...
    python -m pip install --upgrade jupyterlab
) else (
    echo Jupyter Lab is installed. Upgrading to latest version...
    python -m pip install --upgrade jupyterlab
)

echo Starting Jupyter Lab...
jupyter lab

:end