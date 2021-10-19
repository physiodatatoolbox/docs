---
title: Download and Installation
nav_order: 3
---

# Download and Installation
{: .pdt-abstract-title, .no_toc}

The PhysioData Toolbox can be downloaded as a zip file containing the executables and supplementary files:
{: .pdt-abstract-body}

❗ **The Toolbox is only compatible with Windows.**
{: .fs-5 .fw-300 .ml-4}

<!-- https://i.giphy.com/media/8cuVdoyDlfRnPFYMcv/giphy.webp -->

[PhysioData Toolbox v{{ site.pdt_version }}]({{ site.pdt_download_url }}){: .pdt-btn style="width: 400px; text-align: center;"}

<details markdown="1">
  <summary class="fs-5 fw-300 ml-4" markdown="span">SHA-256 checksum</summary>
  2936DB0D67ED7B1BEF807772FA2EE0BC2CB52B65E701D8636EB59ADE45019108
  {: .fs-5 .fw-300 .ml-4}
</details>

The Toolbox requires the free {{ site.pdt_mcr_ver_long }}:
{: .pdt-abstract-body}

[{{ site.pdt_mcr_ver_long }}](https://nl.mathworks.com/products/compiler/matlab-runtime.html){: .pdt-btn style="width: 400px; text-align: center;"}

See installation guide [below](#installation).
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Installation
Before running the Toolbox, download and install the free [{{ site.pdt_mcr_ver_long }}](https://nl.mathworks.com/products/compiler/matlab-runtime.html). You will need admin rights to install it. Ask your IT department to install if you don't have the necessary permissions.

If you already have {{ site.pdt_matlab_ver }} **including the Compiler Toolbox**, you should already have the correct runtime installed.

Once the MATLAB runtime is ready:

 - Download and unpack the [Toolbox zip file](#download-and-installation), preferable to local storage.
 - Run the **PhysioDataToolbox.exe** file.

If this is your first time using the Toolbox, follow the [Basic Walkthrough](.\tutorial\basics.html) to get acquainted with the Toolbox features.

❕ 🙁 Problems? See Troubleshooting [below](#troubleshooting).
{: .ml-4}

## SmartScreen Warning ##
When running PhysioDataToolbox.exe for the first time, especially recently released versions, you might get a Windows 10 SmartScreen warning. This is because even though the PhysioData Toolbox executable is signed, it is considered _unrecognized_ until it has built a reputation with the Microsoft SmartScreen system ([more info](https://en.wikipedia.org/wiki/Microsoft_SmartScreen#Code_Signing_Certificates)).

To run the Toolbox anyway, click **More Info**, then **Run anyway**.

{% include image.html
    img="smartscreen-popup.png"
    title="SmartScreen"
    caption="When running a new version of the Toolbox for the first time, you might encounter a Windows SmartScreen warning. To run the Toolbox,  click More info then Run anyway." %}


---

# License and Support
The Toolbox is in active development and is made freely available 'as is' to students and researchers. The software has undergone thorough testing and validation, but is presented without guarantee, and without warranty of fitness for a particular purpose. Always double-check the results, and please report any errors, inconsistencies and suggestions to the development team.

The PhysioData Toolbox is meant strictly for non-diagnostic, non-medical and non-commercial use.

This Toolbox sends anonymous usage data to an online analytics server for tracking how often the Toolbox and its various features are used. These data are necessary for rationalizing the continued development and maintenance of the Toolbox and its components. No physiological (meta)data, analysis results or personally identifiable information is collected.

If you use the PhysioData Toolbox, please cite it using the following information:

Sjak-Shie, E. E. (2021). PhysioData Toolbox (Version 0.6.1) [Computer software]. Retrieved from https://PhysioDataToolbox.leidenuniv.nl.
{: .text-mono}

If you require support, or if you have any questions, comments or suggestions, please contact us at [PhysioDataToolbox@fsw.leidenuniv.nl](mailto:PhysioDataToolbox@fsw.leidenuniv.nl).

---

# Troubleshooting

 - **Ensure correct runtime installation**:  
    Make sure that the correct version (2020b, v9.9) of the MATLAB Component Runtime has been properly installed. An older or newer version will not suffice.

 - **Unpack zip to suitable location:**  
    Before running the Toolbox executables, please ensure that the zip file is unpacked to a folder where you have write-access, preferably on a local drive. Additionally, do not put the Toolbox in a folder controlled by a file-synchronization service (e.g. Dropbox).

 - **Wait:**  
    When running PhysioDataToolbox.exe for the first time, it will attempt to create a folder named PhysioDataToolbox_mcr in the same directory as the executable, and unpack its dependencies there. This may take **several minutes**, especially when running the Toolbox on network or non-SSD drives. Please be patient. Subsequent launches should be much faster.

 - **Ask for help:**  
    Contact the [developers](./about.html) and explain your predicament.