class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - bedtools
  - intersect
inputs:
  - id: inputB
    type:
      - File
      - type: array
        items: File
    inputBinding:
      position: 0
      prefix: '-b'
      itemSeparator: ','
      shellQuote: false
    doc: One or more BAM/BED/GFF/VCF file(s) ?B?.
  - id: inputA
    type: File
    inputBinding:
      position: 0
      prefix: '-a'
      shellQuote: false
    doc: >-
      BAM/BED/GFF/VCF file ?A?. Each feature in A is compared to B in search of
      overlaps.
  - id: invert
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-v'
      shellQuote: false
    label: Invert selection
    doc: >-
      Only report those entries in A that have no overlap in B. Restricted by -f
      and -r.
  - id: originalA
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-wa'
      shellQuote: false
    doc: Write the original entry in A for each overlap.
  - id: originalB
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-wb'
      shellQuote: false
    doc: >-
      Write the original entry in B for each overlap. Useful for knowing what A
      overlaps. Restricted by -f and -r.
  - id: leftOuterJoin
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-loj'
      shellQuote: false
    doc: >-
      Perform a ?left outer join?. That is, for each feature in A report each
      overlap with B. If no overlaps are found, report a NULL feature for B.
  - id: wo
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-wo'
      shellQuote: false
    doc: >-
      Write the original A and B entries plus the number of base pairs of
      overlap between the two features. Only A features with overlap are
      reported. Restricted by -f and -r.
  - id: wao
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-wao'
      shellQuote: false
    doc: >-
      Write the original A and B entries plus the number of base pairs of
      overlap between the two features. However, A features w/o overlap are also
      reported with a NULL B feature and overlap = 0. Restricted by -f and
      -r.Write the original A and B entries plus the number of base pairs of
      overlap between the two features. However, A features w/o overlap are also
      reported with a NULL B feature and overlap = 0. Restricted by -f and -r.
  - id: unique
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-u'
      shellQuote: false
    doc: >-
      Write original A entry once if any overlaps found in B. In other words,
      just report the fact at least one overlap was found in B. Restricted by -f
      and -r.
  - id: count
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-c'
      shellQuote: false
    doc: >-
      For each entry in A, report the number of hits in B while restricting to
      -f. Reports 0 for A entries that have no overlap with B. Restricted -f,
      -F, -r, and -s.
  - id: minOverlap
    type: float?
    inputBinding:
      position: 0
      prefix: '-f'
      shellQuote: false
    doc: Minimum overlap required as a fraction of A. Default is 1E-9 (i.e. 1bp).
  - id: minOverlapB
    type: float?
    inputBinding:
      position: 0
      prefix: '-F'
      shellQuote: false
    doc: 'Minimum overlap required as a fraction of B. Default is 1E-9 (i.e., 1bp).'
  - id: reciprocalFraction
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-r'
      shellQuote: false
    doc: >-
      Require that the fraction of overlap be reciprocal for A and B. In other
      words, if -f is 0.90 and -r is used, this requires that B overlap at least
      90% of A and that A also overlaps at least 90% of B.
  - id: eitherFraction
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-e'
      shellQuote: false
    doc: >-
      Require that the minimum fraction be satisfied for A _OR_ B. In other
      words, if -e is used with -f 0.90 and -F 0.10 this requires that either
      90% of A is covered OR 10% of B is covered. Without -e, both fractions
      would have to be satisfied.
  - id: stranded
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-s'
      shellQuote: false
    doc: >-
      Force ?strandedness?. That is, only report hits in B that overlap A on the
      same strand. By default, overlaps are reported without respect to strand.
  - id: differentStranded
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-S'
      shellQuote: false
    doc: >-
      Require different strandedness. That is, only report hits in B that
      overlap A on the _opposite_ strand. By default, overlaps are reported
      without respect to strand.
  - id: sort
    type:
      - 'null'
      - type: record
        fields:
          - name: sorted
            type: boolean
            inputBinding:
              position: 0
              prefix: '-sorted'
              shellQuote: false
            doc: >-
              For very large B files, invoke a ?sweeping? algorithm that
              requires position-sorted (e.g., sort -k1,1 -k2,2n for BED files)
              input. When using -sorted, memory usage remains low even for very
              large files.
          - name: genome
            type: File
            inputBinding:
              position: 0
              prefix: '-g'
              shellQuote: false
            doc: >-
              Specify a genome file the defines the expected chromosome order in
              the input files for use with the -sorted option.
        name: sort
    inputBinding:
      position: 0
      shellQuote: false
  - id: printHeader
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-header'
      shellQuote: false
    doc: Print the header from the A file prior to results.
  - id: bed_output_fomat_specifier
    type: File?
    inputBinding:
      position: 0
      prefix: '-bed'
      shellQuote: false
  - id: output_prefix
    type: string
outputs:
  - id: output
    type: File
    outputBinding:
      glob: '*bed'
doc: >-
  bedtools intersect allows one to screen for overlaps between two sets of
  genomic features. Moreover, it allows one to have fine control as to how the
  intersections are reported. bedtools intersect works with both BED/GFF/VCF and
  BAM files as input.


  *Note*


  If you are trying to intersect very large files and are having trouble with
  excessive memory usage, please presort your data by chromosome and then by
  start position (e.g., sort -k1,1 -k2,2n in.bed > in.sorted.bed for BED files)
  and then use the -sorted option. This invokes a memory-efficient algorithm
  designed for large files. This algorithm has been substantially improved in
  recent (>=2.18.0) releases.


  *Important*


  As of version 2.21.0, the intersect tool can accept multiple files for the -b
  option. This allows one to identify overlaps between a single query (-a) file
  and multiple database files (-b) at once!


  *Default behavior*


  By default, if an overlap is found, bedtools intersect reports the shared
  interval between the two overlapping features.
label: bedtools intersect
arguments:
  - position: 3
    prefix: ''
    shellQuote: false
    valueFrom: '> $(inputs.output_prefix + ".bed")'
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
hints:
  - class: ResourceRequirement
    ramMin: 15000
    coresMin: 1
    tmpdirMin: 10000
  - class: DockerRequirement
    dockerPull: 'ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/bedtools:2.27.1'
'sbg:links':
  - id: 'https://bedtools.readthedocs.io/en/latest/content/tools/intersect.html'
    label: Bedtools documentation
