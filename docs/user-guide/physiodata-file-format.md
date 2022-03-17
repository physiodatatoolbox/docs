---
title: PhysioData File Format
layout: default
nav_order: 90
nav_exclude: true #parent: User Guide
---

# {{ page.title }}
{: .no_toc}

Information about the PhysioData file format and generating custom files using MATLAB or OCTAVE.
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Introduction #
The Toolbox can only read data from PhysioData files, which are standard MATLAB MAT files that correspond to the Toolbox's data format and have the physioData extension. PhysioData files can be generated using the [File Converter](.\file-converter.md) or a custom MATLAB script.

---

# File Specification #
PhysioData files are standard MATLAB files with the .physioData extension. The file specification is designed to only carry built-in MATLAB types, and organizes data using structs, cell arrays, tables, etc. PhysioData files can contains two types of raw data: signals and eye-tracking datasets. In addition, the files can contain timing data, such as events and epochs. Lastly, the files hold all states and settings for the PhysioAnalyzers--it is from these parameters, in combination with the raw data, that the PhysioAnalyzer data are generated; i.e., derived data, such as Heart Rate, is never saved in the PhysioData files, but instead dynamically generated during the analysis session. 

## File Format Tree ##
The tree below visualizes the contents of a PhysioData file. The bold strings indicate the field and/or variable names.

{% include json-tree.html
    json_name="file-format.json"
%}

---

# Generating PhysioData Files in MATLAB #
Any suitable data can be converted into a physioData file for use in the Toolbox using custom MATLAB scripts. A few examples are presented below.

## Basic Example 1 ##
The code below creates a PhysioData file with random data.

{% include github-code.html
    data_lang="matlab"
    data_src="https://raw.githubusercontent.com/ElioS-S/pupil-size/master/code/Examples/Dataset_1/main_Dataset1.m"
%}

## Converting TSV Files ##
The code below creates a PhysioData file with random data.

{% include github-code.html
    data_lang="matlab"
    data_src="https://raw.githubusercontent.com/ElioS-S/pupil-size/master/code/Examples/Dataset_1/main_Dataset1.m"
%}






