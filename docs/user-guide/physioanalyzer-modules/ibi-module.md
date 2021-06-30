---
title: IBI Sequence Analyzer
layout: default
nav_order: 30
parent: PhysioAnalyzers
grand_parent: User Guide
classname: IBI_Module
---

# {{ page.title }}
{: .pdt-abstract-title, .no_toc}

The IBI Analyzer module performs heartbeat locked analysis around user-specified events, which can be used to calculate stimulus specific heart rate acceleration and deceleration.
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Introduction
The **IBI Sequence Analyzer** performs event-based IBI sequence extraction using the IBIs generated and corrected in an **ECG Signal Analyzer**, and events defined using **Event Definition Rules**. Per event, the neighboring IBIs are detected and indexed.

This module requires that an ECG Signal Analyzer be present in the PhysioAnalyzer file. The IBIs used in the IBI Sequence Analyzer are automatically updated when the linked ECG Signal Analyzer changes.

The output of this module consists of the IBIs surrounding events, and their delays relative to those events. As such, with some post processing, this module allows anticipatory and evoked IBIs to be analyzed both as a function of their beat index (i.e., beat -1, beat 0, beat 1, beat 2, etc. around a stimulus); and, through interpolation, as a function of relative time (i.e., IBI at -1, 0, 1, 2 etc. seconds around a stimulus).

{% include image.html
    img="user-guide/physioanalyzers/ibi-module-gui-1.png"
    title= page.title
    id="gui-1"
    caption="The IBI Sequence Analyzer, showing IBIs -5 to 5 surrounding an event (red triangle). The size of the IBI circles increase with their index, which allows the user to detect when IBIs from one event overlap IBIs from another event. Note that IBI(-1) is the first IBI to occur after the event, however, it is not characterized as IBI(0) due to the threshold being set at 0.5." %} 

# User Corrections #
The IBI module itself does not allow users to correct artifacts, this must instead be done in the linked ECG module. Any changes made to the IBIs in the linked ECG module are automatically transmitted to the IBI module, and the graphs and results table are automatically updated.

---

# Processing and Analysis Pipeline
When indexing the IBIs around events, the IBI corresponding to the event itself, IBI(0), is first identified. IBI(0) is the first IBI after an event, unless the event occurs after a certain fraction of that IBI, in which case the next IBI becomes IBI(0). The time before which the event must occur so that a given IBI remains IBI(0) is calculated using [Eq 1](#eq1).

<!-- Lib for equations: 
Tip: https://www.codecogs.com/latex/eqneditor.php
-->
<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

$$
\begin{equation}
t_{cutoff} = t_{IBIstart} + (threshold \cdot IBI) \tag{Eq. 1}
\end{equation} 
$${: id='eq1'}

After IBI(0) is defined, the IBIs spanning from the setting **Lower Index** to the setting **Upper Index**, relative to IBI(0), are extracted; e.g., if Lower Index = `-2` and Upper Index = `5`, two IBIs before IBI(0) and five after are considered, for 8 in total.

Note, only events where all neighboring IBIs are present are analyzed. 

---

# Settings
The IBI module must be linked to an ECG module in order for it to function. This is done by filling in the tag of the ECG module in the **Tag of the ECG Analyzer** field.

The auto-generated list below shows the settings available in the {{ page.title }} module:

{% include module-settings.html %}

---

# Metrics
The output of the IBI Sequence Analyzer is determined by the settings; for each IBI index, two variables are produced. See table below. Empty rows in the output may indicate that that event features missing IBIs.

The auto-generated table belows lists all the metrics produced by the {{ page.title }} module.

{% include metrics-table.html id="metrics" %}