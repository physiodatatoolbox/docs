---
title: ICG Ensemble Analyzer
layout: default
nav_order: 50
parent: PhysioAnalyzers
grand_parent: User Guide
classname: ICG_Ensemble_Module
---

# {{ page.title }}
{: .pdt-abstract-title, .no_toc}

The ICG Ensemble Module generates one ICG and one ECG ensemble waveform per epoch, and allows the user to score the necessary ICG landmarks.
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Introduction
The **ICG Ensemble Analyzer** module performs epoch-based analysis of ensemble ICG and ECG signals, and allows the user to manually score the Q, B, C, and X points on the ensembles. In addition, the user can exclude deviant waveforms from the ensemble.

**Waveforms** are sections of the ICG and ECG signals that straddle each R-peak, and the **ensemble** is the grand average curve of the individual waveforms, 

{% include image.html
    img="user-guide/physioanalyzers/icg-ensemble-module-gui-1.png"
    title= page.title
    id="gui-1"
    caption="The ICG Ensemble Analyzer (Manual Scoring) GUI, showing: the ICG signal and the R-peak times (top graph, labeled dZ/dt); the current epoch data (leftmost table); the ensemble ECG and ICG curves, as well as the individual waveforms (two center graphs); and, the individual waveform data (rightmost table). Note that the first waveform in the table can be excluded from the ensemble by unchecking the 'Use Waveform' box. The rejected waveform is visualized by a triangle in the Wave-Skip graph, above its R-peak location." %}

To ensemble the ICG and ECG signals, a valid ECG Signal Analyzer module must be present in the PhysioData file. The R-peak times from this ECG module, as well as the user specified waveform start and end offsets, are used to slice the ICG and ECG signals into individual waveforms. Only waveforms that completely fit inside one or more epochs are further processed. The filtered ECG signal from the ECG module is used for the ECG waveforms, and the ICG signal is taken from the user specified channel, and optionally pre-processed.

The ICG Ensemble Analyzer only analyzes the ICG (-dZ/dt) signal, the Generic Signal Analyzer module can be used to calculate descriptive statistics from the Z-signal; e.g., mean Z value per epoch. Similarly, ECG based metrics are only calculated in the ECG module, not the ICG module itself. For convenience and compatibility, consider defining the necessary epochs in the ECG module, then referring to them in the ICG and Generic Signal Analyzers. The toolbox cannot generate a -dZ/dt signal from a Z signal, but this can be done beforehand using a custom MATLAB script.

The waveform rejection criteria, and the placement strategy for the Q, B, C and X points are at the researchers' own discretion, and fall outside of the scope of this document. Because the Q-point is used to mark the onset of the PEP, 'R-onset PEP' can technically be calculated by placing the Q-point at the R onset.

{% include image.html
    img="user-guide/physioanalyzers/icg-ensemble-module-landmarks.png"
    title= "ICG Landmarks"
    id="landmarks"
    no_shadow = true
    max_width="600px"
    caption="The ECG (top) and ICG (bottom) ensembles, and their landmarks. The R and C points are automatically detected, whereas the Q, B and X points must be manually scored by the user." %}

---

# User Corrections #
With the exception of basic pre-filtering, the ICG Ensemble Analyzer module does not allow the user to modify the ICG signal. It is, however, possible to include or exclude individual waveforms from the ensembles, and to custom place the ICG and ECG landmarks (except the R-peaks).

The **Epoch Data** and **Waveform Data** tables, and the **Waveform Graphs** display information about the currently selected epoch, and allow that epoch's ensemble to be scored. To change the currently selected epoch, choose another one from the dropdown menu in the Epoch Data table, or click on the desired epoch in the epoch graph.

The filtered ECG signal and the R-peak times, and hence also the ensembles, are dependent on the linked ECG module, and are automatically updated whenever the ECG module's data is changed.

## Rejecting or Accepting Waveforms ##
Once a waveform is rejected, neither the ICG nor ECG waveforms corresponding to that R-peak will be used to calculate the ensemble averages of any epoch that that R-peak may be in. Rejected waves are visualized in the wave-skip graph as triangles above their R-peak times. Additionally, rejected waveforms are plotted as dashed lines in the **Waveform Graphs**. Individual waveforms can be rejected and included one at a time by checking or unchecking their **Use Waveform** box in the **Waveform Data** table.

<!-- Lib for equations: 
Tip: https://www.codecogs.com/latex/eqneditor.php
-->
<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

The analyzer module calculates a deviation metric for each ICG waveform to facilitate the identification and rejection of abnormal waveforms. This metric, the **Normalized Root Mean Squared Deviation** (NRMSD) is calculated as root mean squared of the deviation between each sample of a ICG waveform $$(\small ICG{i})$$ and the corresponding sample of the ICG ensemble $$(\small \widehat{ICG}_{i})$$. The RMSD is then normalized using the range of the ensemble, as in [Equation 1](#eq1).

$$
\begin{equation}
\small
NRMSD = \sqrt[]{
\frac{\sum_{i=1}^{n}(\widehat{ICG}_{i} - ICG{i})^{2}}{n}
}
\cdot
(\widehat{ICG}_{max} - \widehat{ICG}_{min})

\tag{Eq. 1}
\end{equation} 
$${: id='eq1'}

The **Sort** button toggles the table sort between increasing R-peak time and decreasing NRMSD.

## Scoring ##
The Q-point can be scored by right-clicking inside the ECG waveform graph axes at the desired Q-point time, and selecting the **Place Q-Point at this time** from the context menu. Similarly, the B and X points can be scored by right-clicking inside the ICG waveform graph axes. All manually scored points are automatically placed on their respective ensemble curves at the sample that is closest to the user-specified time; i.e., a sampling rate of 1000 Hz allows scoring with 1 ms accuracy.

To facilitate the scoring of the ECG and ICG landmarks, the first time derivative,  acceleration, and the second time derivative, jerk, of both signals are calculated. Clicking the **Ensemble \| Accel. + Jerk \| Waves** button toggles between showing the waveforms or the derivatives. As the derivatives are arbitrarily scaled to fit the ensemble curve range, they should only be used for visual aid when scoring. 

---

# Settings
The ICG Ensemble Analyzer assumes that the unit of the ICG signal is **-Ω/s**. If this is not the case, fill in an appropriate gain value (multiplier) to transform the signal into -Ω/s.

The auto-generated list below shows the settings available in the {{ page.title }} module:

{% include module-settings.html %}

---

# Metrics
The auto-generated table belows lists all the metrics produced by the {{ page.title }} module.

{% include metrics-table.html id="metrics" %}