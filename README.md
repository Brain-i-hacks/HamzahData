# HamzahData
Analysis of Hamzah's EEG stuff

## Raw EEG cleaning
### Step 1
Notch filter 50 hz

### Step 2

Basic FIR filter 
Low = 0.5 Hz
High = 30 Hz

### Step 3
Clean data by tools > clean Rawdata and ASR

### Step 4
Manual artefact removal by setting window to 30 seconds

### Step 5

Removed baseline

### Step 6

Rereferenced to average

### Step 7 

ICA


## CSV files
The csv files were separated in 4 groups:
- Adaptive condition first : first trial (Adaptive)
- Adaptive condition first: second trial (Random)

These files contain the EEG Engagement per second
You can check HamzahFilecleaning.ipynb to see what I did exactly
Though you may need the filestructure which is on drive: https://drive.google.com/drive/u/2/folders/12bCWViuPd49zXbTKDgxbzgu8_YZYNY6J

