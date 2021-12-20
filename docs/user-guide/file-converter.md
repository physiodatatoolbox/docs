---
title: File Converter
nav_order: 10
parent: User Guide
---

# File Converter #
{: .pdt-abstract-title, .no_toc}

The File Converter is an app that converts various data formats into PhysioData files for use in the Toolbox.
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Introduction #
The PhysioData toolbox is designed to only analyze standardized PhysioData files, which are MATLAB files with the physioData extension that comply with the PhysioData file specification. 

<!--- TODO: Link to file specification above. --->

To facilitate the batch conversion of raw physiological data to the PhysioData format, the toolbox includes a separate _File Converter_ application.

## Launching the File Converter ##
The File Converter can be launched by selecting it from the welcome screen, or by clicking the menu in the top left corner of the Session Manager, then selecting the File Converter.

## Supported File Types ##
The current version of the File Converter supports the following raw file formats:

 - BIOPAC
 - VU-AMS
 - BioSemi
 - LIBC Philips Achieva 3T MRI scanner
 - E-Prime Extension for Tobii (EET)
 - EyeLink

Other raw file types can be converted to the PhysioData format by using a custom MATLAB script that generates the PhysioData File.

<!--- TODO: Link to section about manually generating PhysioData files. --->

---

# User Interface #
Files can be imported into the File Converter by clicking the **Select Files** button and selecting the correct file type and import options. Once the raw files have been imported, information about their contents is presented in the **Current Raw Files** table, with each row below the top row representing a single file.

{% include image.html
    img="user-guide\file-converter\file-converter-interface.png"
    title="File converter interface"
    id = "fc-1"
    caption="The File Converter interface, showing 5 imported BIOPAC files (PPN_01.acq – PPN_05.acq) with 13 channels each" %}

<!-- TODO: Remake the printscreen to include the new Session Manager buttons. Also add it to the description. -->


The first column in the Current Raw Files table contains checkboxes used for enabling and disabling individual files for conversion. The **File** and **Info** columns to the right of that show the file names and a summary of the file contents, respectively.

In the case that the raw files contain signals, the subsequent columns will show their names and units. Similarly, if a file contains pupil diameter data, columns representing the left and right pupil size data will appear. The checkboxes in the top row can be used to enable and disable individual channels for conversion. It is strongly recommended to not convert data that are not required for analysis.

Below the table, the **Clear File List** button resets the converter to its default empty state, and the **Converter Options** button launches a menu showing custom conversion options for the selected file type. This button is disabled if the file type does not have any custom options, as is the case for BIOPAC files.

## Data Previewer ##
Clicking the **Preview Converted Data** button converts the first enabled raw file and displays the converted data in a new window called **Data Previewer**, which is similar to the Toolbox's Raw Data Viewer. For more information about viewing and navigating through raw data, see the [Data Viewers](..\user-guide\data-viewers.md).

The Data Previewer only converts the signals currently enabled for conversion in the Raw Files table (i.e., data in columns where the first row has a checked checkbox). Additionally, if available, the Data Previewer uses the currently set custom converter options when generating data for previewing. These options can be viewed by clicking the custom options button in the main File Converter window (below the table), or the same button in the Data Previewer (to the left of the current file menu). Note that previewing does not actually create a PhysioData file.

## File Conversion ##
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
The built-in BIOPAC converter supports AcqKnowledge (v3.9 – v5.0.6) data saved as .acq files or exported as .mat files. Due to a limitation in the BIOPAC File API, only AcqKnowledge .acq files that comply with the following requirements can be converted: 
 - All channels must have the same sampling rate 
 - All channels must have the same length

However, AcqKnowledge data that don't conform to this requirement can still be exported as .mat files and converted.

When using digital markers, and depending on the experimental design, the BIOPAC AcqKnowledge data may contain 8 digital channels that are only used to calculate a separate 8-bit decimal marker channel. If this is the case, these 8 single-bit channels, usually labeled 'Digital Input', should be omitted from conversion as they are not necessary for data analysis.

The BIOPAC converter does not feature any custom conversion options.

---

# VU-AMS #
The VU-AMS converter supports converting raw 5FS files recorded using the VU-AMS system. All sub-sampled signals are up-sampled to the master sampling rate through linear interpolation and nearest neighbor extrapolation.

If a channel labeled Z0 is present, a -dZ/dt channel is generated using a differentiating 256 order FIR filter with a high-pass cutoff frequency of 1 Hz, and a low-pass cutoff frequency of 10 Hz.

The VU-AMS converter does not feature any custom options. 

---

# LIBC Achieva MRI #
PhysLog files generated by the LIBC Philips Achieva 3T MRI scanner can be converted to the PhysioData format using the LIBC Achieva MRI converter. Note that this converter is designed specifically for use with data from the Leiden University scanner, and may not work as intended on data from other scanners, even those of the same make and model.

The converter makes the following variables from the raw physlog .log files available:

 - **v1:** The first VCG vector.
 - **v1:** The second VCG vector.
 - **resp:** The respiration signal.
 - **ppu:** The ppu (pulse) signal.
 - **gx:** The MR X-gradient.
 - **gy:** The MR Y-gradient.
 - **gz:** The MR Z-gradient.

Additionally, the converter produces a channel which is the average of both v1 and v2 called **v1v2avg**; i.e. v1v2avg = (v1 + v2) / 2. The scanner also logs physiological trigger events in the mark channel inside the physlog file. These events are converted into 3 synthetic signals with spikes at the locations of triggers: **VCG_TRIG**, **PPU_TRIG** and **RESP_TRIG**.

The converter assumes a sampling frequency of 496 Hz.

The LIBC Achieva MRI converter does not feature any custom options.

## Analysis Tips ##
When using the ECG module to analyze the VCG data, it has been observed that using v1v2avg as the "ECG" channel, and applying a high-pass filter of 8 Hz and a low-pass of 46 Hz--approximately--works adequately across various participants and conditions. Increasing the high-pass filter frequency may further improve the suppression of noise and other cardiac waves. 

Note that the ECG module expects an ECG signal in the common mV range. Since this is not the case with the physlog signals, the module's gain, or the detection and rejection criteria, will need to be modified.

---

# BioSemi #
The BioSemi converter can be used to extract physiological signals from .bdf files and save them in the  PhysioData format. Since the PhysioData Toolbox cannot analyze EEG data, only other physiological signals present in the file, such as ECG, EMG, skin conductance, etc., should be extracted.

For BioSemi files, the following BioSemi Options can be set:

 - **Calculation Channels:**  
   This field can be used to generate new data from signals in the file. This can for example be useful for generating an ECG signal. The BioSemi [options window](#biosemi-opts) provides a calculation example.

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

 - **Gap Threshold:** 
  The Toolbox assumes that a time gap between subsequent rows in the gazedata file indicates a break in a section, even if the rows otherwise form a contiguous section. The gap is classified as a difference in row-timestamps with duration larger than N times the sample duration (1/fs). N must be larger than 1, and can be inf. Setting it to inf effectively turns off the above mentioned assumption.

 - **AOI Analysis:**  
   In this field, one column name of the EET files can be specified. This column should hold the current area of interest (AOI) hit data. It thus holds the AOI name that is currently looked at (if any). In EET 3.2 files, the ComponentName column can be used for AOI Analysis. The ComponentName column is automatically created in EET 3.2 files and contains the (sub)object or slide state that is currently being looked at.

{% include image.html
    img="user-guide\file-converter\eet-custom-options.png"
    title="EET custom options"
    id="eet-opts"
    caption="The custom conversion options available for EET files." %}


## Experimental Design Considerations ##
There are a few considerations one should keep in mind when designing an E-Prime task with EET eye tracking and when aiming to analyze the data with the PhysioData Toolbox.

The first is the **Eye-tracking Event Generation** column(s). This column should hold data relevant for event generation (usually String data) and is crucial, as it will be impossible to create epochs without it. The event generation column could for example hold the currently running object in E-Prime, such as “Stimulus” or “Fixation”. When segmentation requires more detailed information, multiple columns can be used for event generation. For example, the currently running object, and the condition of the current trial (e.g. “congruent” and “incongruent”). See the [figure below](#eet-gazedata) for example event generation columns in the gazedata file.

By default, E-Prime does not save any event data in the gazedata file, these data have to be defined by the user. See [here](https://researchwiki.solo.universiteitleiden.nl/xwiki/wiki/researchwiki.solo.universiteitleiden.nl/view/Software/E-Prime/E-Prime%20and%20Tobii) for instructions on how to incorporate Tobii eye tracking in an E-Prime experiment, including adding event data to the gazedata files.

Another consideration is the AOI column used for the **AOI Analysis** (not relevant when only pupil data is analyzed). The AOI column should hold the name of the AOI the participant was looking at. By default, E-Prime 3 (when used with EET 3.2) saves a variable called **ComponentName**. This variable holds the component of the experiment (e.g. Slide sub-object) the participant is looking at. This variable could function as an AOI column. However, whether this variable is suited should be evaluated. See the [figure below](#eet-gazedata) for an example AOI column in the gazedata.

It is highly recommended to convert gazedata from an initial pilot to check whether the event generation column(s) and (if applicable) the AOI column are sufficient for the purpose of the study, before starting data collection.

{% include image.html
    img="user-guide\file-converter\eet-converter-gazedata.png"
    title="EET example gazedata"
    id="eet-gazedata"
    caption= "EET example gazedata obtained with a (fictitious) E-Prime task. In the task, each trial consisted of a Fixation followed by a Stimulus. The Stimulus was a Slide object with a picture of a face with a certain expression (happy, angry or sad). By using empty text sub-objects, several AOIs were drawn: AOIFace (face excluding the eyes, nose and mouth), AOIEyes, AOINose, and AOIMouth. The task saved the ObjectOnScreen variable, holding the currently running object (Fixation or Stimulus), the Condition variable, holding the emotion of the person in the picture (happy, angry or sad), and the AOI variable, holding the AOI that was being looked at. Events can be generated using both the ObjectOnScreen and Condition variable in the following way: ObjectOnScreen;Condition. This will create the following events: 'Stimulus angry', 'Stimulus happy', etc. The AOI column can be used for the AOI Analysis." %}

---

# EyeLink #
The EyeLink converter can be used to extract raw pupil-size data from SR research’s EyeLink .edf files.

This converter features the following custom options:

 - **Remove EyeLink System Events:**  
  The File Converter converts all messages available in the .edf file to eye-tracking events, except the events that match the regular expression specified in this field. Leaving the field blank converts all messages. Many EyeLink system-events are not actually used by the PhysioData Toolbox and can therefore be omitted from conversion. The default value removes these system-events.

 - **DataViewer Options:**  
  If messages were sent with an time-offset prefix as defined by DataViewer, then the timestamps of those messages can be corrected accordingly by the File Converter. Messages should have the following format: \<offset> \<msg>, where \<offset> is the message delay in ms.

{% include image.html
    img="user-guide\file-converter\eyelink-custom-options.png"
    title="EyeLink custom options"
    id="el-opts"
    caption="The custom conversion options available for EyeLink files." %}

## Experimental Design Considerations ##
When collecting pupil size with an EyeLink eye tracker, the use of a head stabilizer (chinrest) is required and it is advised to keep the camera distance fixed for all participants. Also, make sure that the AREA or DIAMETER setting in the EyeLink recording software is consistent for all participants. For more information on collecting pupil size with EyeLink, see [Recording and Analyzing Pupil Data (Pupillometry)](https://www.sr-support.com/showthread.php?tid=41&pid=40#pid40) on the SR Research Support Forum (note that you need to log-in or register to be able to view the thread).

## Analysis Tips ##
The Pupil Diameter module expects the pupil diameter to be in mm. This is not the case for EyeLink data, where pupil diameter is reported in arbitrary pixels. Therefore, the module's gain or detection and rejection criteria will need to be modified.

EyeLink pupil diameter data can be converted to mm, for instructions see [FAQ: How can I convert pupil size to mm](https://www.sr-support.com/thread-154.html) on the SR Research Support Forum (note that you need to log-in or register to be able to view the thread). Converting the pupil diameter to mm can be done in the PhysioData Toolbox, by using the **Gain** setting in the Pupil Diameter module, or it can be done after processing the data in the PhysioData Toolbox, in for example Excel, R or SPSS.