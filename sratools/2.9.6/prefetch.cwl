cwlVersion: 'sbg:draft-2'
class: CommandLineTool
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: prefetch
label: prefetch
baseCommand:
  - prefetch
inputs:
  - type:
      - string
    inputBinding:
      position: 0
    description: SRA read accession
    id: '#accession'
outputs:
  - type:
      - File
    outputBinding:
      glob: $(inputs.accession)/$(inputs.accession).sra
    id: '#sra_file'
hints:
  - class: DockerRequirement
    dockerPull: 'sagnikbanerjee15/sratools:2.9.6'
arguments:
  - position: 0
    prefix: '-X'
    separate: true
    valueFrom: '524288000'
  - position: 0
    prefix: '-O'
    separate: true
    valueFrom: .
