---
title: Blood Pressure Analyzer
layout: default
nav_order: 60
parent: PhysioAnalyzers
grand_parent: User Guide
classname: BP_Module
---

# {{ page.title }}
{: .pdt-abstract-title, .no_toc}

The Blood Pressure Analyzer extracts the systolic, diastolic and mean arterial blood pressures, as well as the pulse, from a continuous blood pressure signal, and calculates descriptive statistics for each epoch.
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Introduction
The **Blood Pressure (BP) Analyzer** performs standard epoch-based analyses on a BP signal. The module features automatic calibration event detection, pulse estimation, and user-correction of the systolic peak detection.

{% include image.html
    img="user-guide/physioanalyzers/bp-module-gui-1.png"
    title= page.title
    id="gui-1"
    caption="The BP Analyzer GUI, showing the BP signals and the estimated pulse. Note the automatically detected calibration event around 1865 seconds." %} 

---

# User Corrections #
The Blood Pressure Analyzer allows the user to define zones in which the systolic and diastolic landmarks are disregarded. The module also estimates the pulse, in BPM, using the detected systolic peaks. The pulse signal itself cannot be corrected, and is instead automatically filtered using MATLAB’s hampel filter (k = 10, nSigma = 4). Artifacts in the pulse signal must thus be corrected indirectly by inserting correction zones in the blood pressure signal.

When a noisy section is detected, the user can insert a correction zone by left-clicking in the graph and dragging the mouse. Once a section is selected, landmarks can either be disabled or enabled. It is advisable to select a segment that is as big as possible, maximizing the interval in which no peaks should be detected.

{% include image.html
    img="user-guide/physioanalyzers/bp-module-correction-1.png"
    title= "Blood Pressure analyzer artifact correction 1"
    id="correction-1"
    caption="
    A blood pressure plot showing some deviating waveforms around 1880 seconds.
    " %}

{% include image.html
    img="user-guide/physioanalyzers/bp-module-correction-2.png"
    title= "Blood Pressure analyzer artifact correction 2"
    id="correction-2"
    caption="
    Once the noisy section is selected, systolic and diastolic peak detection can be enabled or disabled within that section.
    " %} 


{% include image.html
    img="user-guide/physioanalyzers/bp-module-correction-3.png"
    title= "Blood Pressure analyzer artifact correction 3"
    id="correction-3"
    caption="
    Disabling the peak detection within the previously selected section removes the deviation from the interpolated blood pressure signals.
    " %} 


<!-- TODO: Write the Processing and Analysis Pipeline section

---

# Processing and Analysis Pipeline

-->

---

# Settings
The Blood Pressure Analyzer assumes that the unit of the BP signal is **mmHg**. If this is not the case, fill in an appropriate gain value (multiplier) to transform the raw signal into mmHg.

<!-- TODO: Explain how the calibration detection works, and what the 0.002 means -->

The toolbox automatically detects calibration segments in the raw signal, and removes them from the filtered signal. The user cannot modify the segments that were classified as calibration segments. In the case that the calibration fails, the user may tweak the sensitivity, or completely disable the calibration detection by setting the sensitivity to zero.

A calibration sensitivity values below have been found to work well:

 - **BMEYE Nexfin:**  
    0.02 (default).

- **Finapres:**  
    0.02 (default).

 - **BIOPAC NIBP100D (CNAP Monitor by CN systems):**  
    0.002.

The auto-generated list below shows the settings available in the {{ page.title }} module:

{% include module-settings.html %}

---

# Metrics
The auto-generated table belows lists all the metrics produced by the {{ page.title }} module.

{% include metrics-table.html id="metrics" %}

---

# Resampled Signals #
When exporting the resampled epoch signals, the Blood Pressure Analyzer resamples and extracts the filtered BP signal, the systolic BP signal, the diastolic BP signal, and the MAP signal.
