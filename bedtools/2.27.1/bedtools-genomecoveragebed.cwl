class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: bedtools_genomecoveragebed
baseCommand:
  - bedtools
  - genomecov
inputs:
  - id: ibam
    type: File?
    inputBinding:
      position: 0
      prefix: '-ibam'
    doc: 'The input file is in BAM format. Note: BAM _must_ be sorted by position'
  - id: d
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-d'
    doc: >-
      Report the depth at each genome position (with one-based coordinates).
      Default behavior is to report a histogram.
  - id: dz
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-dz'
    doc: |-
      Report the depth at each genome position (with zero-based coordinates).
      Reports only non-zero positions.
      Default behavior is to report a histogram.
  - id: bg
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-bg'
    doc: >-
      Report depth in BedGraph format. For details, see:
      genome.ucsc.edu/goldenPath/help/bedgraph.html
  - id: bga
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-bga'
    doc: "Report depth in BedGraph format, as above (-bg).\n\t\t\tHowever with this option, regions with zero \n\t\t\tcoverage are also reported. This allows one to\n\t\t\tquickly extract all regions of a genome with 0 \n\t\t\tcoverage by applying: \"grep -w 0$\" to the output."
  - id: split
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-split'
  - id: strand
    type:
      - 'null'
      - type: enum
        symbols:
          - +
          - '-'
        name: strand
    inputBinding:
      position: 0
      prefix: '-strand'
  - id: i
    type: File?
    inputBinding:
      position: 0
      prefix: '-i'
  - id: g
    type: File?
    inputBinding:
      position: 0
      prefix: '-g'
outputs:
  - id: output_bed
    type: File?
    outputBinding:
      glob: '*bed'
label: bedtools genomecoveragebed
requirements:
  - class: DockerRequirement
    dockerPull: 'ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/bedtools:2.27.1'
  - class: InlineJavascriptRequirement
stdout: |-
  ${
      if(inputs.ibam)
      {
          return inputs.ibam.nameroot + "_bedtools_cov.bed"
      }
      else if(inputs.i)
      {
          return inputs.i.nameroot + "_bedtools_cov.bed"
      }
  }
