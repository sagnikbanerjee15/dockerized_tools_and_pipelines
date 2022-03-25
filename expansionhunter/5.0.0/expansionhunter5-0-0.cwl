class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: expansionhunter5_0_0
baseCommand:
  - ExpansionHunter
inputs:
  - id: variant-catalog
    type: File
    inputBinding:
      position: 1
      prefix: '--variant-catalog'
  - id: reads
    type: File
    inputBinding:
      position: 2
      prefix: '--reads'
    secondaryFiles:
      - .bai
  - id: reference
    type: File
    inputBinding:
      position: 3
      prefix: '--reference'
  - 'sbg:toolDefaultValue': '1000'
    id: region-extension-length
    type: int?
    inputBinding:
      position: 4
      prefix: '--region-extension-length'
    doc: How far from on/off-target regions to search for informative reads
  - 'sbg:toolDefaultValue': female
    id: sex
    type:
      - 'null'
      - type: enum
        symbols:
          - male
          - female
        name: sex
    inputBinding:
      position: 5
      prefix: '--sex'
  - 'sbg:toolDefaultValue': '1'
    id: threads
    type: int?
    inputBinding:
      position: 6
      prefix: '--threads'
  - 'sbg:toolDefaultValue': dag-aligner
    id: aligner
    type:
      - 'null'
      - type: enum
        symbols:
          - dag-aligner
          - path-aligner
        name: aligner
    inputBinding:
      position: 7
      prefix: '--aligner'
  - 'sbg:altPrefix': seeking
    'sbg:toolDefaultValue': seeking
    id: analysis-mode
    type:
      - 'null'
      - type: enum
        symbols:
          - seeking
          - sreaming
        name: analysis-mode
    inputBinding:
      position: 8
      prefix: '--analysis-mode'
  - 'sbg:toolDefaultValue': info
    id: log-level
    type:
      - 'null'
      - type: enum
        symbols:
          - trace
          - debug
          - info
          - warn
          - error
        name: log-level
    inputBinding:
      position: 9
      prefix: '--log-level'
outputs: []
label: ExpansionHunter5.0.0
arguments:
  - position: 0
    prefix: '--output-prefix'
    valueFrom: |-
      ${     
          var filename = [].concat(inputs.reads);
          var file_path = filename[0].path;
          var out_name = file_path.split("bam")[0].concat('.trial').concat(filename[0].nameext)
          return out_name;
      }
requirements:
  - class: DockerRequirement
    dockerPull: 'sagnikbanerjee15/expansionhunter:5.0.0'
