class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: msisensor2
baseCommand:
  - /opt/msisensor2/msisensor2
  - msi
inputs:
  - id: inputTumorBAM
    type: File
    inputBinding:
      position: 0
      prefix: '-t'
      shellQuote: false
    label: tumor BAM file
    secondaryFiles:
      - ^.bai
  - id: inputBED
    type: File?
    inputBinding:
      position: 0
      prefix: '-e'
      shellQuote: false
    label: bed file
  - 'sbg:toolDefaultValue': '0.05'
    id: FDR_threshold
    type: float?
    inputBinding:
      position: 0
      prefix: '-f'
      shellQuote: false
    label: FDR threshold for somatic sites detection
  - 'sbg:toolDefaultValue': '20'
    id: coverage_threshold
    type: int?
    inputBinding:
      position: 0
      prefix: '-c'
      shellQuote: false
    label: coverage threshold for msi analysis
    doc: |-
      WES: 20
      WGS: 15
  - 'sbg:toolDefaultValue': '5'
    id: min_homopolymer
    type: int?
    inputBinding:
      position: 0
      prefix: '-l'
      shellQuote: false
    label: minimal homopolymer size
  - 'sbg:toolDefaultValue': '10'
    id: min_homopolymer_dist
    type: int?
    inputBinding:
      position: 0
      prefix: '-p'
      shellQuote: false
    label: minimal homopolymer size for distribution analysis
  - 'sbg:toolDefaultValue': '50'
    id: max_homopolymer_dist
    type: int?
    inputBinding:
      position: 0
      prefix: '-m'
      shellQuote: false
    label: maximum homopolymer size for distribution analysis
  - 'sbg:toolDefaultValue': '3'
    id: min_microsates
    type: int?
    inputBinding:
      position: 0
      prefix: '-q'
      shellQuote: false
    label: minimal microsatellites size
  - 'sbg:toolDefaultValue': '5'
    id: min_microsates_dist
    type: int?
    inputBinding:
      position: 0
      prefix: '-s'
      shellQuote: false
    label: minimal microsates size for distribution analysis
  - 'sbg:toolDefaultValue': '40'
    id: max_microsates_dist
    type: int?
    inputBinding:
      position: 0
      prefix: '-w'
      shellQuote: false
    label: maximum microsatellites size for distribution analysis
  - id: span_window
    type: int?
    inputBinding:
      position: 0
      prefix: '-u'
      shellQuote: false
    label: span size around window for extracting reads
  - id: threads
    type: int
    inputBinding:
      position: 0
      prefix: '-b'
      shellQuote: false
    label: msisensor2 threads
  - id: inputNormalBAM
    type: File
    inputBinding:
      position: 0
      prefix: '-n'
      shellQuote: false
    label: Normal BAM file
    secondaryFiles:
      - ^.bai
  - id: coverage_normalization
    type: boolean
    inputBinding:
      position: 0
      prefix: '-z'
      shellQuote: false
      valueFrom: '1'
    label: Apply coverage normalization
  - id: homopolymer_satellites
    type: File
    inputBinding:
      position: 0
      prefix: '-d'
      shellQuote: false
outputs:
  - id: msi
    label: List of msi
    type: File
    outputBinding:
      glob: '*.msi'
  - id: msi_log
    type: File
    outputBinding:
      glob: '*.msi.out.log'
  - id: msi_dis
    type: File?
    outputBinding:
      glob: '*.msi_dis'
  - id: msi_somatic
    type: File?
    outputBinding:
      glob: '*msi_somatic'
  - id: msi_germline
    type: File?
    outputBinding:
      glob: '*.msi_germline'
doc: >-
  MSIsensor2 is a novel algorithm based machine learning, featuring a large
  upgrade in the microsatellite instability (MSI) detection for tumor only
  sequencing data, including Cell-Free DNA (cfDNA), Formalin-Fixed
  Paraffin-Embedded(FFPE) and other sample types. The original MSIsensor is
  specially designed for tumor/normal paired sequencing data.


  More information about the tool at:

  https://github.com/niu-lab/msisensor2




  Usage:  msisensor2 msi [options]

         -d   <string>   homopolymer and microsates file
         -n   <string>   normal bam file
         -t   <string>   tumor  bam file
         -M   <string>   models directory for tumor only data
         -o   <string>   output distribution file

         -e   <string>   bed file, optional
         -f   <double>   FDR threshold for somatic sites detection, default=0.05
         -c   <int>      coverage threshold for msi analysis, WXS: 20; WGS: 15, default=20
         -z   <int>      coverage normalization for paired tumor and normal data, 0: no; 1: yes, default=0
         -r   <string>   choose one region, format: 1:10000000-20000000
         -l   <int>      minimal homopolymer size, default=5
         -p   <int>      minimal homopolymer size for distribution analysis, default=10
         -m   <int>      maximal homopolymer size for distribution analysis, default=50
         -q   <int>      minimal microsates size, default=3
         -s   <int>      minimal microsates size for distribution analysis, default=5
         -w   <int>      maximal microstaes size for distribution analysis, default=40
         -u   <int>      span size around window for extracting reads, default=500
         -b   <int>      threads number for parallel computing, default=1
         -x   <int>      output homopolymer only, 0: no; 1: yes, default=0
         -y   <int>      output microsatellite only, 0: no; 1: yes, default=0

         -h   help



  *NOTE to developers*

  msisensor2 appears to require rw access in the directory that holds the
  models. Since the docker image runs as read_only it cannot work, but it does
  not croak. Instead i produces 0 msi. 

  As a remedy the /opt/models from within the image is copied to the temporary
  directory of the job and it is processed from there.
label: msisensor2 matched
arguments:
  - position: 0
    prefix: '-o'
    valueFrom: >-
      $( inputs.inputTumorBAM.nameroot + "-" + inputs.inputNormalBAM.nameroot +
      ".msi")
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    coresMin: $(inputs.threads)
  - class: DockerRequirement
    dockerPull: '064965165932.dkr.ecr.us-east-1.amazonaws.com/ngs/msisensor:v2'
  - class: InlineJavascriptRequirement
stdout: >-
  $( inputs.inputTumorBAM.nameroot + "-" + inputs.inputNormalBAM.nameroot +
  ".msi.out.log")
stderr: >-
  $( inputs.inputTumorBAM.nameroot + "-" + inputs.inputNormalBAM.nameroot +
  ".msi.err.log")
'sbg:toolkit': msisensor
'sbg:toolkitVersion': '2'
'sbg:wrapperAuthor': Konstantinos Mavrommatis