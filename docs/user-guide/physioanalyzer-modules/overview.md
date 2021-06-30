---
title: Overview
nav_order: 1
parent: PhysioAnalyzers
grand_parent: User Guide
---


# {{ page.title }}
{: .pdt-abstract-title, .no_toc}

The Toolbox features various PhysioAnalyzers--modules containing an adjustable analysis pipeline specific to a certain data type.
{: .pdt-abstract-body}

---

# Introduction #
The Toolbox has one main PhysioAnalyzer module, called the **Generic Signal Analyzer**. This module performs basic preprocessing and descriptive analysis on miscellaneous time series, such as a temperature recording. All other modules are derivatives of the Generic Signal Analyzer, and extend it by incorporating preprocessing and analysis steps specific for their target data type.

Some modules reference data in other modules, and therefore require that the other modules be present in the file in order to function. For instance, the ICG module uses the 
R-peaks from an ECG module.

PhysioAnalyzer modules can be added and removed from files by using the [Session Manager](../session-manager.html#physiodata-files-panel).

---

# PhysioAnalyzer Modules #
The current version of the Toolbox features the following modules:

{% for item in site.data.module_details %}

 - <a href="./{{item[1].htmlName}}.html">**{{ item[1].name }}**</a>:  
    {{ item[1].desc }}  

{% endfor %}


