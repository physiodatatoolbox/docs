---
title: Area of Interest Hit Analyzer
layout: default
nav_order: 120
parent: PhysioAnalyzers
grand_parent: User Guide
classname: AOI_Module
---


# {{ page.title }}
{: .pdt-abstract-title, .no_toc}

The Area of Interest (AOI) Hit Analyzer performs epoch-based analyses of prescored AOI hit data.
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Introduction
The **Area of Interest Hit Analyzer** visualizes pre-classified hit data inside an eye-tracking dataset, and performs epoch-based descriptive analysis or resampling. AOI hit data consists of an AOI name, and the start and end times of the hits. The Toolbox itself cannot score AOI hits based on gaze coordinates.

{% include image.html
    img="user-guide/physioanalyzers/aoi-module-gui-1.png"
    title= page.title
    id="gui-1"
    caption="The Area of Interest Hit GUI, showing the hit data per AOI. In the current file there were four AOIs. Notice that the EXP_AOIEyes AOI was hit most frequently." %} 

---

# User Corrections #
The Area of Interest Hit Analyzer does not allow for corrections to be made.

<!-- TODO: Write pipeline
---
# Processing and Analysis Pipeline
-->

---

# Settings
The auto-generated list below shows the settings available in the {{ page.title }} module:

{% include module-settings.html %}

---

# Metrics
The auto-generated table belows lists all the metrics produced by the {{ page.title }} module.

{% include metrics-table.html id="metrics" %}

---

# Resampled Signals #
When exporting the resampled epoch signals, the AOI Hit Analyzer resamples and extracts the AOI hits. This results in a hit fraction per bin indicating the fraction of the bin the AOI was hit (0 = no hit, 1 = complete hit).