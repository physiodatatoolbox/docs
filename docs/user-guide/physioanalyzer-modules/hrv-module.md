---
title: HRV Analyzer
layout: default
nav_order: 40
parent: PhysioAnalyzers
grand_parent: User Guide
classname: HRV_Module
---

# {{ page.title }}
{: .pdt-abstract-title, .no_toc}

The HRV Analyzer calculates basic HRV (Heart Rate Variability) statistics for each epoch.
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Introduction
The **HRV Analyzer** retrieves corrected IBI (Inter Beat Interval) data from a linked ECG module, detrends it, and performs epoch-based analyses to extract several time-domain, frequency-domain and non-linear HRV measures.

{% include image.html
    img="user-guide/physioanalyzers/hrv-module-gui-1.png"
    title= page.title
    id="gui-1"
    caption="The HRV module's GUI. The top graph shows the epochs (green, blue and red rectangles), and the graph below that shows the IBI events (blue circles), the contiguous IBIs (blue line) and the global trend baseline (red line). The bottom left panel shows the name of the current epoch in the dropdown menu, and under it various metrics for that epoch. The bottom right panel shows collapsible graphs that visualize the: detrended IBIs; IBI successive differences; Poincaré plot; and Lomb-Scargle periodogram (for power analysis)." %} 

The two topmost graphs of the HRV module visualize the epochs, the IBI data that were retrieved from the ECG module and---if enabled---the global trend baseline. Below those are two panels labeled **Epoch Data and Results** and **Epoch Specific Plots**, which show the analysis results and plots of the selected epoch.

The time-domain, frequency-domain, and non-linear results are visualized for the current epoch in the GUI's two bottom panels. Users can navigate to another epoch by selecting it from the dropdown menu in the Epoch Data and Results panel, or by clicking the buttons next to it. Additionally, epochs can be selected by clicking on the epoch rectangles in the epoch graph.

# User Corrections #
The HRV module itself does not allow users to correct artifacts, this must instead be done in the linked ECG module. Any changes made to the IBIs in the linked ECG module are automatically transmitted to the HRV module, and the graphs and results table are automatically updated.

---

# HRV Analyses #
The HRV module performs a collection of time-domain, frequency-domain and non-linear analyses on detrended IBIs located within a specific epoch. See the [Metrics](#metics) section for a full overview of the output.

## Time-Domain Analysis ##
The HRV module extracts the following standard time-domain metrics from the detrended IBI data:

 - Percentage of absolute differences between successive IBIs that exceed 20 ms (pNN20) and 50 ms (pNN50).

 - IBI standard deviation.

 - Root Mean Squared of Successive Differences (RMSSD).

The RMSSD and the successive IBI differences from which it was calculated are visualized in the module's **Successive Differences** graph in the Epoch Specific Plots panel.

{% include image.html
    img="user-guide/physioanalyzers/hrv-module-gui-detrended-rmssd.png"
    title= "Detrended IBIs and RMSSD"
    id="gui-detrend-rmssd"
    no_shadow = true
    caption="The detrended epoch-specific IBIs (top) and the differences between them (bottom). For visualization purposes, the heart rate acceleration events are plotted in pink and the heart rate deceleration events in aquamarine. Note that a heart rate acceleration is defined as an increase in heart rate, which equals a decrease in inter beat interval." %} 

## Frequency-Domain Analysis ##
The **Lomb-Scargle** method is used to estimate the IBI time-series' Power Spectral Density (PSD), from which the Very Low Frequency (VLF), Low Frequency (LF), and High Frequency (HF) powers are computed.

{% include image.html
    img="user-guide/physioanalyzers/hrv-module-ls.png"
    title= "Lomb-Scargle Periodogram"
    id="ls-1"
    no_shadow = true
    caption="A Power Spectral Density estimate computed using the Lomb-Scargle  periodogram method. The Very Low, Low and High Frequency bands are visualized in purple, red and green, respectively." %}

## Non-Linear Analysis ##
The HRV module generates a Poincaré plot for the non-linear analysis of HRV. A **Poincaré plot** is a scatter plot where each IBI (IBI<sub>n</sub>) is plotted against the subsequent IBI (IBI<sub>n+1</sub>), with the former and latter representing the horizontal and vertical axes, respectively. The Poincaré plot refers to IBIn and IBIn+1 as RR<sub>n</sub> and RR<sub>n+1</sub> in order to better comply with convention.

{% include image.html
    img="user-guide/physioanalyzers/hrv-module-pp.png"
    title= "Poincaré Plot"
    id="PP-1"
    no_shadow = true
    caption="A Poincaré plot showing IBI<sub>n</sub> vs IBI<sub>n+1</sub> points. Heart rate accelerations are plotted in pink, while decelerations are plotted in aquamarine. The ellipses represent 1, 2 and 3 times SD1 and SD2; i.e., the spread perpendicular to and along the identity line." %}

---

# Processing and Analysis Pipeline
The data processing and analysis pipeline used by the HRV module is described below:

## Step 1: IBI sourcing and Global Detrending ##
The corrected IBIs from the linked ECG module are retrieved. If enabled by the user, the IBI trend is then calculated by first resampling the IBIs at 4 Hz, and then using the smoothness priors approach [^1] and the user-specified lambda value to compute the trend baseline.

{% include image.html
    img="user-guide/physioanalyzers/hrv-module-detrending-filter.png"
    title= "Lambda"
    id="lambda-1"
    no_shadow = true
    caption="The high-pass cutoff frequency of the smoothness priors detrending filter as a function of lambda (&#955;), as computed for a 10 minute epoch." %}

## Step 2: Epoch Segmentation and Detrending ##
The epoch-specific IBIs are isolated by copying all IBIs and rejecting those located outside of the current epoch, with the 'IBI location' for a given IBI event being defined as the timestamp of the R-peak that ends that inter beat interval.

If smoothness priors detrending is enabled by the user, the epoch-specific IBIs are detrended by subtracting from each IBI its corresponding trend baseline value, as visualized by the red line in the IBI graphs. The epoch-specific IBIs are then also linearly detrended. This is done subsequent to the smoothness priors detrending, or in absence of it if that is disabled.

All subsequent steps are performed on the epoch-specific detrended IBIs unless otherwise specified.

## Step 3: Calculating Time-Domain Metrics ##
First, the standard deviation of the IBIs is calculated, which gets reported as the **IBI_std_detrended** metric. Because the detrended IBIs are used, this standard deviation should be less than the standard deviation calculated by the ECG module, which uses the actual non-detrended IBIs.

Subsequently, the detrended IBIs that are 'contiguous'---i.e., directly adjacent to each other---are identified and used to calculate the successive differences. The root mean squared of these differences is then calculated and reported as **RMSSD_detrended**. This metric is also calculated by the ECG Signal Analyzer module, but from the non-detrended IBIs. However, since RMSSD is not strongly influenced by slower IBI oscillations, the RMSSDs reported by both modules should not differ substantially.

Additionally, the fraction of absolute successive differences that exceed 20 and 50 ms are calculated and reported as a percentage in **pNN20_detrended** and **pNN50_detrended** respectively. 

## Step 4: Calculating Frequency-Domain Metrics ##
First, the PSD of the detrended IBI time-series is estimated using MATLAB's implementation of the Lomb-Scargle periodogram and a frequency resolution of 0.0001 Hz. An error is thrown if the epoch does not feature enough IBIs to resolve the required frequency range. If enabled in the module's settings, the PSD is then smoothed using a 'loess' filter and the specified span. Any negative PSD values that may result from the smoothing are set to 0. 

The band powers are then calculated from the smoothed PSD for the following ranges, adjustable in the module's settings: 
 - **Very Low Frequency (VLF):**  
    0.0033  – 0.04 Hz. 
 - **Low Frequency (LF):**  
    0.04  – 0.15 Hz.
 - **High Frequency (HF):**  
    0.15  – 0.4 Hz.

By default, the detrending lambda is set to 500, which equals an approximate high-pass cutoff frequency of 0.04 Hz given the resampling frequency of 4 Hz. This strongly attenuates the VLF power, so analyzing sub 0.04 Hz frequencies may require that either the smoothness priors detrending be disabled or that the lambda be increased. 

The absolute powers are reported in ms<sup>2</sup> as the metric **XF_power**, where XF is either VLF, LF or HF. Additionally, the percentages of each power band as a fraction of the total power is reported in the  **XF_powerPercent** metric.

For each of the VLF, LF, and HF bands, the highest peak is detected and its value and frequency are logged. These data are exported as **XF_psdPeak** and **XF_psdPeakFreq**, respectively. No data is exported for a certain band if that band does not contain a peak.

## Step 5: Poincaré Analysis ##
To generate the Poincaré plot, all the epoch-specific IBIs that have a directly subsequent IBI are identified. These IBIs are labeled IBIn and their subsequent IBIs are labeled IBI<sub>n+1</sub>. The Poincaré plot is then generated by plotting IBIn against IBI<sub>n+1</sub>, with the former and latter representing the horizontal (X) and vertical (Y) axes, respectively.

A diagonal identity line (X = Y) is then generated, and the standard deviations of the Poincaré data-points is calculated in the direction of the identity line (SD2) and in the direction perpendicular to it (SD1). 
Depending on the module's **Poincaré plot IBI source** setting, either the original IBIs or the detrended IBIs are used.

---

# Settings
The HRV must be linked to an ECG module in order for it to function. This is done by filling in the tag of the ECG module in the **Tag of the ECG Analyzer** field.

The auto-generated list below shows the settings available in the {{ page.title }} module:

{% include module-settings.html %}

---

# Metrics
The auto-generated table below lists all the metrics produced by the {{ page.title }} module.

{% include metrics-table.html id="metrics" %}


---
# References #

[^1]: Tarvainen, M. P., Ranta-Aho, P. O., & Karjalainen, P. A. (2002). An advanced detrending method with application to HRV analysis. IEEE Transactions on Biomedical Engineering, 49, 172-175. doi: 10.1109/10.979357