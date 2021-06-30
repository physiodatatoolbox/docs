---
title: File Converter
nav_order: 10
parent: User Guide
---

# File Converter #
{: .pdt-abstract-title, .no_toc}

The File Converter is an application included with the PhysioData Toolbox that converts various data formats into PhysioData files for use in the Toolbox.
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Introduction #
The PhysioData toolbox is designed to only analyze standardized PhysioData files, which are MATLAB files with the physioData extension that comply with the [PhysioData file specification](XXX). 

To facilitate the batch conversion of raw physiological data to the PhysioData format, the toolbox is bundled with a separate _File Converter_ application. The File Converter can be launched by running the **FileConverter.exe** file.

## Supported File Types ##
The current version of the File Converter supports the following raw file formats:

 - BIOPAC
 - VU-AMS 
 - Philips Achieva MRI 'PhysLog' files
 - BioSemi
 - E-Prime Extension for Tobii (EET)
 - EyeLink

Other raw file types can be converted to the PhysioData format by using a custom MATLAB script that generates the PhysioData File.

---

# User Interface #
Files can be imported into the File Converter by clicking the **Select Files** button and selecting the correct file type and import options. Once the raw files have been imported, information about their contents is presented in the **Current Raw Files** table, with each row below the top row representing a single file.

{% include image.html
    img="user-guide\file-converter\file-converter-interface.png"
    title="File converter interface"
    id = "fc-1"
    caption="The File Converter interface, showing 5 imported BIOPAC files (PPN_01.acq – PPN_05.acq) with 13 channels each" %}

The first column in the Current Raw Files table contains checkboxes used for enabling and disabling individual files for conversion. The **File** and **Info** columns to the right of that show the file names and a summary of the file contents, respectively.

In the case that the raw files contain signals, the subsequent columns will show their names and units. Similarly, if a file contains pupil diameter data, columns representing the left and right pupil size data will appear. The checkboxes in the top row can be used to enable and disable individual channels for conversion. It is strongly recommended to not convert data that are not required for analysis.

Below the table, the **Clear File List** button resets the converter to its default empty state, and the **Converter Options** button launches a menu showing custom conversion options for the selected file type. This button is disabled if the file type does not have any custom options, as is the case for BIOPAC files.

---

# Data Previewer #
Clicking the **Preview Converted Data** button converts the first enabled raw file and displays the converted data in a new window called **Data Previewer**, which is similar to the Toolbox's Raw Data Viewer. For more information about viewing and navigating through raw data, see the [Data Viewers](..\user-guide\data-viewers.md).

The Data Previewer only converts the signals currently enabled for conversion in the Raw Files table (i.e., data in columns where the first row has a checked checkbox). Additionally, if available, the Data Previewer uses the currently set custom converter options when generating data for previewing. These options can be viewed by clicking the custom options button in the main File Converter window (below the table), or the same button in the Data Previewer (to the left of the current file menu). Note that previewing does not actually create a PhysioData file.

---

# File Conversion #
The **Convert File** button in the main File Converter window starts the file conversion process, which, depending on the file type, may take a few minutes to complete. The resulting PhysioData files are always given the same name as their raw file counterparts, with the exception of the extension. Before conversion, make sure that all files are similar and compatible with the selected conversion options.

If the File Converter detects imminent filename collisions, i.e. that similarly named PhysioData files already exist in the destination folder, the following options become available:
 - **Skip files that already exist (default):**  
   If this option is left selected, the raw files that would produce a PhysioData files that already exist are not converted.

 - **Only overwrite the raw data inside the existing PhysioData files:**  
   This option causes the File Converter to only rewrite the raw data inside the PhysioData file, if it already exists, leaving any modules settings, states and corrections intact. Use this option if for instance you already have modules and correction in the file that you do not want to override, but you do want to change the raw data.

 - **Completely overwrite existing PhysioData files:**  
   When selected, any preexisting PhysioData file with a conflicting name will be completely overwritten.

---

# BIOPAC Files #
The built-in BIOPAC converter supports AcqKnowledge (v3.9 – v5.0.2) data saved as .acq files or exported as .mat files. Due to a limitation in the BIOPAC File API, only AcqKnowledge .acq files that comply with the following requirements can be converted: 
 - All channels must have the same sampling rate 
 - All channels must have the same length

However, AcqKnowledge data that don't conform to this requirement can still be exported as .mat files and converted.

When using digital markers, and depending on the experimental design, the BIOPAC AcqKnowledge data may contain 8 digital channels that are only used to calculate a separate 8-bit decimal marker channel. If this is the case, these 8 single-bit channels, usually labeled 'Digital Input', should be omitted from conversion as they are not necessary for data analysis.

The BIOPAC converter does not feature any custom options.

--- 

# VU-AMS #
The VU-AMS converter supports converting raw 5FS files recorded using the VU-AMS system. All sub-sampled signals are up-sampled to the master sampling rate through linear interpolation and nearest neighbor extrapolation.

If a channel labeled Z0 is present, a -dZdt channel is generated using a differentiating 256 order FIR filter with a high-pass cutoff frequency of 1 Hz, and a low-pass cutoff frequency of 10 Hz.

The VU-AMS converter does not feature any custom options. 

---

# LIBC Achieva MRI #
PhysLog files generated by the LIBC Philips Achieva 3T MRI scanner can be converted to the PhysioData format using the LIBC Achieva MRI converter. Note that this converter is designed for use with data from the Leiden University scanner, and may not work as intended on data from other scanners, even those of the same make and model.

The LIBC Achieva MRI converter does not feature any custom options. 

---

# BioSemi #
The BioSemi converter can be used to extract physiological signals from .bdf files and save them in the  PhysioData format. Since the PhysioData Toolbox cannot analyze EEG data, only other physiological signals present in the file, such as ECG, EMG, skin conductance, etc., should be extracted.

For BioSemi files, the following BioSemi Options can be set:

 - **Calculation Channels:**  
   This field can be used to generate new data from signals in the file. This can for example be useful for generating an ECG signal. The BioSemi <a href="#biosemi-opts">options window</a> provides a calculation example.

 - **Markers and Button Presses:**  
   Enables the conversion of Markers and/or Button Presses to markers and labels in the PhysioData file, respectively. By default, both Markers and Button Presses are converted. Note, however, that button presses are not debounced.

{% include image.html
    img="user-guide\file-converter\biosemi-custom-options.png"
    title="BioSemi custom options"
    id = "biosemi-opts"
    caption="The custom conversion options available for BioSemi files." %}

---

# EET Output #
The E-Prime Extensions for Tobii (EET) output converter supports EET files with the .gazedata (EET 2.x – 3.1) and the .txt (EET 3.2) extensions.

This converter features the following custom options:

 - **Eye-tracking Event Generation:**  
  In this field, one or more column names of the EET files can be specified. These columns will then be used to generate eye-tracking events by finding the start and end of each contiguous section of values, or a combination of values.

 - **AOI Analysis:**  
   In this field, one column name of the EET files can be specified. This column should hold the current area of interest (AOI) hit data. It thus holds the AOI name that is currently looked at (if any). In EET 3.2 files, the ComponentName column can be used for AOI Analysis. The ComponentName column is automatically created in EET 3.2 files and the (sub)object or slide state that is currently being looked at.

{% include image.html
    img="user-guide\file-converter\eet-custom-options.png"
    title="EET custom options"
    id="eet-opts"
    caption="The custom conversion options available for EET files." %}