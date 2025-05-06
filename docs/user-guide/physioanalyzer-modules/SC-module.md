---
title: Skin Conductance Analyzer
layout: default
nav_order: 100
parent: PhysioAnalyzers
grand_parent: User Guide
classname: SC_Module
---


# {{ page.title }}
{: .pdt-abstract-title, .no_toc}

Preprocesses a Skin Conductance signal, and extracts tonic and phasic components, as well as SCRs (Skin Conductance Responses).
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Introduction
The **Skin Conductance Analyzer** can be used to: processes **Skin Conductance Level (SCL)** data; extract **Tonic** and **Phasic** SCL components; and, detect and analyze **Skin Conductance Responses (SCRs)**.

{% include image.html
    img="user-guide/physioanalyzers/sc-module-gui-1.png"
    title= page.title
    id="gui-1"
    caption="The Skin Conductance Analyzer GUI, showing the SCL (in axes labeled Skin Conductance) and the phasic channel (in the axes labeled Phasic SC)." %} 

---

# User Corrections #
The Skin Conductance Analyzer features the same correction method as the [Generic Signal Analyzer](./physioanalyzer.html#user-corrections); i.e., sections of the raw signal can be marked for exclusion and interpolation. Due to the way the tonic signal is measured---with a moving minimum filter---it is imperative to remove dipping artifacts, such as those caused by electrode disconnection. See the [Basic Tutorial](../../tutorial/basics.html#correcting-the-sc-data) for more information.

## SCR Corrections
Additionally, the module includes the ability to add zones in which SCR detection is disabled; referred to as **SCR rejection** zones. These zones, visualized as red rectangles in the second graph from the top, have two effects:

 - **SCR removal:**  
    If an SCR onset or peak lies within the SCR-rejection zone, that SCR is removed.

 - **Inflection point removal:**  
    If an inflection point lies within the SCR-rejection zone, it is removed. This effectively merges the SCRs that were split by the inflection zone, see [Figure](#correction-3) below.


{% include image.html
    img="user-guide/physioanalyzers/sc-module-inflection-correction.png"
    title= "SCR Correction"
    id="correction-3"
    no_shadow = true
    caption="Inserting an 'SCR rejection' zone over an inflection point causes the Toolbox to merge bordering SCRs." %} 

---

# Processing and Analysis Pipeline
The Skin Conductance module uses the following terminology.

 - **SCL:**  
 The SCL (Skin Conductance Level) refers to the low pass filtered Skin Conductance signal; i.e. it is the smoothed but not decomposed skin conductance signal. The unfiltered signal is referred to as the Raw SCL.

- **Tonic SCL:**  
 The Tonic SCL refers to the tonic (slow moving) component of the SCL signal.

- **Phasic SCL:**  
 The Phasic SCL refers to the phasic (fast moving) component of the SCL signal.

- **SCR:**  
 The SCR (Skin Conductance Response) refers to a section in the SCL signal with a specific shape--namely an upwards hump suggesting a sudden increase in skin conductance activity, followed by a decay. The Toolbox identifies SCRs by scanning the signal for sections that conform to specific SCR definition. Any SCRs that conform are classified, regardless of their proximity to epochs.
 
## Step 1: Filtering the SCL signal ##
The raw SCL signal is fetched from the specified channel, and if enabled, the shock removal moving median filter is applied. The result is then multiplied by the gain, and if enabled, low pass filtered at the specified cutoff frequency.

It is from this filtered signal that the **SCL_filt** metrics are calculated.

## Step 2: Calculating the Tonic and Phasic signals ##
First, the filtered SCL signal is resampled using spline interpolation applied to a new 20 Hz time-vector spanning the length of the filtered SCL signal. The tonic SCL signal is then calculated by first applying a moving minimum filter with the user-specifiable window size to the resampled SCL signal, then smoothing the result using a Gaussian kernel of the same window size.

The phasic SCL signal is calculated by applying a 1st order high pass Butterworth filter with the specified cutoff frequency to the down sampled and interpolated SCL signal.

It is from these tonic and phasic signals, which all have 20 Hz resolution, that the **SCL_tonic** and **SCL_phasic** metrics are calculated.
 

 {% include image.html
    img="user-guide/physioanalyzers/sc-module-tonic-phasic.png"
    title= "SCR Correction"
    id="tonic-phasic"
    no_shadow = true
    caption="The filtered SCL signal (light blue line, top graph); tonic SCL signal (dark blue line, top graph); and phasic SCL signal (orange line, bottom graph). Additionally, the area under the phasic line is visualized in light orange (bottom graph)." %} 

## Step 3: SCR Detection and Analysis ##
If enabled, SCRs are detected on the resampled SCL signal described in Step 2, which has a 20 Hz resolution, using the approach described here.

### Valley-Peak Pair Detection ###
Using peak and valley detection, each occurrence of a valley succeeded by a peak, henceforth collectively **valley-peak pairs**, are identified.

### Inflection Point Detection ###
If superimposed SCR detection is enabled, SCRs are split at inflection points location on their up slope. To find these inflection points, the resampled SCL signal is first smoothed using a Gaussian filter with the user-specified window size, then derived to attain the first time derivative of the SCL, the SCL'. Subsequently, this signal is also smoothed and derived in the same manner to attain the second time derivative of the SCL signal, the SCL''.

For each previously found valley-peak pair, the section of the SCL'' signal between the valley and the peak is searched for negative-to-positive zero-crossings. Zero-crossings inside SCR rejection zones are discarded. The remaining negative-to-positive zero-crossings become **inflection points**, and each valley-peak pair featuring inflection points are split at their respective inflection points, where the inflection point becomes the peak to the previous valley, and the valley to the subsequent peak, forming new valley-peak pairs.


 {% include image.html
    img="user-guide/physioanalyzers/sc-module-no-split-scr.png"
    title= "SCR Inflection"
    id="no-split-scr"
    no_shadow = true
    caption="An SCR that has not been split at its inflection points; i.e., superimposed SCRs detection is disabled. The rising edge of the SCR clearly features an inflection point around t = 1935.4 s; and one less distinguishable inflection point at t = 1933.5 s." %} 
 


 {% include image.html
    img="user-guide/physioanalyzers/sc-module-inflection.png"
    title= "SCR Detection"
    id="scr-detection"
    no_shadow = true
    caption="Left: when superimposed SCR detection is enabled, the rising SCR is split at its two inflection points, which are defined as the negative-to-positive zero-crossings of the second derivative of the SCL (the pink dotted lines). Right: increasing the derivative smoothing window size smooths out the second derivative of the SCL, thereby reducing the inflection point detection sensitivity." %} 

### SCR Classification ###
Valley-peak pairs, which may now include those generated by inflection-point splitting, are filtered using the user-specified amplitude and rise time criteria. Additionally, any valley-peak pair with a valley and/or peak inside an SCR rejection zone is discarded. The remaining valley-peak pairs are classified as SCRs, with the valley being defined as the SCRs onset time, and the peak as its peak.

When assigning SCRs to epochs, an SCR is associated with an epoch if the SCR's onset time lies within  that epoch's start time plus the user-specified  **start-latency**, and the epoch's end time plus the specified **end-latency**. SCRs can belong to multiple overlapping epochs, and as a result of the latency compensation, also to multiple non-overlapping epochs.

---

# Settings
The Skin Conductance analyzer assumes that the unit of the raw signal is **µS**. If this is not the case, fill in an appropriate gain value (multiplier) to transform the raw signal into µS.

The auto-generated list below shows the settings available in the {{ page.title }} module:

{% include module-settings.html %}

---

# Metrics
The auto-generated table belows lists all the metrics produced by the {{ page.title }} module.

{% include metrics-table.html id="metrics" %}

In addition to the epoch-based metrics above, the Skin Conductance Analyzer also outputs a table with all SCR data.

{% include csv-table.html
    id="metrics-scr"
    csv_name="SC_Module_SCR"
    caption="The SCR-specific data. This table is also exported by the module when epoch analysis is run. "%}

---

# Resampled Signals #
When exporting the resampled epoch signals, the Skin Conductance Analyzer resamples and extracts the filtered, tonic and phasic SCL signals.