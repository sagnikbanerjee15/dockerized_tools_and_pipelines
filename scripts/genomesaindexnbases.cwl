cwlVersion: 'sbg:draft-2'
class: CommandLineTool
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: genomesaindexnbases
label: genomeSAindexNbases
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
hints:
  - class: DockerRequirement
    dockerPull: sagnikbanerjee15/scripts
arguments:
  - position: 0
    prefix: ''
    separate: true
    valueFrom: '1'
stdout: output
requirements:
  - id: '#cwl-js-engine'
    class: ExpressionEngineRequirement
    requirements:
      - dockerPull: rabix/js-engine
        class: DockerRequirement
