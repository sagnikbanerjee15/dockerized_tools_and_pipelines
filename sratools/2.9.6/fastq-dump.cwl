cwlVersion: 'sbg:draft-2'
class: CommandLineTool
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: fastq_dump
label: fastq-dump
baseCommand:
  - fastq-dump
inputs:
  - type:
      - File
    inputBinding:
      position: 1
      separate: true
      secondaryFiles: []
    id: '#sra_file'
outputs:
  - type:
      - File
      - type: array
        items: File
    outputBinding:
      glob: '*fastq'
    id: '#fastq_file'
hints:
  - class: DockerRequirement
    dockerPull: 'sagnikbanerjee15/sratools:2.9.6'
arguments:
  - position: 0
    prefix: '--split-files'
    separate: true
    valueFrom: ' '
  - position: 0
    prefix: '--defline-seq'
    separate: true
    valueFrom: '''@$sn[_$rn]/$ri'''
  - position: 0
    prefix: '-O'
    separate: true
    valueFrom: .
