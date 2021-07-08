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

[Download PhysioData Toolbox v{{ site.pdt_version }}](https://surfdrive.surf.nl/files/index.php/s/gMILKhsZTAICSsR/download){: .pdt-btn style="width: 480px; text-align: center;"}

<details markdown="1">
  <summary class="fs-5 fw-300 ml-4" markdown="span">SHA-256 checksum</summary>
  250B3F39E1DF3E720F60543FA937B244EDBFC33AB5502A3DCBCDF1436510F51F
  {: .fs-5 .fw-300 .ml-4}
</details>

The Toolbox requires the MATLAB 2020b Component Runtime (v9.9):
{: .pdt-abstract-body}

[Download MATLAB 2020b Component Runtime](https://nl.mathworks.com/products/compiler/matlab-runtime.html){: .pdt-btn style="width: 480px; text-align: center;"}

See installation guide [below](#installation).
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Installation
Before running the Toolbox, download and install the free [MATLAB 2020b Component Runtime (v9.9)](https://nl.mathworks.com/products/compiler/matlab-runtime.html). You will need admin rights to install it. Ask your IT department to install if you don't have the necessary permissions.

If you already have MATLAB 2020b **including the Compiler Toolbox**, you should already have the correct runtime installed.

Once the MATLAB runtime is ready:

 - Download and unpack the [Toolbox zip file](#download-and-installation), preferable to local storage.
 - Run the **PhysioDataToolbox.exe** file.

If this is your first time using the Toolbox, follow the [Basic Walkthrough](.\tutorial\basics.md) to get acquainted with the Toolbox features.

❕ 🙁 Problems? See Troubleshooting [below](#troubleshooting).
{: .ml-4}

## SmartScreen Warning ##
When running PhysioDataToolbox.exe for the first time, especially recently released versions, you might get a Windows 10 SmartScreen warning. This is because even though the PhysioData Toolbox executable is signed, it is considered _unrecognized_ until it has built a reputation with the Microsoft SmartScreen system (see [here](https://security.stackexchange.com/a/139520) for more info).

To run the Toolbox anyway, click **More Info**, then **Run anyway**.

{% include image.html
    img="smartscreen-popup.png"
    title="SmartScreen"
    caption="When running a new version of the Toolbox for the first time, you might encounter a Windows SmartScreen warning. To run the Toolbox,  click More info then Run anyway." %}


---

# License and Support
This Toolbox is made freely available 'as is' to students and researchers. The software has undergone testing and validation, but is presented in good faith without any guarantee, and without warranty of fitness for a particular purpose. Always double-check the results, and please report any errors, inconsistencies and suggestions to the development team.

The PhysioData Toolbox is strictly for non-diagnostic and non-commercial use.

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
    Contact the [developers](#license-and-support) and explain your predicament.