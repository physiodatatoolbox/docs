---
title: Features
nav_order: 2
---

# PhysioData Toolbox 
{: .pdt-abstract-title }

The PhysioData Toolbox is a free easy-to-use and fully graphical application for visualizing, segmenting and analyzing physiological data.
{: .pdt-abstract-body}

---

<!--- TODO: Make showcase video  -->

{% comment %}
<video width="100%" controls loop=true>
  <source src="{{ site.url }}/{{ site.baseurl }}/assets/videos/pdt-demo-2018.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>
{% endcomment %}


# Overview #
The PhysioData Toolbox is designed to fullfil the following purposes:

 - **PhysioData file format:**  
    The Toolbox defines a standard MATLAB-based file format for managing physiological data and analyses (the PhysioData format).

 - **File Converter:**  
    A File Converter is included that easily converts various raw data formats into PhysioData files.

 - **Batch import of files:**  
    The Toolbox can import complete folders of PhysioData files and visualize their raw data.

 - **Batch preprocessing:**  
    Pre-built preprocessing pipelines are packaged as modules and can be easily configured and applied the imported files. See the current [modules](#modules).

 - **Visual inspection and artifact removal:**  
    All modules feature easy-to-use interfaces for reviewing the preprocessed data and manually removing artifacts.
    
 - **Automatic epoch generation:**  
    Epochs can be automatically generated using user-specified rules, which can reference markers and events inside the data file.

 - **Batch epoch analysis and resampling:**  
    The Toolbox can automatically summarize or resample all epochs in the imported files, and export the results for further statistical analysis.

# Session Manager #
The PhysioData Toolbox is operated using the Session Manager window, which can be used to import multiple files and apply user-specified analysis procedures to them. All files can then be analyzed simultaneously, and their results consolidated into a single table. Additionally, the session can be saved at any time and resumed afterwards. All analyses pipelines are fully parametric and non-destructive.

{% include image.html
    img="user-guide\session-manager\session-manager.png"
    title="Session Manager"
    id="session-manager-img"
    caption="The Session Manager, which is the main toolbox window. It manages the PhysioData files, the PhysioAnalyzers modules and the data export." %}

# Modules
The Toolbox features various modules, each containing an adjustable analysis pipeline specific to a certain data type. For the full documentation, see the [PhysioAnalyzer page](./user-guide/physioanalyzer-modules.html) in the User Guide.


## Generic Signal Analyzer 
Any generic signal, such as skin temperature, can be analyzed using the Generic Signal Analyzer module, which extracts standard descriptive statistics from the signal per epoch. Additionally, like most other modules, the Generic Signal Analyzer allows the user to perform basic signal correction and artifact rejection.

{% include image.html
    img="user-guide/physioanalyzers/physioanalyzer-gui-1.png"
    title= page.title
    caption="A Generic Signal Analyzer tagged HR, showing a heart-rate signal as calculated in real-time using AcqKnowledge." %} 

## ECG Signal Analyzer
The ECG Signal Analyzer module lets the user preprocess and analyze a raw ECG signal. It can extract various cardiac measures per epoch; such as, mean heart rate, HRV (RMSSD, pNN20 and pNN50), R-peak count, etc. Additionally, the module allows the user to correct misidentified R-peaks and erroneous Interbeat Intervals (IBIs).

{% include image.html
    img="user-guide/physioanalyzers/ecg-module-gui-1.png"
    title= page.title
    caption="The ECG Signal Analyzer interface, showing the raw and filtered ECG signals, the detected R-peaks, the IBIs and the instantaneous heart rate." %} 

## IBI Analyzer
The IBI Analyzer module performs heartbeat locked analysis around user-specified events, which can be used to calculate stimulus specific heart rate acceleration and deceleration.

{% include image.html
    img="user-guide/physioanalyzers/ibi-module-gui-1.png"
    title= page.title
    caption="The IBI Sequence Analyzer, showing IBIs -5 to 5 surrounding an event (red triangle)." %} 

## HRV Analyzer
The Heart Rate Variability (HRV) Analyzer retrieves corrected IBI data from a linked ECG module, detrends it, and performs epoch-based analyses to extract several time-domain, frequency-domain and non-linear HRV measures.

{% include image.html
    img="user-guide/physioanalyzers/hrv-module-gui-1.png"
    title= page.title
    caption="The HRV module's GUI. The top graph shows the epochs (green, blue and red rectangles), and the graph below that shows the IBI events (blue circles), the contiguous IBIs (blue line) and the global trend baseline (red line). The bottom left panel shows the name of the current epoch in the dropdown menu, and under it various metrics for that epoch. The bottom right panel shows collapsible graphs that visualize the: detrended IBIs; IBI successive differences; Poincaré plot; and Lomb-Scargle periodogram (for power analysis)." %} 

## ICG Ensemble Analyzer
The ICG Ensemble Analyzer module generates one ICG and one ECG ensemble waveform per epoch, and allows the user to score the necessary ICG landmarks.

{% include image.html
    img="user-guide/physioanalyzers/icg-ensemble-module-gui-1.png"
    title= page.title
    caption="The ICG Ensemble Analyzer (Manual Scoring) GUI, showing: the ICG signal and the R-peak times (top graph, labeled dZ/dt); the current epoch data (leftmost table); the ensemble ECG and ICG curves, as well as the individual waveforms (two center graphs); and, the individual waveform data (rightmost table)." %}

##  Blood Pressure Analyzer
Standard statistics regarding the systolic, diastolic and mean arterial blood pressures can be extracted using the Blood Pressure Analyzer module.

{% include image.html
    img="user-guide/physioanalyzers/bp-module-gui-1.png"
    title= page.title
    caption="The BP Analyzer GUI, showing the BP signals and the estimated pulse. Note the automatically detected calibration event around 1865 seconds." %} 

## Respiration Analyzer
The Respiration Analyzer lets the user preprocess and analyze a chest or abdomen expansion signal, generated by a force-transducer. The module calculates basic descriptive statistics for inhalation, exhalation, and breath phases, per epoch.

{% include image.html
    img="user-guide/physioanalyzers/resp-module-gui-1.png"
    title= page.title
    caption="The Respiration Module GUI." %} 

## EMG Analyzer
Filtered, rectified and smoothed EMG signals can be extracted from the raw EMG using the EMG Analyzer module, which outputs descriptive statistical analysis of all these derived signals.

{% include image.html
    img="user-guide/physioanalyzers/emg-module-gui-1.png"
    title= page.title
    caption="The EMG Signal Analyzer interface." %} 

## Skin Conductance Analyzer
The Skin Conductance Analyzer module extracts metrics about the skin conductance level (SCL), phasic activity, and Skin Conductance Responses (SCRs) per epoch.


{% include image.html
    img="user-guide/physioanalyzers/sc-module-gui-1.png"
    title= page.title
    caption="The Skin Conductance Analyzer GUI, showing the SCL (in axes labeled Skin Conductance) and the phasic channel (in the axes labeled Phasic SC)." %} 

## Pupil Diameter Analyzer
The Pupil Diameter Analyzer module features user-specifiable raw data filters and signal interpolation options, and exports a variety of pupil-size metrics.


{% include image.html
    img="user-guide/physioanalyzers/pupil-module-gui-1.png"
    title= page.title
    caption="The Pupil Diameter analyzer gui." %} 


## Area of Interest Hit Analyzer
With the Area of Interest Hit Analyzer, gaze data in the shape of area of interest hit data can be analyzed and metrics such as the total hit duration on an area of interest per epoch, can be obtained.


{% include image.html
    img="user-guide/physioanalyzers/aoi-module-gui-1.png"
    title= "Area of Interest Hit Analyzer"
    caption="The Area of Interest Hit GUI, showing the hit data per AoOI. In the current file there were four AOIs." %} 
