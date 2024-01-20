#### Install Different Versions of Python in Windows
https://stackoverflow.com/questions/57503997/windows-how-to-configure-multiple-versions-of-python-to-work-together
Configure multiple Python versions on Windows
Python 3.3 introduced the Python Launcher for Windows. Rather than using python.exe, call py and select the version with flags:

py -2.7
py -3
System-wide installations of Python 3.3 and later will put the launcher on your PATH.

Note on Virtual Environments (new in Python 3.5)
If the launcher is run with no explicit Python version specification, and a virtual environment (created with the standard library venv module or the external virtualenv tool) active, the launcher will run the virtual environment’s interpreter rather than the global one. To run the global interpreter, either deactivate the virtual environment, or explicitly specify the global Python version.

Outdated Method (not recommended)
Rename executables - After installing multiple versions, change the names of the executables. For example, for Python 2.7, under the installation folder, rename python.exe to python27.exe and rename Python 3.7 from python.exe to python37.exe. Then on the command line, select the version by entering python27 or python37. Whichever version is preferred, could be left as just python.
Add Path Environment Variables - For example, on Windows 10, go to the Windows menu and search for "environment variables" and click edit the system environment variables. In the System Properties dialog, click Environment Variables.... Under "System variables", select "Path". Click Edit.... Click New and add the first entry below. Click New again for each Path variable entry.
C:\Python27
C:\Python27\Scripts
C:\Python37
C:\Python37\Scripts


https://pypi.org/project/pyenv-win/1.1.2/