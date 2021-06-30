---
title: Version History
nav_order: 6
---

# Version History
{: .pdt-abstract-title }

The PhysioData Toolbox is in constant development. The latest public version is {{ site.pdt_version }}.
{: .pdt-abstract-body}

---

# Change Log #
Although the Toolbox can generally open files from older versions, it is not guaranteed that the results obtained in different PhysioData Toolbox versions are completely equal. It is therefore strongly advised to analyze a dataset using a single version. Also, double check the PhysioAnalyzer data, settings and user corrections when loading older files.

## PhysioData Toolbox v0.6.0
PhysioData Toolbox Version 0.6 contains several improvements over v0.5.

 - **New epoch definition rules:**  
    PhysioData Toolbox Version 0.6 contains a completely new epoch definition rule-set, which makes it possible to define multiple epochs using the same rule. Additionally, the use of regular expression and integer ranges for marker/event matching has been implemented.

 - **Various bug and framework fixes:**  
    The new version features a partially refactored codebase, with several bug-fixes and performance improvements.

 - **SCR detection:**  
    The Toolbox now detects Skin Conductance Responses.

 - **New example datasets:**  
    Included now are new example datasets.

 - **This website:**  
    The PhysioData Toolbox documentation has been updated and moved from a pdt document to this website.

## PhysioData Toolbox version prior to 0.6
Versions older than 0.6 are considered legacy. Please contact us if you require access to them.
