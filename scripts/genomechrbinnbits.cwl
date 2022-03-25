cwlVersion: 'sbg:draft-2'
class: CommandLineTool
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: genomechrbinnbits
label: genomeChrBinNbits
baseCommand:
  - calculateArgumentsToSTARIndexGeneration
inputs:
  - type:
      - File
      - type: array
        items: File
    inputBinding:
      position: 1
      separate: true
      secondaryFiles: []
    id: '#genome_fasta_files'
outputs:
  - type:
      - 'null'
      - File
    outputBinding:
      glob:
        class: Expression
        engine: '#cwl-js-engine'
        script: '"output"'
    id: '#output'
requirements:
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
hints:
  - class: DockerRequirement
    dockerPull: sagnikbanerjee15/scripts
arguments:
  - position: 0
    prefix: ''
    separate: true
    valueFrom: '2'
stdout: output
