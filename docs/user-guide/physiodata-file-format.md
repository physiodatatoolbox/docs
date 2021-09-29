---
title: PhysioData File Format
layout: default
nav_order: 90
parent: User Guide
---

# {{ page.title }}
{: .no_toc}

The specification for the PhysioData file format and a guide to manually generating them.
{: .pdt-abstract-body}

---
{% include pdt_toc.md %}
---

# Introduction #
The Toolbox can only read data from PhysioData files, which are standard MATLAB MAT files with the physioData extension corresponding to the Toolbox's data format. This data format is also used in low-level functions to generate Toolbox compatible data objects. PhysioData files can be generated using the File Converter tool or a custom MATLAB script.

---

# File Specification #
PhysioData files are standard MATLAB files with the .physioData extension. The file specification is designed to only carry built-in MATLAB types, and organizes data using structs, cell arrays, tables, etc. PhysioData files can contains two types of raw data: signals and eye-tracking datasets. In addition, the files can contain timing data, such as events and epochs. Lastly, the files hold all states and settings for the PhysioAnalyzers--it is from these parameters, in combination with the raw data, that the PhysioAnalyzer data are generated; i.e., derived data, such as Heart Rate, is never saved in the PhysioData files, but rather dynamically generated during the analysis session. 

The tree below visualizes the contents of a PhysioData file. The bold strings indicate the field and/or variable names.
<filetree></filetree>
{: .text-mono .fs-3}

The code below creates a PhysioData file with random data.

~~~
% Generate signals data:
T_mins = 8;
T      = T_mins * 60;
fs     = 1000;
t      = timeVector(fs, (T * fs) + 1);
sig    = zeros(size(t));

% Epochs:
epochs            = table();
epochs.startTime  = [0 2 4  0]' * 60;
epochs.endTime    = [2 4 T_mins 4]' * 60;
epochs.epochName  = {'e_0_2' 'e_2_4' 'e_4_8' 'e_0_4'}';
epochs.epochMean  = [1 2 3.5 1.5]' .* n;

% Generate channel 1:
for iEpoch = 1 : 3
   
    sig(...
        (t >=  epochs.startTime(iEpoch)) ...
        & (t <  epochs.endTime(iEpoch))) ...
        = epochs.epochMean(iEpoch);

end

pdtData.data.signals.channels{1}         = sig;
pdtData.data.signals.channels{2}         = sig * 2;
pdtData.data.signals.channelNames        = {'sig 1' 'sig 2' };
pdtData.data.signals.channelDescription  = {'X'      'Y'    };
pdtData.data.signals.channelUnits        = {'a'      'b'    };
pdtData.data.signals.fs                  = fs;
pdtData.epochs.epochData                 = epochs;
~~~
{: .language-matlab style="line-height: 1"}


Hello.


















<link rel="stylesheet" href="{{ site.url }}/{{ site.baseurl }}/assets/libs/vanillatree/vanillatree.css">
<script src="{{ site.url }}/{{ site.baseurl }}/assets/libs/vanillatree/vanillatree.min.js"></script>

<script>

    // Read in tree stuff:
    const main = document.querySelector('filetree');
    const tree = new VanillaTree( main);

    // Read javascript:
    var oXHR = new XMLHttpRequest();
    oXHR.onreadystatechange = ajaxCallback;
    oXHR.overrideMimeType("application/json");
    oXHR.responseType = "json"
    oXHR.open("GET", "{{ site.url }}/{{ site.baseurl }}/assets/files/file-format.json", true);
    oXHR.send();

    // File read callback:
    function ajaxCallback() {
        if (oXHR.readyState == 4 && oXHR.status == "200") {            

            // Build tree:
            window.pdt_format = this.response
            addNode(this.response[0], "")
        }
    }

    // Adds node:
    function addNode(node_data, parent_id){

        // ID for current node:
        let node_id = parent_id + node_data.field

        // Data for current node (tree leaf):
        let tree_node_data = {
            label: `<b>${node_data.field}</b><br><div style="white-space: break-spaces;margin: 0px 0px 5px 0px">[${node_data.size} ${node_data.type}]<br><i>${node_data.desc}</i></div>`,
            parent: parent_id,
            id: node_id,
            opened: true
            }

        // Add node:
        tree.add(tree_node_data);

        // Add children:
        if (node_data.children) {
            for (child_node_data of node_data.children) {
                addNode(child_node_data, node_id)
                }
        }
    }

  </script>





