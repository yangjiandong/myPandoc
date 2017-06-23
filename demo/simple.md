# Section
This is our first section.

Another paragraph.

We can use Markdown for figures.

Markdown for lists

* One
* Two
    * Nested one
* Three
    1. Numerated list
    1. No need to specify number

We can even inline math: $y = ax + b$.  
How about displayed equations:

$$
y = -2.2x + 0.5
$$

## Subsection
Just use Markdown to define sections and structure of the document.

Let's finish with a footnote.[^1]

# create this pdf

```
pandoc -V papersize:a4paper -o simple.pdf input.md
```

[^1]: I'm a footnote!