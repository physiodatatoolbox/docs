---
title: Version History
nav_order: 6
---

# Version History
{: .pdt-abstract-title }

The PhysioData Toolbox is in constant development. The latest public version is {{ site.pdt_version }}.
{: .pdt-abstract-body}

---

# Version Compatibilities #
Although the Toolbox can generally open files from older versions, it is not guaranteed that the results obtained in different PhysioData Toolbox versions are completely equal. It is therefore not advisable to compare data analyzed using different Toolbox versions. In any case, always double-check the PhysioAnalyzer data, settings and user-corrections when loading older files.

## Documentation Archive ##
Archival snapshots of this website representing older PhysioData Toolbox versions can be found [here](./doc-versions.html).

---

# PhysioData Toolbox v0.6.3 (Latest)
PhysioData Toolbox version 0.6.3 contains several minor bugfixes and improvements. It was released on {{ site.pdt_release_date_str }}. Download it [here](./installation.html).

 - **Bug fixes and improvements:**  
     - Fixed an issue that may cause referenceable events to be plotted in an incorrect graph.
     - The Pupil size module's fast-mode has been improved and documented ([link](./user-guide/physioanalyzer-modules/pupil-module.html#fast-mode)).
     - The minimum selection size has been decreased (narrower areas can now be selected).
     - Resampling timestamps (in the `time_Epoch` variable) are now rounded to the nearest 0.0001 second to avoid floating point errors from preventing equivalent time-points from being grouped together.
     - Other minor GUI corrections and framework updates.

---

<!-- Versions below are not the latest. Do not refer to the base site params, use pdt_version_archive. -->

# PhysioData Toolbox v0.6.2
PhysioData Toolbox version 0.6.2 contains several improvements to its framework, user-interface and documentation. It was released on {{ site.pdt_version_archive | where: "pdt_version", "0.6.2" | map: 'pdt_release_date_str'}}. Download it [here]({{ site.pdt_version_archive | where: "pdt_version", "0.6.2" | map: 'pdt_download_url'}}).

The most user-relevant updates are:

 - **New converters:**  
    The MRI scanner Physlog and BioSemi converters have been updated and reintroduced.

 - **Bug fixes and improvements:**  
    Version 0.6.2 contains several bugfixes, including:
     - Resampling when files contain multiple modules of the same type no longer crashes.
     - The Skin Conductance module no longer crashes when analyzing epochs with a duration of 100 ms or less.
     - The Biopac converter no longer saves 'New Rate' events as labels.
     - Fixed an issue causing the Data Previewer to not regenerate the data.  

 - **New features (beta):**  
     - The ECG module now allows users to manually add R-peaks. 
     - The ECG module can now visualize superimposed QRS waves for easier anomaly detection.
     - The Pupil Module now also supports 'Fast Mode' for easier corrections.
     - The referenceable events table (in the Raw Data Viewer or the Epoch Builder) can now also show a summary of the events.

---

# PhysioData Toolbox v0.6.1
Contains all the improvements of v0.6.0, as well as a minor bugfix relating to the Gazedata Converter. It was released on {{ site.pdt_version_archive | where: "pdt_version", "0.6.1" | map: 'pdt_release_date_str'}}. Download v0.6.1 [here]({{ site.pdt_version_archive | where: "pdt_version", "0.6.1" | map: 'pdt_download_url'}}).

---

# PhysioData Toolbox v0.6.0
PhysioData Toolbox version 0.6 contains several improvements over v0.5.

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

 - **Less converters:**  
    The MRI scanner Physlog and BioSemi converters have been removed until a future release.

---

# PhysioData Toolbox v0.5.0 ## 
Versions older than 0.6 are considered legacy. A zip file containing PhysioData Toolbox v0.5.0, including all documentation, can be downloaded [here]({{ site.pdt_version_archive | where: "pdt_version", "0.5.0" | map: 'pdt_download_url'}}). 

---

# PhysioData Toolbox v<0.5
Please contact us if you require older versions v0.5.0.

