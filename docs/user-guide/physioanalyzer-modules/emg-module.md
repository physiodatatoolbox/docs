---
title: EMG Analyzer
layout: default
nav_order: 90
parent: PhysioAnalyzers
grand_parent: User Guide
classname: EMG_Module
---

# {{ page.title }}
{: .pdt-abstract-title, .no_toc}

The EMG Signal preprocesses an EMG signal and performs standard epoch-based analyses. 
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Introduction
The **EMG Signal Analyzer** filters a raw EMG signal, then rectifies and smooths it to obtain a smooth continuous representation of muscle activity. The module features two types of configurable EMG smoothing filters: a **boxcar filter** and a **low pass filter**. The default settings are based on A. van Boxtel (2010)[^1], which tested the efficacy of various filters when applied to blink reflex research.

If artifacts are present, the module allows users to remove sections from the smooth signal, which are then interpolated over.

{% include image.html
    img="user-guide/physioanalyzers/emg-module-gui-1.png"
    title= page.title
    id="gui-1"
    caption="The EMG Signal Analyzer interface." %} 

---

# User Corrections #
The EMG Signal Analyzer allows the user to define zones in which the smooth EMG signal is not used, but is instead interpolated over. This is similar to the process described in the [Generic Signal Analyzer](./physioanalyzer.html#user-corrections) module, but does not affect the raw signal, only the smooth EMG signal.

---

# Settings
The EMG signal analyzer assumes that the unit of the EMG signal is **mV**. If this is not the case, fill in an appropriate gain value (multiplier) to transform the raw signal into mV; e.g., if the signal is in V, the gain should be 1000.

The EMG Analyzer additionally features a **notch filter** (`iirnotch` with `Q = 35`) that can be used to filter out line noise.

The auto-generated list below shows the settings available in the {{ page.title }} module:

{% include module-settings.html %}

---

# Metrics
The auto-generated table below lists all the metrics produced by the {{ page.title }} module.

{% include metrics-table.html id="metrics" %}

---
# References #

[^1]: Van Boxtel, A. (2010). Filter for optimal smoothing of acoustic and electric blink reflex EMG responses to determine blink response magnitude. Biological Psychology, 85, 299-305.