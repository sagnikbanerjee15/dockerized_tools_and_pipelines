class: CommandLineTool
cwlVersion: v1.2
$namespaces:
  sbg: 'https://sevenbridges.com'
id: bristol-myers-squibb/tools-and-pipelines/samtools-faidx-1-9-cwl1-0/2
baseCommand: []
inputs:
  - 'sbg:category': File Inputs
    id: in_reference
    type: File
    inputBinding:
      shellQuote: false
      position: 1
      valueFrom: |-
        ${
            if (inputs.region) {
                return [].concat(inputs.in_reference)[0].path
            }
            if (inputs.in_index) {
                var index_ext = [].concat(inputs.in_index)[0].path.substr([].concat(inputs.in_index)[0].path.lastIndexOf('.') + 1).toLowerCase()
                var input_ext = [].concat(inputs.in_reference)[0].path.substr([].concat(inputs.in_reference)[0].path.lastIndexOf('.') + 1).toLowerCase()
                if (index_ext === 'fai' && (input_ext === 'fasta' || input_ext === 'fa')) {
                    return ''
                } else {
                    return [].concat(inputs.in_reference)[0].path
                }
            } else {
                return [].concat(inputs.in_reference)[0].path
            }
        }
    label: Input FASTA file
    doc: Input FASTA file.
    'sbg:fileTypes': 'FASTA, FA, FASTA.GZ, FA.GZ, GZ'
  - 'sbg:category': File Inputs
    id: in_index
    type: File?
    label: Input index file
    doc: >-
      Input index file (FAI). It can be used for region extraction. If no region
      is specified and input FASTA file is already indexed, index file can be
      provided at this port. If it is provided, the tool will just pass it
      through. This option is useful for workflows when it is not know in
      advance if the index file is present in the project.
    'sbg:fileTypes': FAI
  - 'sbg:category': Config Inputs
    id: region
    type: string?
    inputBinding:
      shellQuote: false
      position: 100
    label: Region
    doc: >-
      Region of the reference that will be extracted in separate file. This file
      will not be indexed.
  - 'sbg:category': Config Inputs
    'sbg:toolDefaultValue': 'False'
    id: output_indexed_data
    type: boolean?
    label: Output indexed data file
    doc: >-
      Setting this parameter to True will provide FASTA/FA file (and FAI file as
      secondary file) at Indexed FASTA file output port. The default value is
      False.
  - 'sbg:altPrefix': '--length'
    'sbg:toolDefaultValue': '60'
    'sbg:category': Config Inputs
    id: length
    type: int?
    inputBinding:
      prefix: '-n'
      shellQuote: false
      position: 0
    label: Length of FASTA sequence line
    doc: Length of FASTA sequence line.
  - 'sbg:altPrefix': '--continue'
    'sbg:category': Config Inputs
    'sbg:toolDefaultValue': 'False'
    id: continue
    type: boolean?
    inputBinding:
      prefix: '-c'
      shellQuote: false
      position: 0
    label: Continue working if a non-existant region is requested
    doc: Continue working if a non-existant region is requested.
  - 'sbg:altPrefix': '--region-file'
    id: input_region_file
    type: File?
    inputBinding:
      prefix: '-r'
      shellQuote: false
      position: 0
    label: Read regions from a file
    doc: 'Read regions from a file. Format is chr:from-to, one per line.'
    'sbg:fileTypes': TXT
  - 'sbg:altPrefix': '--fastq'
    'sbg:category': Config Inputs
    'sbg:toolDefaultValue': 'False'
    id: fastq
    type: boolean?
    inputBinding:
      prefix: '-f'
      shellQuote: false
      position: 0
    label: >-
      Read FASTQ files and output extracted sequences in FASTQ format. Same as
      using samtools fqidx.
    doc: Read FASTQ files and output extracted sequences in FASTQ format.
  - 'sbg:altPrefix': '--reverse-complement'
    'sbg:category': Config Inputs
    'sbg:toolDefaultValue': 'False'
    id: reverse_complement
    type: boolean?
    inputBinding:
      prefix: '-i'
      shellQuote: false
      position: 0
    label: Output the sequence as the reverse complement
    doc: >-
      Output the sequence as the reverse complement. When this option is used,
      “/rc” will be appended to the sequence names.
  - 'sbg:category': Config Inputs
    'sbg:toolDefaultValue': rc
    id: mark_strand
    type: string?
    inputBinding:
      prefix: '--mark-strand'
      shellQuote: false
      position: 0
    label: Append strand indicator to sequence name
    doc: >-
      Append strand indicator to sequence name. It can be:  

      rc - Append '/rc' when writing the reverse complement. This is the
      default.

      no - Do not append anything.

      sign - Append '(+)' for forward strand or '(-)' for reverse complement.
      This matches the output of “bedtools getfasta -s”.

      custom,<pos>,<neg> - Append string <pos> to names when writing the forward
      strand and <neg> when writing the reverse strand.
  - 'sbg:category': Platform Options
    'sbg:toolDefaultValue': '1500'
    id: mem_per_job
    type: int?
    label: Memory per job
    doc: Memory per job in MB.
  - 'sbg:category': Platform Options
    'sbg:toolDefaultValue': '1'
    id: cpu_per_job
    type: int?
    label: CPU per job
    doc: Number of CPUs per job.
outputs:
  - id: out_reference
    doc: Output FASTA file along with its index as secondary file.
    label: Indexed FASTA file
    type: File?
    outputBinding:
      glob: |-
        ${
            if (inputs.region) {
                return
            }
            if (inputs.output_indexed_data) {
                return [].concat(inputs.in_reference)[0].path.split('/').pop()
            } else {
                return
            }
        }
      outputEval: |-
        ${
            for (var i = 0; i < self.length; i++){
                self[i] = inheritMetadata(self[i], inputs.in_reference);
                if (self.hasOwnProperty('secondaryFiles')){
                    for (var j = 0; j < self[i].secondaryFiles.length; j++){
                        self[i].secondaryFiles[j] = inheritMetadata(self[i].secondaryFiles[j], inputs.in_reference);
                    }
                }
            }
            return self;
        }
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: .gzi
        required: false
    'sbg:fileTypes': 'FASTA, FA, FASTA.GZ, FA.GZ, GZ'
  - id: out_index_fai
    doc: Generated FAI index file (without the FASTA file).
    label: Generated FAI index
    type: File?
    outputBinding:
      glob: |-
        ${
            if (inputs.region) {
                return
            } else {
                return '*.fai'
            }
        }
      outputEval: |-
        ${
            if (inputs.in_index) {
                for (var i = 0; i < self.length; i++){
                        self[i] = inheritMetadata(self[i], inputs.in_index);
            }
            return self
            }
            else {
            for (var i = 0; i < self.length; i++){
                        self[i] = inheritMetadata(self[i], inputs.in_reference);
            }
            return self;
            }
        }
    'sbg:fileTypes': FAI
  - id: out_index_gzi
    doc: Generated GZI index file (without the FASTA file).
    label: Generated GZI index
    type: File?
    outputBinding:
      glob: |-
        ${
            if (inputs.region) {
                return
            } else {
                return '*.gzi'
            }
        }
      outputEval: |-
        ${
            for (var i = 0; i < self.length; i++){
                        self[i] = inheritMetadata(self[i], inputs.in_reference);
            }
            return self;
        }
    'sbg:fileTypes': GZI
  - id: region_file
    doc: FASTA file containing specified region. This file in not indexed.
    label: Region FASTA file
    type: File?
    outputBinding:
      glob: |-
        ${
            input_filename = [].concat(inputs.in_reference)[0].path.split('/').pop()
            input_ext = input_filename.substr(input_filename.lastIndexOf('.') + 1).toLowerCase()
            if (input_ext === 'fasta' || input_ext === 'fa') {
                return input_filename.substring(0, input_filename.lastIndexOf('.')) + '.extracted.fasta'
            } else if (input_ext.toLowerCase() === 'gz') {
                input_filename = input_filename.substring(0, input_filename.lastIndexOf('.'))
                return input_filename.substring(0, input_filename.lastIndexOf('.')) + '.extracted.fasta'
            } else {
                return input_filename + '.extracted.fasta'
            }
        }
      outputEval: |-
        ${
            for (var i = 0; i < self.length; i++){
                self[i] = inheritMetadata(self[i], inputs.in_reference);
                if (self.hasOwnProperty('secondaryFiles')){
                    for (var j = 0; j < self[i].secondaryFiles.length; j++){
                        self[i].secondaryFiles[j] = inheritMetadata(self[i].secondaryFiles[j], inputs.in_alignments);
                    }
                }
            }
            return self;
        }
    'sbg:fileTypes': FASTA
doc: >-
  **SAMtools Faidx** tool is used to index FASTA reference sequence or extract
  subsequences. The input file can be compressed in the BGZF format [1].


  *A list of **all inputs and parameters** with corresponding descriptions can
  be found at the bottom of the page.*


  ###Common Use Cases 


  This tool works in two modes of operation:


  1. **Indexing FASTA file** - If no region is specified, the tool will index
  **Input FASTA file**. If the FASTA file is already indexed, its index can be
  provided at the **Input index file** input port. In this case, tool execution
  will be skipped and it will just pass the inputs through.

  2. **Extracting region subsequences** - If regions are specified, subsequences
  will be provided at the **Region FASTA file** output port. In this mode,
  **Input index file** can be provided, but it is not mandatory. If it is not
  provided, the tool will first index the file and then extract subsequences.  


  When using this tool in a workflow as the indexer, **Input index file** can be
  provided. In case it is provided, tool execution will be skipped and it will
  just pass the inputs through. This is useful for workflows which use tools
  that require an index file as a secondary file when it is not known in advance
  if the input FASTA file will have an accompanying index file present in the
  project. If the next tool in the workflow requires an index file as a
  secondary file, parameter **Output indexed data file** should be set to True.
  This will provide a FASTA file at the **Indexed FASTA file** output port along
  with its index file (FAI) as the secondary file.


  ###Changes Introduced by Seven Bridges


  - Parameter **Output indexed data file** is added to provide additional
  options for integration with other tools within a workflow. 

  - Parameter for output filename (`-o/--output`) is not exposed to the user.
  Output filename is *reference.fai* for input reference named
  *reference.fasta/reference.fa/reference.fasta.gz/reference.fa.gz*.


  ###Common Issues and Important Notes


  - The sequences in the input file should all have different names. If they do
  not, **SAMtools Faidx** will emit a warning about duplicate sequences and
  retrieval will only produce subsequences from the first sequence with the
  duplicated name [1].

  - **When using this tool in a workflow as the indexer, if the next tool in the
  workflow requires an index file as a secondary file, parameter Output indexed
  data file should be set to True. This will provide a FASTA file at the Indexed
  FASTA file output port along with its index file (FAI) as the secondary
  file.**


  ###Performance Benchmarking


  The execution time for indexing a FASTA file takes several minutes on the
  default instance; the price is negligible (~ $0.04). Unless specified
  otherwise, the default instance used to run the **SAMtools Faidx** tool will
  be c4.2xlarge (AWS).


  ###References


  [1] [SAMtools documentation](http://www.htslib.org/doc/samtools-1.9.html)
label: Samtools Faidx CWL1.0
arguments:
  - prefix: ''
    shellQuote: false
    position: 0
    valueFrom: |-
      ${
          if (inputs.region) 
          {
              return 'samtools faidx'
          } 
          else if (inputs.in_index) 
          {
              var index_ext = [].concat(inputs.in_index)[0].path.substr([].concat(inputs.in_index)[0].path.lastIndexOf('.') + 1).toLowerCase()
              input_ext = [].concat(inputs.in_reference)[0].path.substr([].concat(inputs.in_reference)[0].path.lastIndexOf('.') + 1).toLowerCase()
              if (index_ext === 'fai' && (input_ext === 'fasta' || input_ext === 'fa')) 
              {
                  return "echo Skipping index step because an index file is provided on the input."
              } 
              else 
              {
                  return "samtools faidx"
              }
          } 
          else 
          {
              return "samtools faidx"
          }
      }
  - prefix: ''
    shellQuote: false
    position: 101
    valueFrom: |-
      ${
          if (inputs.region) {
              var input_filename = [].concat(inputs.in_reference)[0].path.split('/').pop()
              var input_ext = input_filename.split('.').pop().toLowerCase()
              if (input_ext === 'fasta' || input_ext === 'fa') {
                  return '> ' + input_filename.substring(0, input_filename.lastIndexOf('.')) + '.extracted.fasta'
              } else if (input_ext === 'gz') {
                  var input_filename = input_filename.substring(0, input_filename.lastIndexOf('.'))
                  return '> ' + input_filename.substring(0, input_filename.lastIndexOf('.')) + '.extracted.fasta'
              } else {
                  return '> ' + input_filename + '.extracted.fasta'
              }
          }
      }
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: |-
      ${
          if (inputs.mem_per_job) {
              return inputs.mem_per_job
          }
          else {
              return 1500
          }
      }
          
    coresMin: |-
      ${
          if (inputs.cpu_per_job) {
              return inputs.cpu_per_job
          }
          else {
              return 1
          }
      }
  - class: DockerRequirement
    dockerPull: 'ghcr.io/sagnikbanerjee15/docker_tools_and_pipelines/samtools:1.14'
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.in_reference)
      - $(inputs.in_index)
  - class: InlineJavascriptRequirement
    expressionLib:
      - |
        var setMetadata = function(file, metadata) {
            if (!('metadata' in file)) {
                file['metadata'] = {}
            }
            for (var key in metadata) {
                file['metadata'][key] = metadata[key];
            }
            return file
        };

        var inheritMetadata = function(o1, o2) {
            var commonMetadata = {};
            if (!o2) {
                return o1;
            };
            if (!Array.isArray(o2)) {
                o2 = [o2]
            }
            for (var i = 0; i < o2.length; i++) {
                var example = o2[i]['metadata'];
                for (var key in example) {
                    if (i == 0)
                        commonMetadata[key] = example[key];
                    else {
                        if (!(commonMetadata[key] == example[key])) {
                            delete commonMetadata[key]
                        }
                    }
                }
                for (var key in commonMetadata) {
                    if (!(key in example)) {
                        delete commonMetadata[key]
                    }
                }
            }
            if (!Array.isArray(o1)) {
                o1 = setMetadata(o1, commonMetadata)
            } else {
                for (var i = 0; i < o1.length; i++) {
                    o1[i] = setMetadata(o1[i], commonMetadata)
                }
            }
            return o1;
        };
'sbg:toolAuthor': >-
  Heng Li (Sanger Institute), Bob Handsaker (Broad Institute), Jue Ruan (Beijing
  Genome Institute), Colin Hercus, Petr Danecek
'sbg:toolkit': SAMtools
'sbg:license': MIT License
'sbg:categories':
  - Utilities
  - FASTA Processing
'sbg:image_url': null
'sbg:toolkitVersion': '1.9'
'sbg:cmdPreview': /opt/samtools-1.9/samtools faidx  /path/to/in_reference.fa
'sbg:links':
  - id: 'http://www.htslib.org/'
    label: Homepage
  - id: 'https://github.com/samtools/samtools'
    label: Source Code
  - id: 'https://github.com/samtools/samtools/wiki'
    label: Wiki
  - id: 'https://sourceforge.net/projects/samtools/files/'
    label: Download
  - id: 'http://www.ncbi.nlm.nih.gov/pubmed/19505943'
    label: Publication
  - id: 'http://www.htslib.org/doc/samtools-1.9.html'
    label: Documentation
'sbg:projectName': tools_and_pipelines
'sbg:revisionsInfo':
  - 'sbg:revision': 0
    'sbg:modifiedBy': bristol-myers-squibb/baners23
    'sbg:modifiedOn': 1649889033
    'sbg:revisionNotes': Copy of admin/sbg-public-data/samtools-faidx-1-9-cwl1-0/7
  - 'sbg:revision': 1
    'sbg:modifiedBy': bristol-myers-squibb/baners23
    'sbg:modifiedOn': 1649889107
    'sbg:revisionNotes': ''
  - 'sbg:revision': 2
    'sbg:modifiedBy': bristol-myers-squibb/baners23
    'sbg:modifiedOn': 1649900072
    'sbg:revisionNotes': ''
'sbg:expand_workflow': false
'sbg:appVersion':
  - v1.2
'sbg:id': bristol-myers-squibb/tools-and-pipelines/samtools-faidx-1-9-cwl1-0/2
'sbg:revision': 2
'sbg:revisionNotes': ''
'sbg:modifiedOn': 1649900072
'sbg:modifiedBy': bristol-myers-squibb/baners23
'sbg:createdOn': 1649889033
'sbg:createdBy': bristol-myers-squibb/baners23
'sbg:project': bristol-myers-squibb/tools-and-pipelines
'sbg:sbgMaintained': false
'sbg:validationErrors': []
'sbg:contributors':
  - bristol-myers-squibb/baners23
'sbg:latestRevision': 2
'sbg:publisher': sbg
'sbg:content_hash': a8cc506964b2a3d55d94b9ba74d6bf7948b134d86fab68f7c2352bffddcad5c8c
'sbg:workflowLanguage': CWL
