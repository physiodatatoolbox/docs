---
title: Home
layout: home
nav_order: 1
---

# PhysioData Toolbox
{: .pdt-abstract-title }

The PhysioData Toolbox is a free easy-to-use and fully graphical application for visualizing, segmenting and analyzing physiological data.
{: .pdt-abstract-body}

❕ **{{ site.pdt_release_date_str }}:** Version {{ site.pdt_version }} released ([see what's new](./docs/change-log.html)).
{: .fs-5 .fw-300}

---

{% assign show_smiley = true %}

{% if show_smiley %}📥 {% endif%}**Get** the Toolbox:
{: .fs-5 .fw-300 }

[Download and Install](./docs/installation.html){: .pdt-btn style="width: 210px; text-align: center;"}

{% if show_smiley %}👀 {% endif%}**See** the Toolbox features:
{: .fs-5 .fw-300}

[Features](./docs/features.html){: .pdt-btn .mr-4 style="width: 210px; text-align: center;"} 

{% if show_smiley %}💡 {% endif%}**Learn** how to use Toolbox:  
{: .fs-5 .fw-300}

[Tutorial](./docs/tutorial.html){: .pdt-btn .mr-4 style="width: 210px; text-align: center;"} 

{% if show_smiley %}📖 {% endif%}**Read** the full manual:  
{: .fs-5 .fw-300}

[User Guide](./docs/user-guide.html){: .pdt-btn style="width: 210px; text-align: center;"}

{% if show_smiley %}🎓 {% endif%}**Cite** the Toolbox:  
{: .fs-5 .fw-300}

{% include citation.html %}
