import os
import numpy as np
import matplotlib.pyplot as plt
import mne
import pandas as pd
import sklearn
from sklearn.preprocessing import MinMaxScaler
from tqdm import tqdm

from mne import io
from mne_connectivity import spectral_connectivity_epochs, seed_target_indices, spectral_connectivity_time, phase_slope_index, viz

def loadAdaptive(pathA):
    os.chdir(pathA)
    oslist = list(os.listdir())
    Adaptiverawlili = []
    for a in oslist:
        if a != "mne_connectivity":
            print(a)
            Adaptiverawlili.append(mne.io.read_raw_fif(a, preload = False))
    return Adaptiverawlili

def loadRandom(pathR):
    os.chdir(pathR)
    oslist = list(os.listdir())
    Randomrawlili = []
    for a in oslist:
        if a != "mne_connectivity":
            print(a)
            Randomrawlili.append(mne.io.read_raw_fif(a, preload = False))
    return Randomrawlili


#Set path to the FIF file folders
pathA = "C:\\Users\\scrat\\Desktop\\Matlabfiles\\adaptiveexcel\\AAAAdaptiveCleanFIF"
pathR = "C:\\Users\\scrat\\Desktop\\Matlabfiles\\randomexcel\\AAARandomCleanFIF"
Adaptiverawlili = loadAdaptive(pathA)
Randomrawlili = loadRandom(pathR)

#The participants can be indexed as follows:
print(Adaptiverawlili[0])
#Information about the participant can be accessed like this:
print(Adaptiverawlili[0].info)
#The data of the participant can be accessed by samples like this:
#The 250th sample will be taken here (after 1 second, given a sampling rate of 250hz)
print(Adaptiverawlili[0].time_as_index(250))
#We can also do this with an array. Here it will give the samples between 250 and 2500 (10 seconds of data starting after the first second)
print(Adaptiverawlili[0].time_as_index(list(range(250, 2500))))


#We can cut up the data into sections of 30 seconds through this:
#Note that preload = False is very important, otherwise your computer's ram is flooded
epochs = mne.make_fixed_length_epochs(Adaptiverawlili[0], duration=30, preload=False)

#This can be useful for the engagement analysis


#For connectivity measures, and their functions look here: https://mne.tools/mne-connectivity/stable/generated/mne_connectivity.Connectivity.html

#After the epochs have been made we can run a command for connectivity measures:
#Set which frequency range is interesting
freqs = list(range(4,20))
#Calculate PLV, or other measures such as Coh (Coherence), ciplv (Corrected imaginary plv), pli (Phase Lag Index), wpli (weighted Phase Lag Index)
plv = spectral_connectivity_time(epochs, freqs = freqs,  sfreq = 250, method = "plv")
#Can also do psi, to get an indication of the direction of information flow (whether fz is sending or receiving from PO7 for examle)
psi = phase_slope_index(epochs,  sfreq = 250)



#Note that we access the results of these functions through this command (converts it in numpy format)
print(psi.get_data())
