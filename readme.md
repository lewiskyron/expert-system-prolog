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
python3 -m venv env
```

### Activate the virtual environment

```bash
source env/bin/activate
```

## Installing Requirements

```bash
pip install -r requirements.txt
```

## Run the expert program

```bash
python main.py
```
