---
title: Generic Signal Analyzer
nav_order: 10
parent: PhysioAnalyzers
grand_parent: User Guide
classname: PhysioAnalyzer
---

# {{ page.title }}
{: .pdt-abstract-title, .no_toc}

The Generic Signal Analyzer analyzes generic signals and calculates a variety of standard descriptive metrics.
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Introduction
The **Generic Signal Analyzer** is the ‘standard’ PhysioAnalyzer module, which all other modules are based on. This PhysioAnalyzer type performs basic descriptive analyses on miscellaneous signals, and allows the user to indicate noisy sections that the toolbox can then interpolate over.

Unlike the other PhysioAnalyzers, the units and labels in the Generic Signal Analyzer are taken directly from the raw data channels. These cannot be edited in this version of the toolbox. This module can be used for signals such as: body temperature, heart-rate, etc.

{% include image.html
    img="user-guide/physioanalyzers/physioanalyzer-gui-1.png"
    title= page.title
    id="gui-1"
    caption="A Generic Signal Analyzer tagged HR, showing a heart-rate signal as calculated in real-time using AcqKnowledge." %} 

---

# User Corrections #
Artifact removal in the {{ page.title }} module occurs through the user marking sections of the signal as invalid. These sections, aka **Raw-Skip zones**, are not extracted from the raw data, but are instead linearly interpolated before high-pass and/or low-pass filtration. In the case that a section extends beyond the start or end of the signal, extrapolation in that section occurs via the nearest-neighbor method.

 - **Removing raw data artifacts:**  
    To mark or unmark a section of the raw signal for interpolation, left-click in the graph at the start-time of the desired section, drag the mouse, and release at the end-time of the desired section. Choose the desired action from the pop-up menu:
    
     - **Disregard Data:**  
        **Disregard Data** tells the toolbox to reject the raw data samples within the marked section, and replace them with linearly interpolated values.

     - **Use Data:**  
        **Use Data** tells the toolbox to use the raw data inside the section. This is the default state, and the opposite of the Disregard option. As such, it can be used to remove a section previously marked as 'Disregarded'. 

{% include image.html
    img="user-guide/physioanalyzers/physioanalyzer-correction-1.png"
    title= page.title
    id="correction-1"
    caption="Marking a correction zone for interpolation: after the red section has been selected by dragging the left mouse button, the pop-up menu presents two options: disregard the raw data and interpolate; or, use the raw data." %} 

{% include image.html
    img="user-guide/physioanalyzers/physioanalyzer-correction-2.png"
    title= page.title
    id="correction-2"
    caption="The heart-rate signal, which featured two artifacts, has been corrected by inserting two interpolation zones." %} 

---

# Processing and Analysis Pipeline
In the Generic Signal Analyzer, the desired channel is extracted from the current file's raw data using the user specified channel. Then, the user-specified corrections, gain and filtering options are applied. When the analysis is run, the final filtered signal is sliced into a single segment per epoch, and descriptive analysis is performed on each segment.

{% comment %}

> The drawio analysis pipeline and the legend. It's a bit overwhelming.

{% include image.html
    img="user-guide/physioanalyzers/pipeline.drawio.svg"
    title= page.title
    id="correction-2"
    no_shadow = true
    caption="Legend of the blocks used to describe the analysis pipelines throughout this website." %}  

{% include image.html
    img="user-guide/physioanalyzers/physioanalyzer-pipeline.drawio.svg"
    title= page.title
    id="correction-2"
    no_shadow = true
    caption="The preprocessing and analysis pipeline specific to the Generic Signal Analyzer." %} 

{% endcomment %}

## Low-Pass and High-pass Filtering ##
Before applying the digital filters, the cutoff frequencies are normalized using [Equation 1](#eq1), where the resulting ω<sub>0</sub> must be between 0 and 1. If this is not the case, the signal is not filtered or analyzed. This behavior is fundamental to how the the Toolbox applies MATLAB digital filters, and holds true for all physioanalyzer modules.

<!-- Lib for equations: 
Tip: https://www.codecogs.com/latex/eqneditor.php
-->
<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

$$
\begin{equation}
\omega _{0} = \frac{2\cdot f_{cutoff}}{f_{sampling}} \tag{Eq. 1}
\end{equation} 
$${: id='eq1'}


---

# Settings
The auto-generated list below shows the settings available in the {{ page.title }} module.

{% include module-settings.html %}

---

# Metrics
The auto-generated table belows lists all the metrics produced by the {{ page.title }} module.

{% include metrics-table.html id="metrics" %}

---

# Resampled Signals
The Generic Signal Analyzer module resamples the filtered signal.
