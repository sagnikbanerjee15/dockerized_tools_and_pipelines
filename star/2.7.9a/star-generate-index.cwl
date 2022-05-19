class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: star_generate_index
baseCommand:
  - STAR
inputs:
  - id: genomeFastaFiles
    type:
      - File
      - type: array
        items: File
    inputBinding:
      position: 0
      prefix: '--genomeFastaFiles'
  - id: sjdbGTFfile
    type: File?
    inputBinding:
      position: 0
      prefix: '--sjdbGTFfile'
  - id: runThreadN
    type: int?
    inputBinding:
      position: 0
      prefix: '--runThreadN'
    doc: STAR command for generating index
  - id: genomeSAindexNbases
    type: File?
    inputBinding:
      position: 0
      prefix: '--genomeSAindexNbases'
      loadContents: true
      valueFrom: $(inputs.genomeSAindexNbases.contents)
  - id: genomeChrBinNbits
    type: File?
    inputBinding:
      position: 0
      prefix: '--genomeChrBinNbits'
      loadContents: true
      valueFrom: $(inputs.genomeChrBinNbits.contents)
outputs:
  - id: output
    type: Directory
    outputBinding:
      glob: star_index
label: star-generate-index
arguments:
  - position: 0
    prefix: '--runMode'
    valueFrom: genomeGenerate
  - position: 0
    prefix: '--genomeDir'
    valueFrom: star_index
requirements:
  - class: DockerRequirement
    dockerPull: 'ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/star:2.7.9a'
  - class: InlineJavascriptRequirement
