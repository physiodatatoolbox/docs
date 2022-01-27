---
title: Style Ref
layout: default
nav_exclude: true
---

<!---
    This page features styling snippets for the PDT doc.

    https://pmarsceill.github.io/just-the-docs/

    Start local server:
    bundle exec jekyll serve --livereload
    
    Local link:
    http://localhost:4000/PhysioDataToolbox_doc/style-ref.html

-->


# Page Abstract Title
{: .pdt-abstract-title, .no_toc}

Abstract text comes here. It is more prominent than normal body text, and appears above the TOC. Add buttons below for links that visitors will probably need to click.
{: .pdt-abstract-body}

[Special button](https://www.google.com)
{: .pdt-btn}

<!--- Add TOC using the include, between horizontal lines: -->
---
{% include pdt_toc.md %}
---

# First Chapter (using images) #
When inserting images, use the image.html include. if you add an ID, you can link to the image later. See below.

{% include image.html
    img="test-big.png"
    title="Test Big Image"
    id="test-big-1"
    caption="The is a big image." %}

Specifying a max width:

{% include image.html
    img="test-big.png"
    title="Test Big Image, but smaller"
    id="test-big-2"
    max_width="300px"
    caption="This is the same big image, but with a max-width set. Notice that the caption wraps." %}  
    
{% include image.html
    img="test-big.png"
    title="No shadow"
    id="ans-1"
    max_width="300px"
    no_shadow = true
    caption="No shadow" %}

Text goes here. Text goes here. Text goes here. Text goes here. Text goes here. Text goes here. Text goes here. Text goes here.

## Linking to image ##
Link to an image by using its id: See the [test image](#test-big-1) for more details. U can also use this with headers: see [chapter](#first-chapter-using-images). You must remove all caps and symbols though.

---

# Second Chapter #
Separate chapters by horizontal line.

---

# Footnotes and References #

Just use inline references, with a foot note link. Foot notes are then inserted at the end of the page, in the references chapter.
The EMG preprocessing is based on a pipeline proposed by van Boxtel et al. (2010)[^1].

The references need to be explicitly numbered, so just add them in the order they appear in the text. Not alphabetically.

---

# Lists #
Just use normal lists.


List header/intro:
 - Item 1
 - Item 2
 - Item 3
 
 or:
 - **Item 1 header:**  
    Item 1 description comes here. Note the two trailing spaces in the header. A sub list is started as such:

    - **Item 1.a header:**  
        Item 1.a description

    - **Item 2.a header:**  
        Item 2.a description

- **Item 2 header:**  
    Item 2 description.

- **Item 3 header:**  
    Item 3 description.

## Header H2 ##
More normal text.

This is a smaller image, at its native size.

{% include image.html
    img="test-small.png"
    title="Test Small Image"
    id="test-small-1"
    caption="Small image with long caption at its native size (no size specified). Captions wraps." %}

---
# Style Conventions.

## Header Capitalization ##
Capitalize every word of Titles, and H1 and H2.

## Emphasizing words ##

Use **bold** for emphasizing Buttons, Windows, tabs, concepts (e.g. **epochs**, **Save**)
Use 'single quotations' for event names, epoch names, etc (e.g. 'Habituation_Start').
Use `back-ticks` for values that are filled in (for example in the Epoch Definition Table, e.g. `1:last`, `ECG`).




<!-- KEEP REFERENCES AT THE END! -->

---
# References #


<!-- The footnotes, example below, will always be placed at the end of the page. -->

[^1]: Van Boxtel, A. (2010). Filter for optimal smoothing of acoustic and electric blink reflex EMG responses to determine blink response magnitude. Biological Psychology, 85, 299-305.



