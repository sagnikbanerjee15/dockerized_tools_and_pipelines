class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: star_alignreads
baseCommand:
  - STAR
inputs:
  - id: runThreadN
    type: int?
    inputBinding:
      position: 0
      prefix: '--runThreadN'
  - id: readFilesIn
    type:
      - File
      - type: array
        items: File
    inputBinding:
      position: 0
      prefix: '--readFilesIn'
      shellQuote: false
      secondaryFiles: []
  - id: genomeDir
    type: Directory
    inputBinding:
      position: 0
      prefix: '--genomeDir'
  - id: outFileNamePrefix
    type: string?
    inputBinding:
      position: 0
      prefix: '--outFileNamePrefix'
      valueFrom: |-
        ${
            if(inputs.readFilesIn.length == 1)
            {
                return inputs.readFilesIn[0].path.split("/").slice(-1)[0].split(".").slice(0)[0] + "_"
            }
            else
            {
                return inputs.readFilesIn.path.split("/").slice(-1)[0].split(".").slice(0)[0].split("_").slice(0)[0] + "_"
            }
        }
outputs:
  - id: bam_output_file
    type: File?
    outputBinding:
      glob: '*bam'
  - id: sam_output_file
    type: File?
    outputBinding:
      glob: '*sam'
label: star-alignReads
arguments:
  - position: 0
    prefix: '--runMode'
    valueFrom: alignReads
requirements:
  - class: ShellCommandRequirement
  - class: ExpressionEngineRequirement
    id: '#cwl-js-engine'
    requirements:
      - class: DockerRequirement
        dockerPull: rabix/js-engine
  - class: InlineJavascriptRequirement
hints:
  - class: 'sbg:CPURequirement'
    value: 1
  - class: DockerRequirement
    dockerPull: 'sagnikbanerjee15/star:2.7.9a'
