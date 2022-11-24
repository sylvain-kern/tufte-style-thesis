# keyval options system


- [ ] fonts

    | value       | meaning                                                                    |
    | :---------- | :------------------------------------------------------------------------- |
    | casual      | source sans pro for whole doc                                              |
    | semi-casual | libertine text, sans for floats, headers, etc.                             |
    | [regular]   | only left-rightmark sans                                                   |
    | fullserif   | full libertine, sans is biolinum (mono still source code pro)              |
    | pedantic    | full ebgaramond                                                            |
    | vanilla     | no fonts selection, for CM lovers or those who want to pull their own drip |

- [ ] layout

    | value         | meaning |
    | :------------ | :------ |
    | oneside       |         |
    | [twoside]     |         |
    | asymmetrical? |         |
    | twocolumn?    |         |
    | ...           |         |

- [ ] notes

    | value  | meaning        |
    | :----- | :------------- |
    | foot   | full footnotes |
    | [side] | sidenotes      |

- [ ] notesymbols

    | value          | meaning                                   |
    | :------------- | :---------------------------------------- |
    | [number]       | numbered footnotes (reset per page)       |
    | number-chapter | numbered footnotes (reset per chapter)    |
    | symbol         | bringhurst symbol footnotes : ∗ † ‡ § ∥ ¶ |

- [ ] headers

    | value      | meaning                                                  |
    | :--------- | :------------------------------------------------------- |
    | tufte      | like tufte                                               |
    | [headings] | like latex headings (kind of)                            |
    | margin     | page number protrudes in margin, marks are outer aligned |

- [ ] title

    | value  | meaning               |
    | :----- | :-------------------- |
    | [page] | titlepage             |
    | chunk  | just a chunk of title |
    | none   |                       |

- [ ] numdepth

    | value         | meaning                    |
    | :------------ | :------------------------- |
    | none          | no heading num at all      |
    | chapter       | only chapters are numbered |
    | section       |                            |
    | [subsection]  |                            |
    | subsubsection |                            |

- [ ] tocdepth

    same as before but in the toc

    default : subsection

- [ ] floats

    | value      | meaning              |
    | :--------- | :------------------- |
    | [numbered] | figure 1. blah blah  |
    | perchapter | figure 1.1 blah blah |
    | unnumbered | blah blah            |

- [ ] stretch

    | value | meaning          |
    | :---- | :--------------- |
    | float | value of stretch |

    default: 1.12

    if not possible to have full parameters, have stretching presets

- [ ] flow

    | value   | meaning |
    | :------ | :------ |
    | ragged  |         |
    | [boxey] |         |

- [ ] paragraphs

    | value       | meaning |
    | :---------- | :------ |
    | [indented]  |         |
    | allindented |         |
    | skipped     |         |

- [ ] color

    | value     | meaning |
    | :-------- | :------ |
    | alot      |         |
    | [touches] |         |
    | none      |         |


- [ ] bibliography

    | value                       | meaning |
    | :-------------------------- | :------ |
    | [false]                     |         |
    | unnumbered                  |         |
    | unnumbered-notes            |         |
    | unnumbered-longnotes        |         |
    | simple                      |         |
    | simple-notes                |         |
    | simple-longnotes            |         |
    | brackets                    |         |
    | brackets-notes              |         |
    | brackets-longnotes          |         |
    | list of styles:             |         |
    | nature, ieee, authordate... |         |


- [ ] toc

    | value     | meaning |
    | :-------- | :------ |
    | [default] |         |
    | twocolumn |         |

- [ ] glossary

    | value   | meaning |
    | :------ | :------ |
    | [false] |         |
    | true    |         |

- [ ] index

    | value   | meaning |
    | :------ | :------ |
    | [false] |         |
    | true    |         |

- [ ] code

    | value   | meaning |
    | :------ | :------ |
    | [false] |         |
    | true    |         |

- [ ] science

    | value   | meaning                              |
    | :------ | :----------------------------------- |
    | [false] |                                      |
    | true    | adds amsmath, amssymb, physics, etc. |


- [ ] colophon

    | value  | meaning                                          |
    | :----- | :----------------------------------------------- |
    | false  | no colophon string                               |
    | [true] | colophon string: default exists but is tweakable |

# other things

- [ ] presets of keyvals for quick setup ?

- [ ] include all options from book (papersizes, ...)

- [ ] fix the oneside/twoside fancyhdr problem

- [ ] `pandoc` is coming baby