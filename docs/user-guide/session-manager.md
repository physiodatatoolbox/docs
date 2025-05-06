---
title: Session Manager
nav_order: 20
parent: User Guide
---

# Session Manager
{: .pdt-abstract-title, .no_toc}

The Session Manager is the main window of the PhysioData Toolbox. It is used for managing PhysioData files, and assigning and running analysis pipelines.
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Concepts and Terminology
From the **Session Manager**, users can: import PhysioData files; create PhysioAnalyzer modules and propagate them to the files; launch viewers to review and interact with the data in the files; batch analyze the data inside the files; and save the current session. These concepts, and the terminology required to understand the PhysioData Toolbox and its user interaction mechanics, are laid out below.

{% include image.html
    img="user-guide\session-manager\session-manager.png"
    title="Session Manager"
    id="session-manager-img"
    caption="The Session Manager, which is the main toolbox window. It manages the PhysioData files, the PhysioAnalyzers and the data export." %}

## PhysioData Files ##
**PhysioData files** are specifically formatted MATLAB files that contain raw data, and all settings and user-corrections necessary to analyze those data. By design, the Toolbox saves all information necessary to analyze an individual file inside that same file, which obviates the need for separate 'analysis definition' files.

## Raw Data ##
Physiological data and metadata that have been converted to the PhysioData specification are referred to as **raw data**. These data can be analyzed by the Toolbox, but are never altered. The Toolbox supports two types of raw data: signals and eye-tracking datasets.

### Signals ###
**Signals** refer to a collection of uniformly sampled time-series (e.g. a ECG and EMG data), optionally including **events**, which are named moments inside the recording (e.g. 'Start Recording' or 'End Trial 1'). A signal inside a collection thereof may be referred to as **channel** and referenced by means of a 'channel number' (e.g. the ECG and EMG data are in channels 1 and 2, respectively). A special type of signal is a **marker** channel, which is a digital signal with activity that reflects sections and/or events inside the recording.

### Eye-tracking dataset ###
An **eye-tracking dataset** contains pupil-size and gaze data, as well as named moments (**eye-tracking events**) and named segments (**eye-tracking sections**).

## Epochs ##
Analyzing continuous recordings usually involves segmenting the data into time-sections of interest, aka **epochs**, and analyzing them independently. These epochs are generally defined relative to **markers** or **events** inside the raw data. A fundamental aim of the toolbox is to automate the epoch-based batch-analyses of signals by providing a flexible rule-based method for defining how data must be segmented. A collection of user-defined rules by which a signal is to be segmented is referred to as an **Epoch Definition table**. These user-created definitions are used by the Toolbox to automatically identify, isolate, name, and analyze special sections of recorded data. Additionally, PhysioData files can contain 'File Epochs', which are pre-generated custom epochs. This allows users to create and analyze custom epochs that cannot be generated using the epoch definition table

## PhysioAnalyzer Modules ##
PhysioAnalyzer modules are components that define the analysis pipeline, user-interaction and visualization scheme for a specific type of data. For example, the ECG Signal Analyzer defines how a raw ECG signal is processed and what settings are used in this procedure, as well as how the data is visualized and which user-corrections are possible (e.g. rejecting faulty sections). These modules can be created, modified and applied to the desired PhysioData files using the **PhysioAnalyzer Configurator** panel in the Session Manager.

## Saving ##
Saving commits the PhysioAnalyzer modules and their data, including the user corrections, to their respective PhysioData files so that they can be reloaded in the future. During a PhysioData Toolbox session, all PhysioAnalyzer data are kept in memory and persist only for the current session. It is not until the user saves the data that they're stored to disk.

---

# Interface #
In addition to the panels described below, the Session Manager features a directory bar showing the **Current Directory**, which is the folder from which the current PhysioData files have been imported. This directory is set using the **Open** button, and can be rescanned by clicking the **Refresh** button.

Clicking the **Menu** button reveals options, including a shortcut to the File Converter application and to the PhysioData Toolbox website.

## PhysioData Files Panel ##
The **PhysioData Files** panel is used for managing the imported PhysioData files. The imported PhysioData files and their included PhysioAnalyzers are displayed in the file tree. Each top-level node displays the filename and the tags of that file's PhysioAnalyzers. **<font color="#145E28">Green</font>** and **<font color="#C83223">Red</font>** tags indicate that a PhysioAnalyzers has or has not been marked as accepted by the user. A lightning bolt indicates that the file's raw data is loaded into memory.

{% include image.html
    img="user-guide\session-manager\physiodata-files-panel-tree.png"
    title="PhysioData Files Tree"
    id="file-tree-panel"
    no_shadow = true
    caption=
    "The PhysioData Files panel, showing the imported PhysioData files and their PhysioAnalyzers. File 001 is expanded, showing it has a Blood Pressure Analyzer tagged BP, an ECG analyzer tagged ECG, an HRV analyzer tagged HRV, and a Skin Conductance Analyzer tagged SC. Additionally, the ECG analyzer is expanded showing its settings and state."
    %}

Each file node can the expanded to reveal the PhysioAnalyzer modules it contains, which in turn can be expanded to reveal that module's settings and state. 

Clicking the **View Raw Data** button opens the **Raw Data Viewer**, which visualizes all raw data inside the file currently selected in the tree. Similarly, the **View Analyses** button opens the **PhysioAnalyzer Viewer**, which displays the file's PhysioAnalyzer modules and their data. The **Remove Analyses** button launches a selection window allowing the users to choose which PhysioAnalyzers to remove from the selected files.

The current session can be saved using the **Save** button, which stores the PhysioAnalyzers, including all user corrections, inside their corresponding PhysioData files. It is important to note that the toolbox does not automatically save anything. As such, it is strongly recommended to save often if the changes made are to be kept.

## PhysioAnalyzer Configurator Panel
The **PhysioAnalyzer Configurator** panel is used for defining or modifying the PhysioAnalyzers, and then propagating them to selected PhysioData files. The **Current PhysioAnalyzer Configurations** tree shows the currently defined PhysioAnalyzers and their settings. These PhysioAnalyzers are not linked to any files, and do not contain any state (user corrections). It is not until the user applies the PhysioAnalyzer to the PhysioData files using the **Apply to PhysioData Files** button that the PhysioAnalyzer settings are propagated to the selected files, and linked to data.

{% include image.html
    img="user-guide\session-manager\configurator-panel.png"
    title="PhysioAnalyzer Module Configurator"
    id="config-panel"
    no_shadow = true
    caption=
    "The PhysioAnalyzer Configurator panel in the Session Manager. This panel features a tree showing the defined PhysioAnalyzers and their settings, and buttons for creating and applying these PhysioAnalyzers to the files. The checkboxes can be used to select only a subset of the settings for applications."
%}

New PhysioAnalyzers can be created by clicking the **Create New Analyzer** button, which opens a list of available PhysioAnalyzers. Once the desired PhysioAnalyzer is selected, a window opens allowing the user to modify the settings. This window can be reopened at any time by selecting the PhysioAnalyzer and clicking **View/Edit Analyzer**. Analyzers can be removed by selecting them and clicking the **Remove Analyzer** button.

PhysioAnalyzers can be imported from a PhysioData file by first selecting the desired file in the PhysioAnalyzer file tree, then clicking the **Import From PhysioData File** button. This copies the settings of all the PhysioAnalyzers inside the selected PhysioData file to the **PhysioAnalyzer Configurator**.

The PhysioAnalyzer tree allows the user to check and uncheck individual PhysioAnalyzers and any of their settings. If a PhysioData file already contains a PhysioAnalyzer of the same type and with the same tag, only the checked setting(s) within that PhysioAnalyzer will be updated. This allows the user to change only certain settings across selected files, leaving other settings intact. 

Once the **Apply to PhysioData Files**  button is clicked, the user is presented with a summary of the settings that are to be pushed to the files, and some additional options. Checking the **Mark overwritten PhysioAnalyzers as 'Unaccepted'** box will reset the accepted status of each PhysioAnalyzer that new settings were pushed to, while the **Clear State** option clears the state (all user corrections and scored items) from the affected PhysioAnalyzers.

{% include image.html
    img="user-guide\session-manager\pushing-modules.png"
    title="Pushing PhysioAnalyzer modules to files"
    id="push-prompt"
    caption=
    "The summary and options window that  pops up when applying PhysioAnalyzers to PhysioData files. Note that in this case, only the following settings will be pushed to the files: epochs definitions, high-pass filter settings, and minimum R-peak value. These settings will only be applied to modules tagged ECG. All other settings, i.e.  settings not in this list, and all PhysioAnalyzers with different tags, will be left unaffected. By choosing the appropriate button, the settings can be propagated to all files, or only the files previously selected in the Session Manager (in this  case the first two files)."
%}

Note that the **Remove Analyzer** and **View/Edit Analyzer** buttons act on the selected  PhysioAnalyzers (highlighted in blue), while the **Apply to PhysioData Files**  button acts on the checked PhysioAnalyzers and their checked settings, regardless of selection.

---

# Data Export Panel
The **Data Export** panel contains options for batch analyzing and exporting the raw and processed data for further analysis.

{% include image.html
    img="user-guide\session-manager\export-panel.png"
    title="The Data Export Panel"
    no_shadow = true
    id="export-panel"
    caption=
    "The Data Export panel in the Session Manager."
%}

## Generating Epoch Summaries
The PhysioData Toolbox can perform batch epoch-based descriptive statistical analysis. When the **Epoch Summaries** button is clicked, all epochs inside all PhysioAnalyzers inside the selected PhysioData files are analyzed and the results are saved as one Excel file, one MATLAB file, or a set of files. The results are stored as tables with each epoch on a separate row, and all the variables as columns.

{% include image.html
    img="user-guide\session-manager\excel-output.png"
    title="Excel output"
    id="excel-output"
    caption=
    "The epoch analysis results saved as an Excel file. The first column shows the unique Epoch identifier, and its cells’ background colors are grouped by file."
%}

See each module's page for information about which variables (metrics) they calculate.

## Generating Resampled Epoch Signals
Instead of generating summaries of data per epoch, it is also possible to export resampled data of each epoch. When the **Resampled Epoch Signals** button is clicked, the user is asked which module (PhysioAnalyzer) to resample and the desired sampling rate (ranging from 50 Hz to 1 Hz) can be selected. The signal sections that fall withing the epochs are then resampled and saved as Excel file, MATLAB file, or several tsv files.

See each module's page for information about which signals they resample.

## Generating a Data Archive
Next to epoch summaries and resampled epoch signals, the toolbox can also export all PhysioAnalyzer data as MATLAB files (by using the **Data Archive** button). This is useful for when the user wants to have access to the data generated by the PhysioAnalyzers, before it is condensed into epoch summaries, or resampled.

It is advisable to create a data archive of MATLAB files once everything has been satisfactorily corrected and reviewed. Since the PhysioData files do not actually contain the signals generated by the PhysioAnalyzers, it will be impossible to regenerate these signals and hence recreate the analysis without the version of the PhysioData Toolbox originally used.