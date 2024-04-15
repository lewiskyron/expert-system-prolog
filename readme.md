# Setting Up SWI-Prolog and PySwip on Mac

This guide will help you set up SWI-Prolog on your Mac using Homebrew, install PySwip using pip, set up a virtual Python environment, and run a Python script named `main.py`.

## Prerequisites

- SWI-Prolog
- Python 3
- PySwip

## 1. Installing SWI-Prolog

Open your terminal and execute the following command to install SWI-Prolog using Homebrew:

```bash
brew install swi-prolog
```

## 2. Creating a virtual environment

### Navigate to your project directory

cd path/to/your/project

### Create a virtual environment named 'env' (or any other name you prefer)

```bash
python -m venv env
```

### Activate the virtual environment

```bash
source env/bin/activate
```

## Installing Requirements

```bash
pip install -r requirements.txt
```

### Error correction 
If everything runs fine you should see an error aboaut some variables not being instantiated properly. This is a versioning issue and to solve open the venv folder created, open the pyswip folder within it and open the core.py file there. 
Ctlr + F for PL_version
and change the line for the one below. 
```bash
PL_version = _lib.PL_version_info
```

## Alternative running environment 
If that does not work don't worry. You can still run the program on google colab just click on the link below.
https://colab.research.google.com/drive/1df2BEAbkGOvDMcXBsttCZO5H0anWZje9?usp=sharing <br/>
All you need to do is upload the study_KB.pl into colab and the program should work as expected.

## Run the expert program
```bash
python main.py
```


### Error correction 
If everything runs fine you should see an error aboaut some variables not being instantiated properly. This is a versioning issue and to solve open the venv folder created, open the pyswip folder within it and open the core.py file there. 
Ctlr + F for PL_version
and change the line for the one below. 
```bash
PL_version = _lib.PL_version_info
```


