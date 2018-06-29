{
  "description": "",
  "sbg:image_url": "https://igor.sbgenomics.com/ns/brood/images/dave/cgrhpv/hpv-typing-illumina-workflow/136.png",
  "hints": [
    {
      "value": "c4.8xlarge;ebs-gp2;700",
      "class": "sbg:AWSInstanceType"
    },
    {
      "value": "4",
      "class": "sbg:maxNumberOfParallelInstances"
    }
  ],
  "sbg:contributors": [
    "sarah",
    "dave"
  ],
  "sbg:sbgMaintained": false,
  "sbg:publisher": "sbg",
  "sbg:project": "dave/cgrhpv",
  "steps": [
    {
      "run": {
        "outputs": [
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#merged_json",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#json",
              "glob": {
                "engine": "#cwl-js-engine",
                "script": "\"*merged.json\"",
                "class": "Expression"
              }
            }
          }
        ],
        "description": "",
        "sbg:job": {
          "allocatedResources": {
            "mem": 1000,
            "cpu": 1
          },
          "inputs": {
            "prefix_for_output": "HPV_all_vcf",
            "input_suffix_and_extension": "concat.json",
            "json": [
              {
                "path": "path/to/sample01.json",
                "size": 0,
                "secondaryFiles": [],
                "class": "File"
              },
              {
                "path": "path/to/sample02.json",
                "size": 0,
                "secondaryFiles": [],
                "class": "File"
              }
            ]
          }
        },
        "inputs": [
          {
            "id": "#prefix_for_output",
            "type": [
              "null",
              "string"
            ]
          },
          {
            "sbg:stageInput": "link",
            "id": "#json",
            "type": [
              "null",
              {
                "items": "File",
                "type": "array"
              }
            ],
            "required": false
          },
          {
            "id": "#input_suffix_and_extension",
            "type": [
              "null",
              "string"
            ]
          }
        ],
        "stdout": "",
        "sbg:cmdPreview": "cat *concat.json > HPV_all_vcf_merged.json",
        "hints": [
          {
            "value": 1,
            "class": "sbg:CPURequirement"
          },
          {
            "value": 1000,
            "class": "sbg:MemRequirement"
          },
          {
            "dockerImageId": "",
            "dockerPull": "cgrlab/tidyverse",
            "class": "DockerRequirement"
          }
        ],
        "x": 664.4447263984894,
        "sbg:modifiedBy": "dave",
        "temporaryFailCodes": [],
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "successCodes": [],
        "stdin": "",
        "sbg:publisher": "sbg",
        "sbg:sbgMaintained": false,
        "sbg:revision": 8,
        "arguments": [
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "$job.inputs.prefix_for_output + \"_merged.json\"",
              "class": "Expression"
            },
            "prefix": ">",
            "separate": true,
            "position": 99
          }
        ],
        "sbg:project": "dave/cgrhpv",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:revision": 0,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486841449
          },
          {
            "sbg:revision": 1,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486841686
          },
          {
            "sbg:revision": 2,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486841826
          },
          {
            "sbg:revision": 3,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486858801
          },
          {
            "sbg:revision": 4,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486874369
          },
          {
            "sbg:revision": 5,
            "sbg:revisionNotes": "made a better cat app",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1494294732
          },
          {
            "sbg:revision": 6,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1495472946
          },
          {
            "sbg:revision": 7,
            "sbg:revisionNotes": "switched to wildcard",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1505248169
          },
          {
            "sbg:revision": 8,
            "sbg:revisionNotes": "added prefix input",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1505248365
          }
        ],
        "sbg:latestRevision": 8,
        "sbg:createdOn": 1486841449,
        "y": 190.69590542745303,
        "requirements": [
          {
            "requirements": [
              {
                "dockerPull": "rabix/js-engine",
                "class": "DockerRequirement"
              }
            ],
            "id": "#cwl-js-engine",
            "class": "ExpressionEngineRequirement"
          }
        ],
        "class": "CommandLineTool",
        "sbg:projectName": "cgrHPV",
        "sbg:validationErrors": [],
        "sbg:id": "dave/cgrhpv/cat-json/8",
        "sbg:createdBy": "dave",
        "id": "dave/cgrhpv/cat-json/8",
        "baseCommand": [
          "cat",
          {
            "engine": "#cwl-js-engine",
            "script": "'*' + $job.inputs.input_suffix_and_extension",
            "class": "Expression"
          }
        ],
        "sbg:image_url": null,
        "sbg:modifiedOn": 1505248365,
        "cwlVersion": "sbg:draft-2",
        "sbg:revisionNotes": "added prefix input",
        "label": "merge hpv types"
      },
      "outputs": [
        {
          "id": "#cat_json.merged_json"
        }
      ],
      "inputs": [
        {
          "id": "#cat_json.prefix_for_output",
          "default": "illumina_hpv_types"
        },
        {
          "id": "#cat_json.json",
          "source": [
            "#illumina_typing_run_processor.hpv_types"
          ]
        },
        {
          "id": "#cat_json.input_suffix_and_extension",
          "default": "hpv_types.json"
        }
      ],
      "sbg:x": 664.4447263984894,
      "id": "#cat_json",
      "sbg:y": 190.69590542745303
    },
    {
      "run": {
        "outputs": [
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#typing_reference",
            "outputBinding": {
              "glob": {
                "engine": "#cwl-js-engine",
                "script": "\"*.fasta\"",
                "class": "Expression"
              }
            }
          }
        ],
        "description": "",
        "sbg:image_url": null,
        "sbg:job": {
          "allocatedResources": {
            "mem": 1000,
            "cpu": 1
          },
          "inputs": {}
        },
        "stdin": "",
        "stdout": "",
        "sbg:cmdPreview": "cp /opt/HPV-Typing_MiSeq_Ref_Nov2017.fasta ./",
        "sbg:sbgMaintained": false,
        "x": -364.61544754660576,
        "sbg:modifiedBy": "dave",
        "temporaryFailCodes": [],
        "successCodes": [],
        "sbg:publisher": "sbg",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "arguments": [],
        "sbg:revision": 1,
        "sbg:contributors": [
          "dave"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:revision": 0,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520652650
          },
          {
            "sbg:revision": 1,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520652803
          }
        ],
        "sbg:latestRevision": 1,
        "sbg:createdOn": 1520652650,
        "y": 282.3197288886598,
        "requirements": [],
        "class": "CommandLineTool",
        "sbg:projectName": "cgrHPV",
        "baseCommand": [
          "cp",
          "/opt/HPV-Typing_MiSeq_Ref_Nov2017.fasta",
          "./"
        ],
        "sbg:project": "dave/cgrhpv",
        "id": "dave/cgrhpv/illumina-typeseqer-hpv-reference/1",
        "sbg:createdBy": "dave",
        "label": "illumina-typeseqer-hpv-reference",
        "sbg:validationErrors": [],
        "inputs": [],
        "sbg:modifiedOn": 1520652803,
        "cwlVersion": "sbg:draft-2",
        "hints": [
          {
            "value": 1,
            "class": "sbg:CPURequirement"
          },
          {
            "value": 1000,
            "class": "sbg:MemRequirement"
          },
          {
            "dockerImageId": "",
            "dockerPull": "cgrlab/typeseqer:latest",
            "class": "DockerRequirement"
          }
        ],
        "sbg:id": "dave/cgrhpv/illumina-typeseqer-hpv-reference/1"
      },
      "outputs": [
        {
          "id": "#illumina_typeseqer_hpv_reference.typing_reference"
        }
      ],
      "inputs": [],
      "sbg:x": -364.61544754660576,
      "id": "#illumina_typeseqer_hpv_reference",
      "sbg:y": 282.3197288886598
    },
    {
      "run": {
        "outputs": [
          {
            "description": "TARed fasta with its BWA indices.",
            "label": "TARed fasta with its BWA indices",
            "sbg:fileTypes": "TAR",
            "outputBinding": {
              "sbg:metadata": {
                "reference": {
                  "engine": "#cwl-js-engine",
                  "script": "{\n  path = [].concat($job.inputs.reference)[0].path.split('/')\n  last = path.pop()\n  return last\n}",
                  "class": "Expression"
                }
              },
              "sbg:inheritMetadataFrom": "#reference",
              "glob": {
                "engine": "#cwl-js-engine",
                "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar'){\n    return reference_file\n  }\n  else{\n    return reference_file + '.tar'\n  }\n}\n",
                "class": "Expression"
              }
            },
            "id": "#indexed_reference",
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "description": "BWA INDEX constructs the FM-index (Full-text index in Minute space) for the reference genome.\nGenerated index files will be used with BWA MEM, BWA ALN, BWA SAMPE and BWA SAMSE tools.\n\nIf input reference file has TAR extension it is assumed that BWA indices came together with it. BWA INDEX will only pass that TAR to the output. If input is not TAR, the creation of BWA indices and its packing in TAR file (together with the reference) will be performed.",
        "sbg:categories": [
          "Indexing",
          "FASTA-Processing"
        ],
        "sbg:job": {
          "allocatedResources": {
            "mem": 1536,
            "cpu": 1
          },
          "inputs": {
            "bwt_construction": "bwtsw",
            "reference": {
              "path": "/path/to/the/reference.fasta",
              "size": 0,
              "secondaryFiles": [
                {
                  "path": ".amb"
                },
                {
                  "path": ".ann"
                },
                {
                  "path": ".bwt"
                },
                {
                  "path": ".pac"
                },
                {
                  "path": ".sa"
                }
              ],
              "class": "File"
            },
            "total_memory": null,
            "prefix_of_the_index_to_be_output": "prefix",
            "block_size": 0,
            "add_64_to_fasta_name": true
          }
        },
        "inputs": [
          {
            "id": "#total_memory",
            "description": "Total memory [GB] to be reserved for the tool (Default value is 1.5 x size_of_the_reference).",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Configuration",
            "label": "Total memory [Gb]"
          },
          {
            "sbg:stageInput": "link",
            "description": "Input reference fasta of TAR file with reference and indices.",
            "label": "Reference",
            "sbg:fileTypes": "FASTA,FA,FA.GZ,FASTA.GZ,TAR",
            "id": "#reference",
            "type": [
              "File"
            ],
            "sbg:category": "File input",
            "required": true
          },
          {
            "id": "#prefix_of_the_index_to_be_output",
            "description": "Prefix of the index [same as fasta name].",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "Configuration",
            "label": "Prefix of the index to be output"
          },
          {
            "description": "Algorithm for constructing BWT index. Available options are:s\tIS linear-time algorithm for constructing suffix array. It requires 5.37N memory where N is the size of the database. IS is moderately fast, but does not work with database larger than 2GB. IS is the default algorithm due to its simplicity. The current codes for IS algorithm are reimplemented by Yuta Mori. bwtsw\tAlgorithm implemented in BWT-SW. This method works with the whole human genome. Warning: `-a bwtsw' does not work for short genomes, while `-a is' and `-a div' do not work not for long genomes.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-a",
              "separate": true
            },
            "label": "Bwt construction",
            "sbg:toolDefaultValue": "auto",
            "id": "#bwt_construction",
            "type": [
              "null",
              {
                "name": "bwt_construction",
                "type": "enum",
                "symbols": [
                  "bwtsw",
                  "is",
                  "div"
                ]
              }
            ],
            "sbg:category": "Configuration"
          },
          {
            "description": "Block size for the bwtsw algorithm (effective with -a bwtsw).",
            "label": "Block size",
            "sbg:toolDefaultValue": "10000000",
            "id": "#block_size",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Configuration"
          },
          {
            "id": "#add_64_to_fasta_name",
            "description": "Index files named as <in.fasta>64 instead of <in.fasta>.*.",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "Configuration",
            "label": "Output index files renamed by adding 64"
          }
        ],
        "stdout": "",
        "sbg:cmdPreview": "bwa index reference.fasta   -a bwtsw      -6    ; tar -cf reference.fasta.tar reference.fasta *.amb *.ann *.bwt *.pac *.sa",
        "hints": [
          {
            "dockerImageId": "2f813371e803",
            "dockerPull": "cgrlab/typeseqer:latest",
            "class": "DockerRequirement"
          },
          {
            "value": 1,
            "class": "sbg:CPURequirement"
          },
          {
            "value": {
              "engine": "#cwl-js-engine",
              "script": "{\n  GB_1 = 1024*1024*1024\n  reads_size = $job.inputs.reference.size\n\n  if(!reads_size) { reads_size = GB_1 }\n  \n  if($job.inputs.total_memory){\n    return $job.inputs.total_memory * 1024\n  } else {\n    return (parseInt(1.5 * reads_size / (1024*1024)))\n  }\n}",
              "class": "Expression"
            },
            "class": "sbg:MemRequirement"
          }
        ],
        "x": -191.70946084066048,
        "id": "dave/cgrhpv/bwa-index/1",
        "sbg:sbgMaintained": false,
        "temporaryFailCodes": [],
        "successCodes": [],
        "sbg:revision": 1,
        "sbg:publisher": "sbg",
        "sbg:license": "GNU Affero General Public License v3.0, MIT License",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:toolkitVersion": "0.7.13",
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "arguments": [
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar' || !$job.inputs.bwt_construction){\n    return ''\n  } else {\n    return '-a ' + $job.inputs.bwt_construction\n  }\n}",
              "class": "Expression"
            },
            "separate": true
          },
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar' || !$job.inputs.prefix){\n    return ''\n  } else {\n    return '-p ' + $job.inputs.prefix\n  }\n}\n",
              "class": "Expression"
            },
            "separate": true
          },
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar' || !$job.inputs.block_size){\n    return ''\n  } else {\n    return '-b ' + $job.inputs.block_size\n  }\n}\n\n",
              "class": "Expression"
            },
            "separate": true
          },
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar' || !$job.inputs.add_64_to_fasta_name){\n    return ''\n  } else {\n    return '-6 '\n  }\n}\n",
              "class": "Expression"
            },
            "separate": true
          },
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar'){\n    return ''\n  }\n  else{\n    tar_cmd = 'tar -cf ' + reference_file + '.tar ' + reference_file + ' *.amb' + ' *.ann' + ' *.bwt' + ' *.pac' + ' *.sa' \n    return ' ; ' + tar_cmd\n  }\n}",
              "class": "Expression"
            },
            "separate": true
          }
        ],
        "sbg:toolAuthor": "Heng Li",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:revision": 0,
            "sbg:revisionNotes": "Copy of admin/sbg-public-data/bwa-index/33",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510550269
          },
          {
            "sbg:revision": 1,
            "sbg:revisionNotes": "corrected bwa command line",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520716437
          }
        ],
        "sbg:latestRevision": 1,
        "sbg:createdOn": 1510550269,
        "y": 217.91468969417403,
        "requirements": [
          {
            "requirements": [
              {
                "dockerPull": "rabix/js-engine",
                "class": "DockerRequirement"
              }
            ],
            "id": "#cwl-js-engine",
            "class": "ExpressionEngineRequirement"
          }
        ],
        "class": "CommandLineTool",
        "sbg:projectName": "cgrHPV",
        "baseCommand": [
          {
            "engine": "#cwl-js-engine",
            "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar'){\n    return 'echo Index files passed without any processing!'\n  }\n  else{\n    index_cmd = 'bwa index '+ reference_file + ' '\n    return index_cmd\n  }\n}",
            "class": "Expression"
          }
        ],
        "sbg:project": "dave/cgrhpv",
        "stdin": "",
        "sbg:modifiedBy": "dave",
        "label": "BWA INDEX",
        "sbg:validationErrors": [],
        "sbg:toolkit": "BWA",
        "sbg:image_url": null,
        "sbg:links": [
          {
            "id": "http://bio-bwa.sourceforge.net/",
            "label": "Homepage"
          },
          {
            "id": "https://github.com/lh3/bwa",
            "label": "Source code"
          },
          {
            "id": "http://bio-bwa.sourceforge.net/bwa.shtml",
            "label": "Wiki"
          },
          {
            "id": "http://sourceforge.net/projects/bio-bwa/",
            "label": "Download"
          },
          {
            "id": "http://www.ncbi.nlm.nih.gov/pubmed/19451168",
            "label": "Publication"
          }
        ],
        "sbg:modifiedOn": 1520716437,
        "cwlVersion": "sbg:draft-2",
        "sbg:revisionNotes": "corrected bwa command line",
        "sbg:createdBy": "dave",
        "sbg:id": "dave/cgrhpv/bwa-index/1"
      },
      "outputs": [
        {
          "id": "#BWA_INDEX.indexed_reference"
        }
      ],
      "inputs": [
        {
          "id": "#BWA_INDEX.total_memory"
        },
        {
          "id": "#BWA_INDEX.reference",
          "source": [
            "#illumina_typeseqer_hpv_reference.typing_reference"
          ]
        },
        {
          "id": "#BWA_INDEX.prefix_of_the_index_to_be_output"
        },
        {
          "id": "#BWA_INDEX.bwt_construction"
        },
        {
          "id": "#BWA_INDEX.block_size"
        },
        {
          "id": "#BWA_INDEX.add_64_to_fasta_name"
        }
      ],
      "sbg:x": -191.70946084066048,
      "id": "#BWA_INDEX",
      "sbg:y": 217.91468969417403
    },
    {
      "run": {
        "outputs": [
          {
            "description": "Aligned reads.",
            "label": "Aligned SAM/BAM",
            "sbg:fileTypes": "SAM, BAM",
            "outputBinding": {
              "sbg:metadata": {
                "reference_genome": {
                  "engine": "#cwl-js-engine",
                  "script": "{\n  reference_file = $job.inputs.reference_index_tar.path.split('/')[$job.inputs.reference_index_tar.path.split('/').length-1]\n  name = reference_file.slice(0, -4) // cut .tar extension \n  \n  name_list = name.split('.')\n  ext = name_list[name_list.length-1]\n\n  if (ext == 'gz' || ext == 'GZ'){\n    a = name_list.pop() // strip fasta.gz\n    a = name_list.pop()\n  } else\n    a = name_list.pop() //strip only fasta/fa\n  \n  return name_list.join('.')\n  \n}",
                  "class": "Expression"
                }
              },
              "sbg:inheritMetadataFrom": "#input_reads",
              "secondaryFiles": [
                ".bai",
                "^.bai"
              ],
              "glob": "{*.sam,*.bam}"
            },
            "id": "#aligned_reads",
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "description": "**BWA MEM** is an algorithm designed for aligning sequence reads onto a large reference genome. BWA MEM is implemented as a component of BWA. The algorithm can automatically choose between performing end-to-end and local alignments. BWA MEM is capable of outputting multiple alignments, and finding chimeric reads. It can be applied to a wide range of read lengths, from 70 bp to several megabases. \n\nIn order to obtain possibilities for additional fast processing of aligned reads, two tools are embedded together into the same package with BWA MEM (0.7.13): Samblaster. (0.1.22) and Sambamba (v0.6.0). \nIf deduplication of alignments is needed, it can be done by setting the parameter 'Duplication'. **Samblaster** will be used internally to perform this action.\nBesides the standard BWA MEM SAM output file, BWA MEM package has been extended to support two additional output options: a BAM file obtained by piping through **Sambamba view** while filtering out the secondary alignments, as well as a Coordinate Sorted BAM option that additionally pipes the output through **Sambamba sort**, along with an accompanying .bai file produced by **Sambamba sort** as side effect. Parameters responsible for these additional features are 'Filter out secondary alignments' and 'Output format'. Passing data from BWA MEM to Samblaster and Sambamba tools has been done through the pipes which saves processing times of two read and write of aligned reads into the hard drive. \n\nFor input reads fastq files of total size less than 10 GB we suggest using the default setting for parameter 'total memory' of 15GB, for larger files we suggest using 58 GB of memory and 32 CPU cores.\n\n**Important:**\nIn order to work BWA MEM Bundle requires fasta reference file accompanied with **bwa fasta indices** in TAR file.\nThere is the **known issue** with samblaster. It does not support processing when number of sequences in fasta is larger than 32768. If this is the case do not use deduplication option because the output BAM will be corrupted.",
        "sbg:categories": [
          "Alignment",
          "FASTQ-Processing"
        ],
        "sbg:job": {
          "allocatedResources": {
            "mem": 16000,
            "cpu": 8
          },
          "inputs": {
            "output_name": "",
            "rg_sample_id": "",
            "skip_seeds": null,
            "total_memory": 58,
            "band_width": null,
            "read_group_header": "",
            "rg_library_id": "",
            "deduplication": "MarkDuplicates",
            "rg_median_fragment_length": "",
            "reserved_threads": 3,
            "filter_out_secondary_alignments": true,
            "rg_platform": null,
            "threads": 8,
            "input_reads": [
              {
                "path": "/path/to/LP6005524-DNA_C01_lane_7.sorted.converted.filtered.pe_1.gz",
                "size": 30000000000,
                "secondaryFiles": [],
                "class": "File"
              },
              {
                "path": "/path/to/LP6005524-DNA_C01_lane_7.sorted.converted.filtered.pe_2.gz",
                "secondaryFiles": []
              }
            ],
            "sort_memory": 32,
            "reference_index_tar": {
              "path": "/path/to/reference.b37.fasta.gz.tar",
              "size": 0,
              "secondaryFiles": [
                {
                  "path": ".amb"
                },
                {
                  "path": ".ann"
                },
                {
                  "path": ".bwt"
                },
                {
                  "path": ".pac"
                },
                {
                  "path": ".sa"
                }
              ],
              "class": "File"
            },
            "output_format": "SortedBAM",
            "sambamba_threads": 8,
            "rg_data_submitting_center": "",
            "rg_platform_unit_id": ""
          }
        },
        "inputs": [
          {
            "description": "Verbose level: 1=error, 2=warning, 3=message, 4+=debugging.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-v",
              "separate": true
            },
            "label": "Verbose level",
            "sbg:toolDefaultValue": "3",
            "id": "#verbose_level",
            "type": [
              "null",
              {
                "name": "verbose_level",
                "type": "enum",
                "symbols": [
                  "1",
                  "2",
                  "3",
                  "4"
                ]
              }
            ],
            "sbg:category": "BWA Input/output options"
          },
          {
            "description": "Use soft clipping for supplementary alignments.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-Y",
              "separate": true
            },
            "label": "Use soft clipping",
            "id": "#use_soft_clipping",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options"
          },
          {
            "description": "Penalty for an unpaired read pair.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-U",
              "separate": true
            },
            "label": "Unpaired read penalty",
            "sbg:toolDefaultValue": "17",
            "id": "#unpaired_read_penalty",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Scoring options"
          },
          {
            "sbg:stageInput": null,
            "description": "Total memory to be used by the tool in GB. It's sum of BWA, Sambamba Sort and Samblaster. For fastq files of total size less than 10GB, we suggest using the default setting of 15GB, for larger files we suggest using 58GB of memory (and 32CPU cores).",
            "label": "Total memory",
            "sbg:toolDefaultValue": "15",
            "id": "#total_memory",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution"
          },
          {
            "description": "Number of threads for BWA, Samblaster and Sambamba sort process.",
            "label": "Threads",
            "sbg:toolDefaultValue": "8",
            "id": "#threads",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution"
          },
          {
            "description": "Specify the mean, standard deviation (10% of the mean if absent), max (4 sigma from the mean if absent) and min of the insert size distribution.FR orientation only. This array can have maximum four values, where first two should be specified as FLOAT and last two as INT.",
            "inputBinding": {
              "itemSeparator": null,
              "sbg:cmdInclude": true,
              "prefix": "-I",
              "separate": false
            },
            "label": "Specify distribution parameters",
            "id": "#speficy_distribution_parameters",
            "type": [
              "null",
              {
                "items": "float",
                "name": "speficy_distribution_parameters",
                "type": "array"
              }
            ],
            "sbg:category": "BWA Input/output options"
          },
          {
            "id": "#sort_memory",
            "description": "Amount of RAM [Gb] to give to the sorting algorithm (if not provided will be set to one third of the total memory).",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution",
            "label": "Memory for BAM sorting"
          },
          {
            "description": "Smart pairing in input FASTQ file (ignoring in2.fq).",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-p",
              "separate": true
            },
            "label": "Smart pairing in input FASTQ file",
            "id": "#smart_pairing_in_input_fastq",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options"
          },
          {
            "description": "Skip seeds with more than INT occurrences.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-c",
              "separate": true
            },
            "label": "Skip seeds with more than INT occurrences",
            "sbg:toolDefaultValue": "500",
            "id": "#skip_seeds",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Algorithm options"
          },
          {
            "description": "Skip pairing; mate rescue performed unless -S also in use.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-P",
              "separate": true
            },
            "label": "Skip pairing",
            "id": "#skip_pairing",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Algorithm options"
          },
          {
            "description": "Skip mate rescue.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-S",
              "separate": true
            },
            "label": "Skip mate rescue",
            "id": "#skip_mate_rescue",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Algorithm options"
          },
          {
            "description": "Look for internal seeds inside a seed longer than {-k} * FLOAT.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-r",
              "separate": true
            },
            "label": "Select seeds",
            "sbg:toolDefaultValue": "1.5",
            "id": "#select_seeds",
            "type": [
              "null",
              "float"
            ],
            "sbg:category": "BWA Algorithm options"
          },
          {
            "description": "Seed occurrence for the 3rd round seeding.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-y",
              "separate": true
            },
            "label": "Seed occurrence for the 3rd round",
            "sbg:toolDefaultValue": "20",
            "id": "#seed_occurrence_for_the_3rd_round",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Algorithm options"
          },
          {
            "description": "Score for a sequence match, which scales options -TdBOELU unless overridden.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-A",
              "separate": true
            },
            "label": "Score for a sequence match",
            "sbg:toolDefaultValue": "1",
            "id": "#score_for_a_sequence_match",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Scoring options"
          },
          {
            "id": "#sambamba_threads",
            "description": "Number of threads to pass to Sambamba sort, if used.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution",
            "label": "Sambamba Sort threads"
          },
          {
            "description": "Specify the sample ID for RG line - A human readable identifier for a sample or specimen, which could contain some metadata information. A sample or specimen is material taken from a biological entity for testing, diagnosis, propagation, treatment, or research purposes, including but not limited to tissues, body fluids, cells, organs, embryos, body excretory products, etc.",
            "label": "Sample ID",
            "sbg:toolDefaultValue": "Inferred from metadata",
            "id": "#rg_sample_id",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Read Group Options"
          },
          {
            "description": "Specify the platform unit (lane/slide) for RG line - An identifier for lanes (Illumina), or for slides (SOLiD) in the case that a library was split and ran over multiple lanes on the flow cell or slides.",
            "label": "Platform unit ID",
            "sbg:toolDefaultValue": "Inferred from metadata",
            "id": "#rg_platform_unit_id",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Read Group Options"
          },
          {
            "description": "Specify the version of the technology that was used for sequencing, which will be placed in RG line.",
            "label": "Platform",
            "sbg:toolDefaultValue": "Inferred from metadata",
            "id": "#rg_platform",
            "type": [
              "null",
              {
                "name": "rg_platform",
                "type": "enum",
                "symbols": [
                  "454",
                  "Helicos",
                  "Illumina",
                  "Solid",
                  "IonTorrent"
                ]
              }
            ],
            "sbg:category": "BWA Read Group Options"
          },
          {
            "id": "#rg_median_fragment_length",
            "description": "Specify the median fragment length for RG line.",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Read Group Options",
            "label": "Median fragment length"
          },
          {
            "description": "Specify the identifier for the sequencing library preparation, which will be placed in RG line.",
            "label": "Library ID",
            "sbg:toolDefaultValue": "Inferred from metadata",
            "id": "#rg_library_id",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Read Group Options"
          },
          {
            "id": "#rg_data_submitting_center",
            "description": "Specify the data submitting center for RG line.",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Read Group Options",
            "label": "Data submitting center"
          },
          {
            "sbg:stageInput": null,
            "description": "Reserved number of threads on the instance used by scheduler.",
            "label": "Reserved number of threads on the instance",
            "sbg:toolDefaultValue": "1",
            "id": "#reserved_threads",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Configuration"
          },
          {
            "sbg:stageInput": "link",
            "description": "Reference fasta file with BWA index files packed in TAR.",
            "label": "Reference Index TAR",
            "sbg:fileTypes": "TAR",
            "id": "#reference_index_tar",
            "type": [
              "File"
            ],
            "sbg:category": "Input files",
            "required": true
          },
          {
            "description": "Sequencing technology-specific settings; Setting -x changes multiple parameters unless overriden. pacbio: -k17 -W40 -r10 -A1 -B1 -O1 -E1 -L0  (PacBio reads to ref). ont2d: -k14 -W20 -r10 -A1 -B1 -O1 -E1 -L0  (Oxford Nanopore 2D-reads to ref). intractg: -B9 -O16 -L5  (intra-species contigs to ref).",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-x",
              "separate": true
            },
            "label": "Sequencing technology-specific settings",
            "id": "#read_type",
            "type": [
              "null",
              {
                "name": "read_type",
                "type": "enum",
                "symbols": [
                  "pacbio",
                  "ont2d",
                  "intractg"
                ]
              }
            ],
            "sbg:category": "BWA Scoring options"
          },
          {
            "description": "Read group header line such as '@RG\\tID:foo\\tSM:bar'.  This value takes precedence over per-attribute parameters.",
            "label": "Read group header",
            "sbg:toolDefaultValue": "Constructed from per-attribute parameters or inferred from metadata.",
            "id": "#read_group_header",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Read Group Options"
          },
          {
            "id": "#output_name",
            "description": "Name of the output BAM file.",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "Configuration",
            "label": "Output SAM/BAM file name"
          },
          {
            "description": "If there are <INT hits with score >80% of the max score, output all in XA. This array should have no more than two values.",
            "inputBinding": {
              "itemSeparator": ",",
              "sbg:cmdInclude": true,
              "prefix": "-h",
              "separate": false
            },
            "label": "Output in XA",
            "sbg:toolDefaultValue": "[5, 200]",
            "id": "#output_in_xa",
            "type": [
              "null",
              {
                "items": "int",
                "type": "array"
              }
            ],
            "sbg:category": "BWA Input/output options"
          },
          {
            "description": "Output the reference FASTA header in the XR tag.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-V",
              "separate": true
            },
            "label": "Output header",
            "id": "#output_header",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options"
          },
          {
            "description": "Specify output format (Sorted BAM option will output coordinate sorted BAM).",
            "label": "Output format",
            "sbg:toolDefaultValue": "SortedBAM",
            "id": "#output_format",
            "type": [
              "null",
              {
                "name": "output_format",
                "type": "enum",
                "symbols": [
                  "SAM",
                  "BAM",
                  "SortedBAM"
                ]
              }
            ],
            "sbg:category": "Execution"
          },
          {
            "description": "Output all alignments for SE or unpaired PE.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-a",
              "separate": true
            },
            "label": "Output alignments",
            "id": "#output_alignments",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options"
          },
          {
            "description": "Penalty for a mismatch.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-B",
              "separate": true
            },
            "label": "Mismatch penalty",
            "sbg:toolDefaultValue": "4",
            "id": "#mismatch_penalty",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Scoring options"
          },
          {
            "description": "Minimum seed length for BWA MEM.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-k",
              "separate": true
            },
            "label": "Minimum seed length",
            "sbg:toolDefaultValue": "19",
            "id": "#minimum_seed_length",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Algorithm options"
          },
          {
            "description": "Minimum alignment score for a read to be output in SAM/BAM.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-T",
              "separate": true
            },
            "label": "Minimum alignment score for a read to be output in SAM/BAM",
            "sbg:toolDefaultValue": "30",
            "id": "#minimum_output_score",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Input/output options"
          },
          {
            "description": "Perform at most INT rounds of mate rescues for each read.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-m",
              "separate": true
            },
            "label": "Mate rescue rounds",
            "sbg:toolDefaultValue": "50",
            "id": "#mate_rescue_rounds",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Algorithm options"
          },
          {
            "description": "Mark shorter split hits as secondary.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-M",
              "separate": true
            },
            "label": "Mark shorter",
            "id": "#mark_shorter",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options"
          },
          {
            "description": "Insert STR to header if it starts with @; or insert lines in FILE.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-H",
              "separate": true
            },
            "label": "Insert string to output SAM or BAM header",
            "id": "#insert_string_to_header",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Input/output options"
          },
          {
            "description": "Input sequence reads.",
            "label": "Input reads",
            "sbg:fileTypes": "FASTQ, FASTQ.GZ, FQ, FQ.GZ",
            "id": "#input_reads",
            "type": [
              {
                "items": "File",
                "name": "input_reads",
                "type": "array"
              }
            ],
            "sbg:category": "Input files",
            "required": true
          },
          {
            "description": "Treat ALT contigs as part of the primary assembly (i.e. ignore <idxbase>.alt file).",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-j",
              "separate": true
            },
            "label": "Ignore ALT file",
            "id": "#ignore_alt_file",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options"
          },
          {
            "description": "Gap open penalties for deletions and insertions. This array can't have more than two values.",
            "inputBinding": {
              "itemSeparator": ",",
              "sbg:cmdInclude": true,
              "prefix": "-O",
              "separate": false
            },
            "label": "Gap open penalties",
            "sbg:toolDefaultValue": "[6,6]",
            "id": "#gap_open_penalties",
            "type": [
              "null",
              {
                "items": "int",
                "type": "array"
              }
            ],
            "sbg:category": "BWA Scoring options"
          },
          {
            "description": "Gap extension penalty; a gap of size k cost '{-O} + {-E}*k'. This array can't have more than two values.",
            "inputBinding": {
              "itemSeparator": ",",
              "sbg:cmdInclude": true,
              "prefix": "-E",
              "separate": false
            },
            "label": "Gap extension",
            "sbg:toolDefaultValue": "[1,1]",
            "id": "#gap_extension_penalties",
            "type": [
              "null",
              {
                "items": "int",
                "type": "array"
              }
            ],
            "sbg:category": "BWA Scoring options"
          },
          {
            "sbg:stageInput": null,
            "description": "Filter out secondary alignments. Sambamba view tool will be used to perform this internally.",
            "label": "Filter out secondary alignments",
            "sbg:toolDefaultValue": "False",
            "id": "#filter_out_secondary_alignments",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "Execution"
          },
          {
            "description": "Off-diagonal X-dropoff.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-d",
              "separate": true
            },
            "label": "Dropoff",
            "sbg:toolDefaultValue": "100",
            "id": "#dropoff",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Algorithm options"
          },
          {
            "description": "Drop chains shorter than FLOAT fraction of the longest overlapping chain.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-D",
              "separate": true
            },
            "label": "Drop chains fraction",
            "sbg:toolDefaultValue": "0.50",
            "id": "#drop_chains_fraction",
            "type": [
              "null",
              "float"
            ],
            "sbg:category": "BWA Algorithm options"
          },
          {
            "description": "Discard full-length exact matches.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-e",
              "separate": true
            },
            "label": "Discard exact matches",
            "id": "#discard_exact_matches",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Algorithm options"
          },
          {
            "description": "Discard a chain if seeded bases shorter than INT.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-W",
              "separate": true
            },
            "label": "Discard chain length",
            "sbg:toolDefaultValue": "0",
            "id": "#discard_chain_length",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Algorithm options"
          },
          {
            "description": "Use Samblaster for finding duplicates on sequence reads.",
            "label": "PCR duplicate detection",
            "sbg:toolDefaultValue": "MarkDuplicates",
            "id": "#deduplication",
            "type": [
              "null",
              {
                "name": "deduplication",
                "type": "enum",
                "symbols": [
                  "None",
                  "MarkDuplicates",
                  "RemoveDuplicates"
                ]
              }
            ],
            "sbg:category": "Samblaster parameters"
          },
          {
            "description": "Penalty for 5'- and 3'-end clipping.",
            "inputBinding": {
              "itemSeparator": ",",
              "sbg:cmdInclude": true,
              "prefix": "-L",
              "separate": false
            },
            "label": "Clipping penalty",
            "sbg:toolDefaultValue": "[5,5]",
            "id": "#clipping_penalty",
            "type": [
              "null",
              {
                "items": "int",
                "type": "array"
              }
            ],
            "sbg:category": "BWA Scoring options"
          },
          {
            "description": "Band width for banded alignment.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-w",
              "separate": true
            },
            "label": "Band width",
            "sbg:toolDefaultValue": "100",
            "id": "#band_width",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Algorithm options"
          },
          {
            "description": "Append FASTA/FASTQ comment to SAM output.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-C",
              "separate": true
            },
            "label": "Append comment",
            "id": "#append_comment",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options"
          }
        ],
        "stdout": "",
        "sbg:cmdPreview": "tar -xf reference.b37.fasta.gz.tar ;  bwa mem  -R '@RG\\tID:1' -t 8  reference.b37.fasta.gz  /path/to/LP6005524-DNA_C01_lane_7.sorted.converted.filtered.pe_1.gz /path/to/LP6005524-DNA_C01_lane_7.sorted.converted.filtered.pe_2.gz | /sambamba_v0.6.6 view -t 8 --filter 'not secondary_alignment' -f bam -l 0 -S /dev/stdin | /sambamba_v0.6.6 sort -t 8 -m 32GiB --tmpdir ./ -o LP6005524-DNA_C01_lane_7.sorted.converted.filtered.bam -l 5 /dev/stdin",
        "hints": [
          {
            "dockerImageId": "",
            "dockerPull": "cgrlab/typeseqer:latest",
            "class": "DockerRequirement"
          },
          {
            "value": 16000,
            "class": "sbg:MemRequirement"
          },
          {
            "value": 8,
            "class": "sbg:CPURequirement"
          }
        ],
        "x": -40.944682963278815,
        "id": "dave/cgrhpv/bwa-mem-bundle-0-7-13/49",
        "class": "CommandLineTool",
        "temporaryFailCodes": [],
        "sbg:sbgMaintained": false,
        "successCodes": [],
        "sbg:revision": 49,
        "sbg:publisher": "sbg",
        "sbg:license": "BWA: GNU Affero General Public License v3.0, MIT License. Sambamba: GNU GENERAL PUBLIC LICENSE. Samblaster: The MIT License (MIT)",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:toolkitVersion": "0.7.13",
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "arguments": [
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{  ///  SAMBAMBA VIEW   //////////////////////\n   ///////////////////////////////////////////\nfunction common_substring(a,b) {\n  var i = 0;\n  \n  while(a[i] === b[i] && i < a.length)\n  {\n    i = i + 1;\n  }\n\n  return a.slice(0, i);\n}\n  \n   // Set output file name\n  if($job.inputs.input_reads[0] instanceof Array){\n    input_1 = $job.inputs.input_reads[0][0] // scatter mode\n    input_2 = $job.inputs.input_reads[0][1]\n  } else if($job.inputs.input_reads instanceof Array){\n    input_1 = $job.inputs.input_reads[0]\n    input_2 = $job.inputs.input_reads[1]\n  }else {\n    input_1 = [].concat($job.inputs.input_reads)[0]\n    input_2 = input_1\n  }\n  full_name = input_1.path.split('/')[input_1.path.split('/').length-1] \n\n  if($job.inputs.output_name){name = $job.inputs.output_name }\n  else if ($job.inputs.input_reads.length == 1){ \n    name = full_name\n\n    if(name.slice(-3, name.length) === '.gz' || name.slice(-3, name.length) === '.GZ')\n      name = name.slice(0, -3)   \n    if(name.slice(-3, name.length) === '.fq' || name.slice(-3, name.length) === '.FQ')\n      name = name.slice(0, -3)\n    if(name.slice(-6, name.length) === '.fastq' || name.slice(-6, name.length) === '.FASTQ')\n      name = name.slice(0, -6)\n       \n  }else{\n    full_name2 = input_2.path.split('/')[input_2.path.split('/').length-1] \n    name = common_substring(full_name, full_name2)\n    \n    if(name.slice(-1, name.length) === '_' || name.slice(-1, name.length) === '.')\n      name = name.slice(0, -1)\n    if(name.slice(-2, name.length) === 'p_' || name.slice(-1, name.length) === 'p.')\n      name = name.slice(0, -2)\n    if(name.slice(-2, name.length) === 'P_' || name.slice(-1, name.length) === 'P.')\n      name = name.slice(0, -2)\n    if(name.slice(-3, name.length) === '_p_' || name.slice(-3, name.length) === '.p.')\n      name = name.slice(0, -3)\n    if(name.slice(-3, name.length) === '_pe' || name.slice(-3, name.length) === '.pe')\n      name = name.slice(0, -3)\n  }\n  \n  // Read number of threads if defined\n  if ($job.inputs.sambamba_threads){\n    threads = $job.inputs.sambamba_threads\n  }\n  else if ($job.inputs.threads){\n    threads = $job.inputs.threads\n  }\n  else { threads = 8 }\n  \n  if ($job.inputs.filter_out_secondary_alignments){\n    filt_sec = ' --filter \\'not secondary_alignment\\' '\n  }\n  else {filt_sec=' '}\n   \n  // Set output command\n  sambamba_path = '/sambamba_v0.6.6'\n  if ($job.inputs.output_format == 'BAM') {\n    return \"| \" + sambamba_path + \" view -t \"+ threads + filt_sec + \"-f bam -S /dev/stdin -o \"+ name + \".bam\"\n  }\n  else if ($job.inputs.output_format == 'SAM'){ // SAM\n    return \"> \" + name + \".sam\"\n  }\n  else { // SortedBAM is considered default\n    return \"| \" + sambamba_path + \" view -t \"+ threads + filt_sec + \"-f bam -l 0 -S /dev/stdin\"\n  }\n\n}",
              "class": "Expression"
            },
            "prefix": "",
            "separate": false,
            "position": 111
          },
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{ ///  SAMBAMBA SORT   //////////////////////\n///////////////////////////////////////////\n  \nfunction common_substring(a,b) {\n  var i = 0;\n  while(a[i] === b[i] && i < a.length)\n  {\n    i = i + 1;\n  }\n\n  return a.slice(0, i);\n}\n\n   // Set output file name\n  if($job.inputs.input_reads[0] instanceof Array){\n    input_1 = $job.inputs.input_reads[0][0] // scatter mode\n    input_2 = $job.inputs.input_reads[0][1]\n  } else if($job.inputs.input_reads instanceof Array){\n    input_1 = $job.inputs.input_reads[0]\n    input_2 = $job.inputs.input_reads[1]\n  }else {\n    input_1 = [].concat($job.inputs.input_reads)[0]\n    input_2 = input_1\n  }\n  full_name = input_1.path.split('/')[input_1.path.split('/').length-1] \n  \n  if($job.inputs.output_name){name = $job.inputs.output_name }\n  else if ($job.inputs.input_reads.length == 1){\n    name = full_name\n    if(name.slice(-3, name.length) === '.gz' || name.slice(-3, name.length) === '.GZ')\n      name = name.slice(0, -3)   \n    if(name.slice(-3, name.length) === '.fq' || name.slice(-3, name.length) === '.FQ')\n      name = name.slice(0, -3)\n    if(name.slice(-6, name.length) === '.fastq' || name.slice(-6, name.length) === '.FASTQ')\n      name = name.slice(0, -6)\n       \n  }else{\n    full_name2 = input_2.path.split('/')[input_2.path.split('/').length-1] \n    name = common_substring(full_name, full_name2)\n    \n    if(name.slice(-1, name.length) === '_' || name.slice(-1, name.length) === '.')\n      name = name.slice(0, -1)\n    if(name.slice(-2, name.length) === 'p_' || name.slice(-1, name.length) === 'p.')\n      name = name.slice(0, -2)\n    if(name.slice(-2, name.length) === 'P_' || name.slice(-1, name.length) === 'P.')\n      name = name.slice(0, -2)\n    if(name.slice(-3, name.length) === '_p_' || name.slice(-3, name.length) === '.p.')\n      name = name.slice(0, -3)\n    if(name.slice(-3, name.length) === '_pe' || name.slice(-3, name.length) === '.pe')\n      name = name.slice(0, -3)\n  }\n\n  //////////////////////////\n  // Set sort memory size\n  \n  reads_size = 0 // Not used because of situations when size does not exist!\n  GB_1 = 1024*1024*1024\n  if(reads_size < GB_1){ \n    suggested_memory = 4\n    suggested_cpus = 1\n  }\n  else if(reads_size < 10 * GB_1){ \n    suggested_memory = 15\n    suggested_cpus = 8\n  }\n  else { \n    suggested_memory = 58 \n    suggested_cpus = 31\n  }\n  \n  \n  if(!$job.inputs.total_memory){ total_memory = suggested_memory }\n  else{ total_memory = $job.inputs.total_memory }\n\n  // TODO:Rough estimation, should be fine-tuned!\n  if(total_memory > 16){ sorter_memory = parseInt(total_memory / 3) }\n  else{ sorter_memory = 5 }\n          \n  if ($job.inputs.sort_memory){\n    sorter_memory_string = $job.inputs.sort_memory +'GiB'\n  }\n  else sorter_memory_string = sorter_memory + 'GiB' \n  \n  // Read number of threads if defined  \n  if ($job.inputs.sambamba_threads){\n    threads = $job.inputs.sambamba_threads\n  }\n  else if ($job.inputs.threads){\n    threads = $job.inputs.threads\n  }\n  else threads = suggested_cpus\n  \n  sambamba_path = '/sambamba_v0.6.6'\n  \n  // SortedBAM is considered default\n  if (!(($job.inputs.output_format == 'BAM') || ($job.inputs.output_format == 'SAM'))){\n    cmd = \"| \" + sambamba_path + \" sort -t \" + threads\n    return cmd + \" -m \"+sorter_memory_string+\" --tmpdir ./ -o \"+ name +\".bam -l 5 /dev/stdin\"\n  }\n  else return \"\"\n}\n  \n",
              "class": "Expression"
            },
            "separate": false,
            "position": 112
          },
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{\n  \n  if($job.inputs.read_group_header){\n  \treturn '-R ' + $job.inputs.read_group_header\n  }\n    \n  function add_param(key, val){\n    if(!val){\n      return\n\t}\n    param_list.push(key + ':' + val)\n  }\n\n  param_list = []\n\n  // Set output file name\n  if($job.inputs.input_reads[0] instanceof Array){\n    input_1 = $job.inputs.input_reads[0][0] // scatter mode\n  } else if($job.inputs.input_reads instanceof Array){\n    input_1 = $job.inputs.input_reads[0]\n  }else {\n    input_1 = [].concat($job.inputs.input_reads)[0]\n  }\n  \n  //Read metadata for input reads\n  read_metadata = input_1.metadata\n  if(!read_metadata) read_metadata = []\n\n  add_param('ID', '1')\n  \n  if($job.inputs.rg_data_submitting_center){\n  \tadd_param('CN', $job.inputs.rg_data_submitting_center)\n  }\n  else if('data_submitting_center' in  read_metadata){\n  \tadd_param('CN', read_metadata.data_submitting_center)\n  }\n  \n  if($job.inputs.rg_library_id){\n  \tadd_param('LB', $job.inputs.rg_library_id)\n  }\n  else if('library_id' in read_metadata){\n  \tadd_param('LB', read_metadata.library_id)\n  }\n  \n  if($job.inputs.rg_median_fragment_length){\n  \tadd_param('PI', $job.inputs.rg_median_fragment_length)\n  }\n\n  \n  if($job.inputs.rg_platform){\n  \tadd_param('PL', $job.inputs.rg_platform)\n  }\n  else if('platform' in read_metadata){\n    if(read_metadata.platform == 'HiSeq X Ten'){\n      rg_platform = 'Illumina'\n    }\n    else{\n      rg_platform = read_metadata.platform\n    }\n  \tadd_param('PL', rg_platform)\n  }\n  \n  if($job.inputs.rg_platform_unit_id){\n  \tadd_param('PU', $job.inputs.rg_platform_unit_id)\n  }\n  else if('platform_unit_id' in read_metadata){\n  \tadd_param('PU', read_metadata.platform_unit_id)\n  }\n  \n  if($job.inputs.rg_sample_id){\n  \tadd_param('SM', $job.inputs.rg_sample_id)\n  }\n  else if('sample_id' in  read_metadata){\n  \tadd_param('SM', read_metadata.sample_id)\n  }\n    \n  return \"-R '@RG\\\\t\" + param_list.join('\\\\t') + \"'\"\n  \n}",
              "class": "Expression"
            },
            "separate": true,
            "position": 1
          },
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{\n  /////// Set input reads in the correct order depending of the paired end from metadata\n    \n     // Set output file name\n  if($job.inputs.input_reads[0] instanceof Array){\n    input_reads = $job.inputs.input_reads[0] // scatter mode\n  } else {\n    input_reads = $job.inputs.input_reads = [].concat($job.inputs.input_reads)\n  }\n  \n  \n  //Read metadata for input reads\n  read_metadata = input_reads[0].metadata\n  if(!read_metadata) read_metadata = []\n  \n  order = 0 // Consider this as normal order given at input: pe1 pe2\n  \n  // Check if paired end 1 corresponds to the first given read\n  if(read_metadata == []){ order = 0 }\n  else if('paired_end' in  read_metadata){ \n    pe1 = read_metadata.paired_end\n    if(pe1 != 1) order = 1 // change order\n  }\n\n  // Return reads in the correct order\n  if (input_reads.length == 1){\n    return input_reads[0].path // Only one read present\n  }\n  else if (input_reads.length == 2){\n    if (order == 0) return input_reads[0].path + ' ' + input_reads[1].path\n    else return input_reads[1].path + ' ' + input_reads[0].path\n  }\n\n}",
              "class": "Expression"
            },
            "separate": true,
            "position": 101
          },
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{\n  \n  reads_size = 0 \n\n  GB_1 = 1024*1024*1024\n  if(reads_size < GB_1){ suggested_threads = 1 }\n  else if(reads_size < 10 * GB_1){ suggested_threads = 8 }\n  else { suggested_threads = 31 }\n  \n  \n  if(!$job.inputs.threads){  \treturn suggested_threads  }  \n  else{    return $job.inputs.threads  }\n}",
              "class": "Expression"
            },
            "prefix": "-t",
            "separate": true,
            "position": 2
          },
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{\n  reference_file = $job.inputs.reference_index_tar.path.split('/')[$job.inputs.reference_index_tar.path.split('/').length-1]\n  name = reference_file.slice(0, -4) // cut .tar extension \n  \n  return name\n  \n}",
              "class": "Expression"
            },
            "separate": true,
            "position": 10
          }
        ],
        "sbg:toolAuthor": "Heng Li",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:revision": 0,
            "sbg:revisionNotes": "Copy of admin/sbg-public-data/bwa-mem-bundle-0-7-13/58",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481059586
          },
          {
            "sbg:revision": 1,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481068904
          },
          {
            "sbg:revision": 2,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481115815
          },
          {
            "sbg:revision": 3,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481116098
          },
          {
            "sbg:revision": 4,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481116150
          },
          {
            "sbg:revision": 5,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481116184
          },
          {
            "sbg:revision": 6,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481116736
          },
          {
            "sbg:revision": 7,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481116889
          },
          {
            "sbg:revision": 8,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481117045
          },
          {
            "sbg:revision": 9,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481117410
          },
          {
            "sbg:revision": 10,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481117480
          },
          {
            "sbg:revision": 11,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481117704
          },
          {
            "sbg:revision": 12,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481117793
          },
          {
            "sbg:revision": 13,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481117834
          },
          {
            "sbg:revision": 14,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481117908
          },
          {
            "sbg:revision": 15,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481118226
          },
          {
            "sbg:revision": 16,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481119589
          },
          {
            "sbg:revision": 17,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481134488
          },
          {
            "sbg:revision": 18,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481136278
          },
          {
            "sbg:revision": 19,
            "sbg:revisionNotes": "fixed index",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1481136522
          },
          {
            "sbg:revision": 20,
            "sbg:revisionNotes": "added index output so the index will have metadata",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486399352
          },
          {
            "sbg:revision": 21,
            "sbg:revisionNotes": "removed -z",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510169598
          },
          {
            "sbg:revision": 22,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510169613
          },
          {
            "sbg:revision": 23,
            "sbg:revisionNotes": "correcting fasta index command",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510172078
          },
          {
            "sbg:revision": 24,
            "sbg:revisionNotes": "removed some extra commands",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510173055
          },
          {
            "sbg:revision": 25,
            "sbg:revisionNotes": "putting commands back in",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510173207
          },
          {
            "sbg:revision": 26,
            "sbg:revisionNotes": "remove pipe thing",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520373672
          },
          {
            "sbg:revision": 27,
            "sbg:revisionNotes": "removed pipe commands at end",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520373846
          },
          {
            "sbg:revision": 28,
            "sbg:revisionNotes": "test tar command",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520390878
          },
          {
            "sbg:revision": 29,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520391724
          },
          {
            "sbg:revision": 30,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520394654
          },
          {
            "sbg:revision": 31,
            "sbg:revisionNotes": "back to version 0",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520396075
          },
          {
            "sbg:revision": 32,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520396726
          },
          {
            "sbg:revision": 33,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520396832
          },
          {
            "sbg:revision": 34,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520432818
          },
          {
            "sbg:revision": 35,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520448507
          },
          {
            "sbg:revision": 36,
            "sbg:revisionNotes": "added and ending quote",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520449475
          },
          {
            "sbg:revision": 37,
            "sbg:revisionNotes": "on tar an bwa",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520450271
          },
          {
            "sbg:revision": 38,
            "sbg:revisionNotes": "moved args around",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520450849
          },
          {
            "sbg:revision": 39,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520451230
          },
          {
            "sbg:revision": 40,
            "sbg:revisionNotes": "aligned.bam",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520454117
          },
          {
            "sbg:revision": 41,
            "sbg:revisionNotes": "put many commands back in",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520457400
          },
          {
            "sbg:revision": 42,
            "sbg:revisionNotes": "back to version 0",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520458438
          },
          {
            "sbg:revision": 43,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520458702
          },
          {
            "sbg:revision": 44,
            "sbg:revisionNotes": "back to version 0",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520513938
          },
          {
            "sbg:revision": 45,
            "sbg:revisionNotes": "changed docker and some cmd lines to typeseqer",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520715570
          },
          {
            "sbg:revision": 46,
            "sbg:revisionNotes": "corrected sambamba command line",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520715973
          },
          {
            "sbg:revision": 47,
            "sbg:revisionNotes": "fixing sambamba command line",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520716775
          },
          {
            "sbg:revision": 48,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520740992
          },
          {
            "sbg:revision": 49,
            "sbg:revisionNotes": "removed samblaster",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520741385
          }
        ],
        "sbg:latestRevision": 49,
        "sbg:createdOn": 1481059586,
        "y": 303.4675358868678,
        "requirements": [
          {
            "requirements": [
              {
                "dockerPull": "rabix/js-engine",
                "class": "DockerRequirement"
              }
            ],
            "id": "#cwl-js-engine",
            "class": "ExpressionEngineRequirement"
          }
        ],
        "sbg:projectName": "cgrHPV",
        "baseCommand": [
          {
            "engine": "#cwl-js-engine",
            "script": "{\n  reference_file = $job.inputs.reference_index_tar.path.split('/')[$job.inputs.reference_index_tar.path.split('/').length-1]\n  return 'tar -xf ' + reference_file + ' ; '\n  \n}",
            "class": "Expression"
          },
          "bwa",
          "mem"
        ],
        "sbg:project": "dave/cgrhpv",
        "stdin": "",
        "sbg:modifiedBy": "dave",
        "label": "BWA MEM Bundle",
        "sbg:validationErrors": [],
        "sbg:toolkit": "BWA",
        "sbg:image_url": null,
        "sbg:links": [
          {
            "id": "http://bio-bwa.sourceforge.net/",
            "label": "Homepage"
          },
          {
            "id": "https://github.com/lh3/bwa",
            "label": "Source code"
          },
          {
            "id": "http://bio-bwa.sourceforge.net/bwa.shtml",
            "label": "Wiki"
          },
          {
            "id": "http://sourceforge.net/projects/bio-bwa/",
            "label": "Download"
          },
          {
            "id": "http://arxiv.org/abs/1303.3997",
            "label": "Publication"
          },
          {
            "id": "http://www.ncbi.nlm.nih.gov/pubmed/19451168",
            "label": "Publication BWA Algorithm"
          }
        ],
        "sbg:modifiedOn": 1520741385,
        "cwlVersion": "sbg:draft-2",
        "sbg:revisionNotes": "removed samblaster",
        "sbg:createdBy": "dave",
        "sbg:id": "dave/cgrhpv/bwa-mem-bundle-0-7-13/49"
      },
      "outputs": [
        {
          "id": "#BWA_MEM_Bundle.aligned_reads"
        }
      ],
      "inputs": [
        {
          "id": "#BWA_MEM_Bundle.verbose_level",
          "default": "2"
        },
        {
          "id": "#BWA_MEM_Bundle.use_soft_clipping",
          "default": true
        },
        {
          "id": "#BWA_MEM_Bundle.unpaired_read_penalty"
        },
        {
          "id": "#BWA_MEM_Bundle.total_memory",
          "default": 32
        },
        {
          "id": "#BWA_MEM_Bundle.threads",
          "default": 8
        },
        {
          "id": "#BWA_MEM_Bundle.speficy_distribution_parameters"
        },
        {
          "id": "#BWA_MEM_Bundle.sort_memory",
          "default": 5
        },
        {
          "id": "#BWA_MEM_Bundle.smart_pairing_in_input_fastq",
          "default": false
        },
        {
          "id": "#BWA_MEM_Bundle.skip_seeds"
        },
        {
          "id": "#BWA_MEM_Bundle.skip_pairing"
        },
        {
          "id": "#BWA_MEM_Bundle.skip_mate_rescue"
        },
        {
          "id": "#BWA_MEM_Bundle.select_seeds"
        },
        {
          "id": "#BWA_MEM_Bundle.seed_occurrence_for_the_3rd_round"
        },
        {
          "id": "#BWA_MEM_Bundle.score_for_a_sequence_match",
          "default": 1
        },
        {
          "id": "#BWA_MEM_Bundle.sambamba_threads",
          "default": 8
        },
        {
          "id": "#BWA_MEM_Bundle.rg_sample_id"
        },
        {
          "id": "#BWA_MEM_Bundle.rg_platform_unit_id"
        },
        {
          "id": "#BWA_MEM_Bundle.rg_platform"
        },
        {
          "id": "#BWA_MEM_Bundle.rg_median_fragment_length"
        },
        {
          "id": "#BWA_MEM_Bundle.rg_library_id"
        },
        {
          "id": "#BWA_MEM_Bundle.rg_data_submitting_center"
        },
        {
          "id": "#BWA_MEM_Bundle.reserved_threads"
        },
        {
          "id": "#BWA_MEM_Bundle.reference_index_tar",
          "source": [
            "#BWA_INDEX.indexed_reference"
          ]
        },
        {
          "id": "#BWA_MEM_Bundle.read_type"
        },
        {
          "id": "#BWA_MEM_Bundle.read_group_header"
        },
        {
          "id": "#BWA_MEM_Bundle.output_name"
        },
        {
          "id": "#BWA_MEM_Bundle.output_in_xa"
        },
        {
          "id": "#BWA_MEM_Bundle.output_header",
          "default": false
        },
        {
          "id": "#BWA_MEM_Bundle.output_format",
          "default": "SortedBAM"
        },
        {
          "id": "#BWA_MEM_Bundle.output_alignments",
          "default": true
        },
        {
          "id": "#BWA_MEM_Bundle.mismatch_penalty",
          "default": 3
        },
        {
          "id": "#BWA_MEM_Bundle.minimum_seed_length"
        },
        {
          "id": "#BWA_MEM_Bundle.minimum_output_score",
          "default": -4
        },
        {
          "id": "#BWA_MEM_Bundle.mate_rescue_rounds"
        },
        {
          "id": "#BWA_MEM_Bundle.mark_shorter"
        },
        {
          "id": "#BWA_MEM_Bundle.insert_string_to_header"
        },
        {
          "id": "#BWA_MEM_Bundle.input_reads",
          "source": [
            "#input_reads"
          ]
        },
        {
          "id": "#BWA_MEM_Bundle.ignore_alt_file"
        },
        {
          "id": "#BWA_MEM_Bundle.gap_open_penalties",
          "default": [
            5
          ]
        },
        {
          "id": "#BWA_MEM_Bundle.gap_extension_penalties",
          "default": [
            2
          ]
        },
        {
          "id": "#BWA_MEM_Bundle.filter_out_secondary_alignments",
          "default": true
        },
        {
          "id": "#BWA_MEM_Bundle.dropoff"
        },
        {
          "id": "#BWA_MEM_Bundle.drop_chains_fraction"
        },
        {
          "id": "#BWA_MEM_Bundle.discard_exact_matches"
        },
        {
          "id": "#BWA_MEM_Bundle.discard_chain_length"
        },
        {
          "id": "#BWA_MEM_Bundle.deduplication",
          "default": "None"
        },
        {
          "id": "#BWA_MEM_Bundle.clipping_penalty"
        },
        {
          "id": "#BWA_MEM_Bundle.band_width",
          "default": 50
        },
        {
          "id": "#BWA_MEM_Bundle.append_comment"
        }
      ],
      "sbg:x": -40.944682963278815,
      "id": "#BWA_MEM_Bundle",
      "sbg:y": 303.4675358868678
    },
    {
      "run": {
        "outputs": [
          {
            "description": "Bam file.",
            "label": "BAM file",
            "sbg:fileTypes": "BAM, SAM, JSON, MSGPACK",
            "outputBinding": {
              "sbg:metadata": {},
              "sbg:inheritMetadataFrom": "#input",
              "glob": {
                "engine": "#cwl-js-engine",
                "script": "{\n  fnameRegex = /^(.*?)(?:\\.([^.]+))?$/;\n  file_path = $job.inputs.input.path;\n  base_name = fnameRegex.exec(file_path)[1];\n  file_name = base_name.replace(/^.*[\\\\\\/]/, '');\n  \n  if ($job.inputs.output == 'sam'){\n  \treturn file_name + '.filtered.sam'\n  }\n  else if ($job.inputs.output == 'bam'){\n  \treturn file_name.concat('.filtered.bam')\n  }\n  else if ($job.inputs.output == 'json'){\n  \treturn file_name.concat('.filtered.json')\n  }\n  else if ($job.inputs.output == 'msgpack'){\n  \treturn file_name.concat('.filtered.msgpack')\n  }\n  else\t{\n  \treturn file_name + '.filtered.sam'\n  }\n}",
                "class": "Expression"
              }
            },
            "id": "#filtered",
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "description": "Sambamba View efficiently filters a BAM file for alignments satisfying various conditions. It also accesses its SAM header and information about reference sequences. A JSON output is provided to make this data readily available for use with Perl, Python, and Ruby scripts.\n\nBy default, the tool expects a BAM file as an input. In order to work with a SAM file as an input, specify --sam-input command-line option. The tool does NOT automatically detect file format from its extension. Beware that when reading SAM, the tool will skip tags which don't conform to the SAM/BAM specification and set invalid fields to their default values. However, only syntax is checked, use --valid for full validation.",
        "sbg:categories": [
          "SAM/BAM-Processing"
        ],
        "sbg:job": {
          "allocatedResources": {
            "mem": 7,
            "cpu": 8
          },
          "inputs": {
            "mem_mb": 7,
            "nthreads": null,
            "reserved_threads": 8,
            "input": {
              "path": "/root/dir/example.bam",
              "secondaryFiles": [
                {
                  "path": ".bai"
                }
              ]
            },
            "filter": "unmapped",
            "subsample": 9.236016917973757,
            "output": "bam"
          }
        },
        "inputs": [
          {
            "description": "Print header before reads (always done for BAM output).",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--with-header",
              "separate": true
            },
            "label": "With header",
            "id": "#with_header",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "Execution",
            "sbg:altPrefix": "h"
          },
          {
            "id": "#valid",
            "description": "Output only valid reads.",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "Execution",
            "label": "Valid"
          },
          {
            "description": "Set seed for subsampling.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--subsampling-seed",
              "separate": true
            },
            "label": "Subsampling seed",
            "id": "#subsampling_seed",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution"
          },
          {
            "sbg:stageInput": null,
            "description": "Subsample reads (read pairs).",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--subsample=",
              "separate": true
            },
            "label": "Subsample",
            "id": "#subsample",
            "type": [
              "null",
              "float"
            ],
            "sbg:category": "Execution",
            "sbg:altPrefix": "s"
          },
          {
            "description": "Specify that input is in SAM format.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--sam-input",
              "separate": true
            },
            "label": "SAM input",
            "id": "#sam_input",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "Execution",
            "sbg:altPrefix": "S"
          },
          {
            "sbg:stageInput": null,
            "description": "Number of threads reserved on the instance passed to the scheduler (number of jobs).",
            "label": "Number of threads reserved on the instance",
            "sbg:toolDefaultValue": "1",
            "id": "#reserved_threads",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution"
          },
          {
            "description": "Output only reads overlapping one of regions from the BED file.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--regions=",
              "separate": false
            },
            "label": "Regions",
            "sbg:fileTypes": "BED",
            "id": "#regions",
            "type": [
              "null",
              "File"
            ],
            "sbg:category": "File input.",
            "sbg:altPrefix": "L",
            "required": false
          },
          {
            "description": "Specify reference for writing CRAM.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--ref-filename=",
              "separate": false
            },
            "label": "Reference",
            "sbg:fileTypes": "FASTA,FA",
            "id": "#ref_filename",
            "type": [
              "null",
              "File"
            ],
            "sbg:category": "Execution",
            "sbg:altPrefix": "T",
            "required": false
          },
          {
            "description": "Specify which format to use for output (default is SAM).",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--format=",
              "separate": false,
              "position": 1
            },
            "label": "Output format",
            "id": "#output",
            "type": [
              {
                "name": "output",
                "type": "enum",
                "symbols": [
                  "sam",
                  "bam",
                  "cram",
                  "json"
                ]
              }
            ],
            "sbg:category": "Execution",
            "sbg:altPrefix": "-f"
          },
          {
            "description": "Number of threads to use.",
            "inputBinding": {
              "valueFrom": {
                "engine": "#cwl-js-engine",
                "script": "{\n  if ($job.inputs.nthreads)\n    return $job.inputs.nthreads\n  else\n    return 8\n}",
                "class": "Expression"
              },
              "sbg:cmdInclude": true,
              "prefix": "--nthreads=",
              "separate": false
            },
            "label": "Number of threads",
            "sbg:toolDefaultValue": "8",
            "id": "#nthreads",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution",
            "sbg:altPrefix": "-t"
          },
          {
            "sbg:stageInput": null,
            "description": "Memory in MB.",
            "label": "Memory in MB",
            "sbg:toolDefaultValue": "1024",
            "id": "#mem_mb",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution"
          },
          {
            "description": "BAM or SAM file.",
            "inputBinding": {
              "itemSeparator": " ",
              "sbg:cmdInclude": true,
              "secondaryFiles": [
                ".bai"
              ],
              "separate": true,
              "position": 2
            },
            "label": "Input",
            "sbg:fileTypes": "BAM, SAM",
            "id": "#input",
            "type": [
              "File"
            ],
            "sbg:category": "Inputs",
            "required": true
          },
          {
            "description": "Set custom filter for alignments.",
            "inputBinding": {
              "itemSeparator": " ",
              "valueFrom": {
                "engine": "#cwl-js-engine",
                "script": "{\n  if ($job.inputs.filter)\n  {\n  \treturn '\"'.concat($job.inputs.filter, '\"')\n  }\n}",
                "class": "Expression"
              },
              "sbg:cmdInclude": true,
              "prefix": "--filter",
              "separate": true,
              "position": 0
            },
            "label": "Filter",
            "id": "#filter",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "Basic Options",
            "sbg:altPrefix": "-F"
          },
          {
            "description": "Specify that input is in CRAM format.",
            "inputBinding": {
              "itemSeparator": null,
              "sbg:cmdInclude": true,
              "prefix": "--cram-input",
              "separate": true
            },
            "label": "CRAM input",
            "id": "#cram_input",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "Execution"
          },
          {
            "description": "Output to stdout only count of matching records, hHI are ignored.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--count",
              "separate": true
            },
            "label": "Count",
            "id": "#count",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "Execution",
            "sbg:altPrefix": "c"
          },
          {
            "description": "Specify compression level (from 0 to 9, works only for BAM output).",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--compression-level",
              "separate": true
            },
            "label": "Compression level",
            "id": "#compression_level",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution",
            "sbg:altPrefix": "l"
          }
        ],
        "stdout": "",
        "sbg:cmdPreview": "/sambamba_v0.6.6 view --format=bam  /root/dir/example.bam -o example.filtered.bam",
        "hints": [
          {
            "dockerImageId": "59e577b13d5d",
            "dockerPull": "cgrlab/typeseqer:latest",
            "class": "DockerRequirement"
          },
          {
            "value": {
              "engine": "#cwl-js-engine",
              "script": "{\n  if ($job.inputs.reserved_threads) {\n    \n    return $job.inputs.reserved_threads\n    \n  } else if ($job.inputs.nthreads) {\n    \n    return $job.inputs.nthreads\n    \n  } else {\n    \n    return 1\n  }\n  \n}",
              "class": "Expression"
            },
            "class": "sbg:CPURequirement"
          },
          {
            "value": {
              "engine": "#cwl-js-engine",
              "script": "{\n  if ($job.inputs.mem_mb) {\n    \n    return $job.inputs.mem_mb\n    \n  } else {\n    \n    return 1024\n    \n  }\n  \n}",
              "class": "Expression"
            },
            "class": "sbg:MemRequirement"
          }
        ],
        "x": 136.92308780286467,
        "id": "dave/cgrhpv/sambamba-view-0-5-9/2",
        "class": "CommandLineTool",
        "temporaryFailCodes": [],
        "sbg:sbgMaintained": false,
        "successCodes": [],
        "sbg:revision": 2,
        "sbg:publisher": "sbg",
        "sbg:license": "GNU General Public License v2.0 only",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:toolkitVersion": "0.5.9",
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "arguments": [
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{\n  fnameRegex = /^(.*?)(?:\\.([^.]+))?$/;\n  if ($job.inputs.input) \n  {\n  \tfile_path = $job.inputs.input.path;\n  \tbase_name = fnameRegex.exec(file_path)[1];\n  \tfile_name = base_name.replace(/^.*[\\\\\\/]/, '');\n  \n  if ($job.inputs.output == 'sam'){\n  \treturn file_name + '.filtered.sam'\n  }\n  else if ($job.inputs.output == 'bam'){\n  \treturn file_name.concat('.filtered.bam')\n  }\n  else if ($job.inputs.output == 'json'){\n  \treturn file_name.concat('.filtered.json')\n  }\n  else if ($job.inputs.output == 'msgpack'){\n  \treturn file_name.concat('.filtered.msgpack')\n  }\n  else\t{\n  \treturn file_name + '.filtered.sam'\n  }\n  }\n}",
              "class": "Expression"
            },
            "prefix": "-o",
            "separate": true,
            "position": 3
          }
        ],
        "sbg:toolAuthor": "Artem Tarasov",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:revision": 0,
            "sbg:revisionNotes": "Copy of dave/cgrwgs/sambamba-view-0-5-9/1",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1485478878
          },
          {
            "sbg:revision": 1,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486834921
          },
          {
            "sbg:revision": 2,
            "sbg:revisionNotes": "corrected command line and switch to typeseqer docker",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520743858
          }
        ],
        "sbg:latestRevision": 2,
        "sbg:createdOn": 1485478878,
        "y": 199.2427914050468,
        "requirements": [
          {
            "requirements": [
              {
                "dockerPull": "rabix/js-engine",
                "class": "DockerRequirement"
              }
            ],
            "id": "#cwl-js-engine",
            "class": "ExpressionEngineRequirement"
          }
        ],
        "sbg:projectName": "cgrHPV",
        "baseCommand": [
          "/sambamba_v0.6.6",
          "view"
        ],
        "sbg:project": "dave/cgrhpv",
        "stdin": "",
        "sbg:modifiedBy": "dave",
        "label": "Sambamba View",
        "sbg:validationErrors": [],
        "sbg:toolkit": "Sambamba",
        "sbg:image_url": null,
        "sbg:links": [
          {
            "id": "http://lomereiter.github.io/sambamba/docs/sambamba-view.html",
            "label": "Homepage"
          },
          {
            "id": "https://github.com/lomereiter/sambamba",
            "label": "Source code"
          },
          {
            "id": "https://github.com/lomereiter/sambamba/wiki",
            "label": "Wiki"
          },
          {
            "id": "https://github.com/lomereiter/sambamba/releases/tag/v0.5.9",
            "label": "Download"
          },
          {
            "id": "http://lomereiter.github.io/sambamba/docs/sambamba-view.html",
            "label": "Publication"
          }
        ],
        "sbg:modifiedOn": 1520743858,
        "cwlVersion": "sbg:draft-2",
        "sbg:revisionNotes": "corrected command line and switch to typeseqer docker",
        "sbg:createdBy": "dave",
        "sbg:id": "dave/cgrhpv/sambamba-view-0-5-9/2"
      },
      "outputs": [
        {
          "id": "#Sambamba_View.filtered"
        }
      ],
      "inputs": [
        {
          "id": "#Sambamba_View.with_header"
        },
        {
          "id": "#Sambamba_View.valid"
        },
        {
          "id": "#Sambamba_View.subsampling_seed"
        },
        {
          "id": "#Sambamba_View.subsample"
        },
        {
          "id": "#Sambamba_View.sam_input"
        },
        {
          "id": "#Sambamba_View.reserved_threads"
        },
        {
          "id": "#Sambamba_View.regions"
        },
        {
          "id": "#Sambamba_View.ref_filename"
        },
        {
          "id": "#Sambamba_View.output",
          "default": "json"
        },
        {
          "id": "#Sambamba_View.nthreads",
          "default": 8
        },
        {
          "id": "#Sambamba_View.mem_mb",
          "default": 8000
        },
        {
          "id": "#Sambamba_View.input",
          "source": [
            "#BWA_MEM_Bundle.aligned_reads"
          ]
        },
        {
          "id": "#Sambamba_View.filter"
        },
        {
          "id": "#Sambamba_View.cram_input"
        },
        {
          "id": "#Sambamba_View.count"
        },
        {
          "id": "#Sambamba_View.compression_level"
        }
      ],
      "sbg:x": 136.92308780286467,
      "id": "#Sambamba_View",
      "sbg:y": 199.2427914050468
    },
    {
      "run": {
        "outputs": [
          {
            "type": [
              "null",
              {
                "items": "File",
                "type": "array"
              }
            ],
            "id": "#split_variants_json",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#variant_json",
              "glob": {
                "engine": "#cwl-js-engine",
                "script": "\"*.split.json\"",
                "class": "Expression"
              }
            }
          }
        ],
        "description": "",
        "sbg:job": {
          "allocatedResources": {
            "mem": 1000,
            "cpu": 1
          },
          "inputs": {
            "json": {
              "path": "/path/to/IonXpress_075_Auto_user_S5XL-0039-25-2017-01-10_RD111_HPV-T_T163_SUCCEED_104.json",
              "size": 0,
              "secondaryFiles": [],
              "class": "File"
            },
            "number_of_lines_per_file": 100
          }
        },
        "stdin": "",
        "stdout": "std.out",
        "sbg:cmdPreview": "split --additional-suffix .split.json -l 100 -de -a 3 /path/to/IonXpress_075_Auto_user_S5XL-0039-25-2017-01-10_RD111_HPV-T_T163_SUCCEED_104.json IonXpress_075_Auto_user_S5XL-0039-25-2017-01-10_RD111_HPV-T_T163_SUCCEED_104_  > std.out",
        "hints": [
          {
            "value": 1,
            "class": "sbg:CPURequirement"
          },
          {
            "value": 1000,
            "class": "sbg:MemRequirement"
          },
          {
            "dockerImageId": "",
            "dockerPull": "cgrlab/typeseqer:latest",
            "class": "DockerRequirement"
          }
        ],
        "x": 326.2395835393183,
        "id": "dave/cgrhpv/json-splitter/8",
        "sbg:modifiedBy": "dave",
        "temporaryFailCodes": [],
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "successCodes": [],
        "sbg:publisher": "sbg",
        "sbg:sbgMaintained": false,
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "arguments": [],
        "sbg:revision": 8,
        "sbg:contributors": [
          "dave"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:revision": 0,
            "sbg:revisionNotes": "Copy of dave/rd161-hpv-integration-working-01/json-splitter/1",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1485478911
          },
          {
            "sbg:revision": 1,
            "sbg:revisionNotes": "not a copy anymore",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486825823
          },
          {
            "sbg:revision": 2,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486828885
          },
          {
            "sbg:revision": 3,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486828902
          },
          {
            "sbg:revision": 4,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486859176
          },
          {
            "sbg:revision": 5,
            "sbg:revisionNotes": "tidygenomics",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486859373
          },
          {
            "sbg:revision": 6,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1486862260
          },
          {
            "sbg:revision": 7,
            "sbg:revisionNotes": "switch to typeseqer docker",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520778127
          },
          {
            "sbg:revision": 8,
            "sbg:revisionNotes": "updated docker again",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520877879
          }
        ],
        "sbg:latestRevision": 8,
        "sbg:createdOn": 1485478911,
        "y": 245.7387124120971,
        "requirements": [
          {
            "requirements": [
              {
                "dockerPull": "rabix/js-engine",
                "class": "DockerRequirement"
              }
            ],
            "id": "#cwl-js-engine",
            "class": "ExpressionEngineRequirement"
          }
        ],
        "class": "CommandLineTool",
        "sbg:projectName": "cgrHPV",
        "baseCommand": [
          "split",
          "--additional-suffix",
          ".split.json",
          "-l",
          {
            "engine": "#cwl-js-engine",
            "script": "$job.inputs.number_of_lines_per_file",
            "class": "Expression"
          },
          "-de",
          "-a",
          "3",
          {
            "engine": "#cwl-js-engine",
            "script": "$job.inputs.json.path",
            "class": "Expression"
          },
          {
            "engine": "#cwl-js-engine",
            "script": "$job.inputs.json.path.split(\"/\").reverse()[0].split(\".\")[0]+\"_\"",
            "class": "Expression"
          }
        ],
        "sbg:project": "dave/cgrhpv",
        "sbg:image_url": null,
        "label": "json_splitter",
        "sbg:validationErrors": [],
        "inputs": [
          {
            "sbg:stageInput": null,
            "id": "#number_of_lines_per_file",
            "type": [
              "null",
              "int"
            ],
            "label": "number of lines per file"
          },
          {
            "id": "#json",
            "type": [
              "null",
              "File"
            ],
            "label": "variant json",
            "required": false
          }
        ],
        "sbg:modifiedOn": 1520877879,
        "cwlVersion": "sbg:draft-2",
        "sbg:revisionNotes": "updated docker again",
        "sbg:createdBy": "dave",
        "sbg:id": "dave/cgrhpv/json-splitter/8"
      },
      "outputs": [
        {
          "id": "#json_splitter.split_variants_json"
        }
      ],
      "inputs": [
        {
          "id": "#json_splitter.number_of_lines_per_file",
          "default": 600000
        },
        {
          "id": "#json_splitter.json",
          "source": [
            "#Sambamba_View.filtered"
          ]
        }
      ],
      "sbg:x": 326.2395835393183,
      "id": "#json_splitter",
      "sbg:y": 245.7387124120971
    },
    {
      "run": {
        "outputs": [
          {
            "description": "Output header.",
            "label": "Output header",
            "sbg:fileTypes": "TXT",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#input_bam_or_sam_file",
              "glob": "*.txt"
            },
            "id": "#output_header_file",
            "type": [
              "File"
            ]
          }
        ],
        "description": "Extract the header from the alignment file in SAM or BAM formats.",
        "sbg:categories": [
          "SAM/BAM-Processing"
        ],
        "sbg:job": {
          "allocatedResources": {
            "mem": 1000,
            "cpu": 1
          },
          "inputs": {
            "input_bam_or_sam_file": {
              "path": "input_bam_or_sam_file.bam",
              "size": 0,
              "secondaryFiles": [],
              "class": "File"
            }
          }
        },
        "inputs": [
          {
            "description": "BAM or SAM input file.",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "separate": true,
              "position": 0
            },
            "label": "BAM or SAM input file",
            "sbg:fileTypes": "BAM, SAM",
            "id": "#input_bam_or_sam_file",
            "type": [
              "File"
            ],
            "sbg:category": "File input",
            "required": true
          }
        ],
        "stdout": "",
        "sbg:cmdPreview": "samtools view  input_bam_or_sam_file.bam  -H -o input_bam_or_sam_file.txt",
        "hints": [
          {
            "value": 1,
            "class": "sbg:CPURequirement"
          },
          {
            "value": 1000,
            "class": "sbg:MemRequirement"
          },
          {
            "dockerImageId": "",
            "dockerPull": "cgrlab/typeseqer:latest",
            "class": "DockerRequirement"
          }
        ],
        "x": 306.15387536788234,
        "id": "dave/cgrhpv/samtools-extract-bam-header-1-3/3",
        "class": "CommandLineTool",
        "temporaryFailCodes": [],
        "sbg:sbgMaintained": false,
        "successCodes": [],
        "sbg:revision": 3,
        "sbg:publisher": "sbg",
        "sbg:license": "BSD License, MIT License",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:toolkitVersion": "v1.3",
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "arguments": [
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{\n filepath = $job.inputs.input_bam_or_sam_file.path\n\n filename = filepath.split(\"/\").pop();\n\n file_dot_sep = filename.split(\".\");\n file_ext = file_dot_sep[file_dot_sep.length-1];\n\n new_filename = filename.substr(0,filename.lastIndexOf(\".\"));\n \n extension = '.txt'\n             \n return new_filename + extension; \n}",
              "class": "Expression"
            },
            "prefix": "-o",
            "separate": true,
            "position": 2
          },
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "script": "{\nreturn '-H'\n}",
              "class": "Expression"
            },
            "prefix": "",
            "separate": true,
            "position": 1
          }
        ],
        "sbg:toolAuthor": "Heng Li/Sanger Institute,  Bob Handsaker/Broad Institute, James Bonfield/Sanger Institute,",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:revision": 0,
            "sbg:revisionNotes": "Copy of admin/sbg-public-data/samtools-extract-bam-header-1-3/9",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1492714234
          },
          {
            "sbg:revision": 1,
            "sbg:revisionNotes": "no changes...just want to save a non-copy version in this project",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1492714376
          },
          {
            "sbg:revision": 2,
            "sbg:revisionNotes": "removed aws instance hint",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1495125186
          },
          {
            "sbg:revision": 3,
            "sbg:revisionNotes": "cgrlab/typeseqer:latest",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520717721
          }
        ],
        "sbg:latestRevision": 3,
        "sbg:createdOn": 1492714234,
        "y": 514.6274697208834,
        "requirements": [
          {
            "requirements": [
              {
                "dockerPull": "rabix/js-engine",
                "class": "DockerRequirement"
              }
            ],
            "id": "#cwl-js-engine",
            "class": "ExpressionEngineRequirement"
          }
        ],
        "sbg:projectName": "cgrHPV",
        "baseCommand": [
          "samtools",
          "view"
        ],
        "sbg:project": "dave/cgrhpv",
        "stdin": "",
        "sbg:modifiedBy": "dave",
        "label": "SAMtools extract SAM/BAM header",
        "sbg:validationErrors": [],
        "sbg:toolkit": "SAMtools",
        "sbg:image_url": null,
        "sbg:links": [
          {
            "id": "http://www.htslib.org",
            "label": "Homepage"
          },
          {
            "id": "https://github.com/samtools/",
            "label": "Source Code"
          },
          {
            "id": "https://sourceforge.net/projects/samtools/files/samtools/",
            "label": "Download"
          },
          {
            "id": "http://www.ncbi.nlm.nih.gov/pubmed/19505943",
            "label": "Publication"
          },
          {
            "id": "http://www.htslib.org/doc/samtools.html",
            "label": "Documentation"
          },
          {
            "id": "http://www.htslib.org",
            "label": "Wiki"
          }
        ],
        "sbg:modifiedOn": 1520717721,
        "cwlVersion": "sbg:draft-2",
        "sbg:revisionNotes": "cgrlab/typeseqer:latest",
        "sbg:createdBy": "dave",
        "sbg:id": "dave/cgrhpv/samtools-extract-bam-header-1-3/3"
      },
      "outputs": [
        {
          "id": "#SAMtools_extract_SAM_BAM_header.output_header_file"
        }
      ],
      "inputs": [
        {
          "id": "#SAMtools_extract_SAM_BAM_header.input_bam_or_sam_file",
          "source": [
            "#BWA_MEM_Bundle.aligned_reads"
          ]
        }
      ],
      "sbg:x": 306.15387536788234,
      "id": "#SAMtools_extract_SAM_BAM_header",
      "sbg:y": 514.6274697208834
    },
    {
      "run": {
        "outputs": [
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#hpv_types",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#bam_json",
              "glob": {
                "engine": "#cwl-js-engine",
                "script": "\"*_hpv_types.json\"",
                "class": "Expression"
              }
            }
          },
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#app_html_out",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#bam_json",
              "glob": "*.html"
            }
          }
        ],
        "sbg:publisher": "sbg",
        "sbg:categories": [
          "hpv_typing"
        ],
        "sbg:job": {
          "allocatedResources": {
            "mem": 1000,
            "cpu": 1
          },
          "inputs": {
            "bam_json": {
              "path": "path/to/_2_Run1v0202_Pool1_S1_L001_001_barcode_Rev_BC107_2_barcode_Fwd_BC03.fastq.sorted.filtered.json",
              "size": 0,
              "secondaryFiles": [
                {
                  "path": ".bai"
                }
              ],
              "class": "File"
            },
            "page_size": 5000,
            "barcode_file": {
              "path": "/path/to/barcode_file.ext",
              "size": 0,
              "secondaryFiles": [],
              "class": "File"
            }
          }
        },
        "stdin": "",
        "stdout": "",
        "sbg:cmdPreview": "Rscript -e 'require(rmarkdown); render(\"illumina_demultiplex_read_processor.R\")'  1>&2",
        "hints": [
          {
            "dockerPull": "cgrlab/typeseqer:0.5.02",
            "class": "DockerRequirement"
          },
          {
            "value": 1,
            "class": "sbg:CPURequirement"
          },
          {
            "value": 1000,
            "class": "sbg:MemRequirement"
          }
        ],
        "x": 473.5901652765211,
        "class": "CommandLineTool",
        "temporaryFailCodes": [],
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "successCodes": [],
        "description": "",
        "sbg:sbgMaintained": false,
        "sbg:contributors": [
          "dave"
        ],
        "arguments": [
          {
            "valueFrom": "1>&2",
            "separate": true,
            "position": 100
          }
        ],
        "sbg:revision": 26,
        "sbg:image_url": null,
        "sbg:revisionsInfo": [
          {
            "sbg:revision": 0,
            "sbg:revisionNotes": "Copy of dave/cgrhpv/split-barcode-2-get-coverage/36",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1492530856
          },
          {
            "sbg:revision": 1,
            "sbg:revisionNotes": "changing from the regular ion app",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1492531013
          },
          {
            "sbg:revision": 2,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1492539836
          },
          {
            "sbg:revision": 3,
            "sbg:revisionNotes": "removing references to A1 barcode",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1492540967
          },
          {
            "sbg:revision": 4,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1492542278
          },
          {
            "sbg:revision": 5,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1495053330
          },
          {
            "sbg:revision": 6,
            "sbg:revisionNotes": "adding demultiplex",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510244908
          },
          {
            "sbg:revision": 7,
            "sbg:revisionNotes": "changed to typeseqer docker",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510244936
          },
          {
            "sbg:revision": 8,
            "sbg:revisionNotes": "added std.err std.out output",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510245033
          },
          {
            "sbg:revision": 9,
            "sbg:revisionNotes": "added demultiplex",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510251011
          },
          {
            "sbg:revision": 10,
            "sbg:revisionNotes": "added barcode file input",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510251553
          },
          {
            "sbg:revision": 11,
            "sbg:revisionNotes": "added html out",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510251661
          },
          {
            "sbg:revision": 12,
            "sbg:revisionNotes": "renamed args.R",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510252681
          },
          {
            "sbg:revision": 13,
            "sbg:revisionNotes": "removed some args from command line",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510252842
          },
          {
            "sbg:revision": 14,
            "sbg:revisionNotes": "better metrics",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510715534
          },
          {
            "sbg:revision": 15,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510721184
          },
          {
            "sbg:revision": 16,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510721221
          },
          {
            "sbg:revision": 17,
            "sbg:revisionNotes": "fixing barcode orientation",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510792420
          },
          {
            "sbg:revision": 18,
            "sbg:revisionNotes": "fixing barcodes",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510792666
          },
          {
            "sbg:revision": 19,
            "sbg:revisionNotes": "added fwd rev back in",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510799338
          },
          {
            "sbg:revision": 20,
            "sbg:revisionNotes": "parameter files in jazz area",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520650394
          },
          {
            "sbg:revision": 21,
            "sbg:revisionNotes": "barcode file is now in the docker",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520650841
          },
          {
            "sbg:revision": 22,
            "sbg:revisionNotes": "put barcode back in",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520876842
          },
          {
            "sbg:revision": 23,
            "sbg:revisionNotes": "illumina_TypeSeqer_minQual_minLen_filters",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1521176814
          },
          {
            "sbg:revision": 24,
            "sbg:revisionNotes": "illumina_TypeSeqer_minQual_minLen_filters.csv",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1521177513
          },
          {
            "sbg:revision": 25,
            "sbg:revisionNotes": "cgrlab/typeseqer:0.5.02",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1524596446
          },
          {
            "sbg:revision": 26,
            "sbg:revisionNotes": "args_parameter_file = \"/opt/2017-Nov_HPV_Typing_MiSeq_MQ_and_MinLen_Filters_4.csv\" \\n\\",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1524599503
          }
        ],
        "sbg:latestRevision": 26,
        "sbg:createdOn": 1492530856,
        "y": 97.1916006055416,
        "requirements": [
          {
            "fileDef": [
              {
                "fileContent": {
                  "engine": "#cwl-js-engine",
                  "script": "\n'# get args \\n\\\nargs_bam_json = data_frame(path = \"'+$job.inputs.bam_json.path+'\", name = \"'+$job.inputs.bam_json.path.split(\"/\").reverse()[0].split(\".fastq.\")[0]+'\") \\n\\\nargs_barcode_file = \"'+$job.inputs.barcode_file.path+'\" \\n\\\nargs_parameter_file = \"/opt/2017-Nov_HPV_Typing_MiSeq_MQ_and_MinLen_Filters_4.csv\" \\n\\\nargs_page_size = ' +$job.inputs.page_size\n",
                  "class": "Expression"
                },
                "filename": "args.R"
              },
              {
                "fileContent": "# Databricks notebook source\n#+ db only - load spark, echo=FALSE, include = FALSE, eval=FALSE\nlibrary(SparkR)\n\n#+ load packages\nlibrary(GenomicAlignments)\nlibrary(tidyverse)\nlibrary(stringr)\nlibrary(jsonlite)\nlibrary(pander)\nlibrary(scales)\nlibrary(knitr)\nlibrary(rmarkdown)\nlibrary(koRpus)\nlibrary(fuzzyjoin)\nsessionInfo()\n\n\n# COMMAND ----------\n\n#+ databricks args, echo=exists(\"is_test\"), include =FALSE, eval=exists(\"is_test\")\n\nargs_bam_json = data_frame(path = \"/databricks/driver/temp.json\", name = \"Run5_Pool5_S1_L001_R_000\") \nargs_barcode_file = \"/dbfs/mnt/rd111/2017-11-09_TypeSeqer_MiSeq_v2_Barcodes_FandR-rev-comp.csv\"\nargs_parameter_file = \"/dbfs/mnt/rd111/2017-Nov_HPV_Typing_MiSeq_MQ_and_MinLen_Filters_4.csv\"\nargs_page_size = 20000\n\nsystem(\"touch args.R\")\n\n#+ get args\nread_lines(\"args.R\") %>% \nwriteLines()\nsource(\"args.R\")\n\n\n# COMMAND ----------\n\n#+ read barcodes csv\nbarcodes = read_csv(args_barcode_file) %>% \nmap_if(is.factor, as.character) %>% \nas_tibble() %>%\nglimpse()\n\n#+ eval=FALSE, include=FALSE\ndisplay(barcodes)\n\n# COMMAND ----------\n\n#+ read parameters csv\nparameters = read_csv(args_parameter_file) %>% \nmap_if(is.factor, as.character) %>% \nas_tibble() %>% \nmutate(min_mq = mq) %>% \nselect(-mq)\n\n# COMMAND ----------\n\n#+ process reads - init output\n\nhpv_types_output = file(paste0(args_bam_json$name,\"_hpv_types.json\"), open = \"wb\")\n\n#+ process reads - db only, eval=FALSE, include=FALSE\n\nhpv_types_output = file(paste0(\"/databricks/driver/\", args_bam_json$name,\"_hpv_types.json\"), open = \"wb\")\n\n#+ process reads - main code, include=FALSE\n\npage = 1\n\nstream_in(file(args_bam_json$path), handler = function(bam_json){\n# Processes a page of data at a time\n\nreads = bind_cols(bam_json[1:11], as_data_frame(bam_json$tags)) %>% \nas_tibble()\n  \n# demultiplex (add barcode column via fuzzy join)\nreads_demultiplex = reads %>%\nselect(qname, rname, seq, mapq, cigar) %>%\nmutate(pre_demultiplex_pairs = n()/2) %>%\nfuzzy_join(barcodes, mode = \"inner\", by=c(\"seq\" = \"bc_sequence\"), match_fun = function(x, y) str_detect(str_sub(x, start=-25), fixed(y, ignore_case=TRUE))) %>%\nmutate(bc_num = ifelse(str_detect(bc_id, \"Rev\"), 1, 2)) %>%\narrange(qname, bc_num) %>%\ndo({print(\"post fuzzy join\"); temp=.}) %>% glimpse() %>%\ngroup_by(qname) %>%\nmutate(pair_read_count = n()) %>%\nmutate(barcode = paste0(bc_id, collapse=\"\")) %>%\nungroup() %>%\nfilter(!str_detect(bc_id, \"Fwd\")) %>%\nmutate(barcode_1 = bc_id) %>%\ndo({print(\"post str detect rev\"); temp=.}) %>% glimpse() %>%\nselect(barcode_1, barcode, qname, rname, seq, mapq, cigar, pair_read_count, pre_demultiplex_pairs) %>%\ndistinct() %>%\n    \ndo({print(\"post demultiplex\"); temp=.}) %>% glimpse() %>%\n\n# now get barcode_1 metrics\nmutate(barcode_pairs = n()) %>%\nfilter(pair_read_count == 2) %>%\nselect(-pair_read_count) %>%\nfilter(str_detect(barcode, \"Fwd\"), str_detect(barcode, \"Rev\")) %>%\nmutate(total_demultiplex_reads = n()) %>%\ngroup_by(barcode_1) %>% \nmutate(post_demultiplex_reads = n()) %>%\nungroup() %>%\ndo({print(\"post barcode 1 metrics\"); temp=.}) %>% glimpse()\n           \n#filter and reduce\nreads_reduced = reads_demultiplex %>%\nselect(barcode_1, barcode, qname, HPV_Type = rname, seq, mapq, cigar, pre_demultiplex_pairs, total_demultiplex_reads, post_demultiplex_reads) %>%\ngroup_by(barcode) %>%\nmutate(page_num = page) %>%\nmutate(file_name = args_bam_json$name) %>%\nleft_join(parameters) %>%\nfilter(mapq >= min_mq) %>%\nmutate(mapq_reads = n()) %>%\nmutate(seq_length = str_length(seq)) %>%\nfilter(mapq != 0) %>%\nmutate(cigar_seq = as.character(sequenceLayer(DNAStringSet(seq), cigar))) %>%\nmutate(cigar_len = str_length(cigar_seq)) %>%\nfilter(cigar_len >= min_align_len) %>%\nmutate(gt_equal_min_reads = n()) %>%\nmutate(qualified_barcode_reads = n()) %>%\ngroup_by(barcode, HPV_Type) %>%\nmutate(HPV_Type_count = n()) %>%\nungroup() %>%\nselect(barcode_1, barcode, file_name, page_num, pre_demultiplex_pairs, total_demultiplex_reads, post_demultiplex_reads, mapq_reads, gt_equal_min_reads, qualified_barcode_reads, HPV_Type, HPV_Type_count) %>%\ndistinct() %>%\ndo({print(\"post everything\"); temp=.}) %>% glimpse()\n           \npage <<- page + 1\n\nstream_out(reads_reduced, hpv_types_output, verbose = FALSE)\n           \n}, pagesize = args_page_size, verbose = FALSE)\n\nclose(hpv_types_output)\n\n# COMMAND ----------\n\n#+ checking on db, eval=FALSE, include=FALSE\ntemp = stream_in(file(\"/databricks/driver/Run5_Pool5_S1_L001_R_000_hpv_types.json\")) %>%\nglimpse()\n\ndisplay(temp)\n\n# COMMAND ----------\n\n# MAGIC %sh\n# MAGIC #sudo rm -r TypeSeqer-private && \n# MAGIC sudo mkdir TypeSeqer-private && cd TypeSeqer-private && sudo git init && sudo git pull https://86e728b5c68508d0de00422e81126de37c118fbd@github.com/davidroberson/TypeSeqer-private.git &&\n# MAGIC cd ../\n# MAGIC Rscript -e 'require(rmarkdown); is_test=\"true\"; render(\"TypeSeqer-private/scripts/illumina_demultiplex_read_processor.R\");'",
                "filename": "illumina_demultiplex_read_processor.R"
              }
            ],
            "class": "CreateFileRequirement"
          },
          {
            "requirements": [
              {
                "dockerPull": "rabix/js-engine",
                "class": "DockerRequirement"
              }
            ],
            "id": "#cwl-js-engine",
            "class": "ExpressionEngineRequirement"
          }
        ],
        "sbg:projectName": "cgrHPV",
        "baseCommand": [
          "Rscript",
          "-e",
          "'require(rmarkdown);",
          "render(\"illumina_demultiplex_read_processor.R\")'"
        ],
        "sbg:id": "dave/cgrhpv/illumina-typing-run-processor/26",
        "sbg:project": "dave/cgrhpv",
        "id": "dave/cgrhpv/illumina-typing-run-processor/26",
        "sbg:modifiedBy": "dave",
        "sbg:validationErrors": [],
        "inputs": [
          {
            "sbg:stageInput": null,
            "id": "#page_size",
            "type": [
              "null",
              "int"
            ]
          },
          {
            "id": "#barcode_file",
            "type": [
              "null",
              "File"
            ],
            "required": false
          },
          {
            "sbg:stageInput": null,
            "description": "bam",
            "label": "bam",
            "type": [
              "null",
              "File"
            ],
            "id": "#bam_json",
            "streamable": false,
            "required": false,
            "default": ""
          }
        ],
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "sbg:modifiedOn": 1524599503,
        "cwlVersion": "sbg:draft-2",
        "sbg:revisionNotes": "args_parameter_file = \"/opt/2017-Nov_HPV_Typing_MiSeq_MQ_and_MinLen_Filters_4.csv\" \\n\\",
        "sbg:createdBy": "dave",
        "label": "illumina typing run processor"
      },
      "scatter": "#illumina_typing_run_processor.bam_json",
      "outputs": [
        {
          "id": "#illumina_typing_run_processor.hpv_types"
        },
        {
          "id": "#illumina_typing_run_processor.app_html_out"
        }
      ],
      "inputs": [
        {
          "id": "#illumina_typing_run_processor.page_size",
          "default": 20000
        },
        {
          "id": "#illumina_typing_run_processor.barcode_file",
          "source": [
            "#barcode_file"
          ]
        },
        {
          "id": "#illumina_typing_run_processor.bam_json",
          "source": [
            "#json_splitter.split_variants_json"
          ]
        }
      ],
      "sbg:x": 473.5901652765211,
      "id": "#illumina_typing_run_processor",
      "sbg:y": 97.1916006055416
    },
    {
      "run": {
        "outputs": [
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#samples_only_matrix",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#hpv_types_json",
              "glob": {
                "engine": "#cwl-js-engine",
                "script": "\"*samples_only_matrix.csv\"",
                "class": "Expression"
              }
            }
          },
          {
            "type": [
              "null",
              {
                "items": "File",
                "type": "array"
              }
            ],
            "id": "#pos_neg_matrix",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#bam_header_file",
              "glob": {
                "engine": "#cwl-js-engine",
                "script": "\"*pn_matrix.csv\"",
                "class": "Expression"
              }
            }
          },
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#pdf_report",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#run_manifest",
              "glob": {
                "engine": "#cwl-js-engine",
                "script": "'*pdf'",
                "class": "Expression"
              }
            }
          },
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#hpv_read_counts_matrix",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#run_manifest",
              "glob": {
                "engine": "#cwl-js-engine",
                "script": "\"*hpv_read_counts_matrix.csv\"",
                "class": "Expression"
              }
            }
          },
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#failed_samples_matrix",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#hpv_types_json",
              "glob": {
                "engine": "#cwl-js-engine",
                "script": "\"*failed_samples_matrix.csv\"",
                "class": "Expression"
              }
            }
          },
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#control_matrix",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#hpv_types_json",
              "glob": {
                "engine": "#cwl-js-engine",
                "script": "'*control_results.csv'",
                "class": "Expression"
              }
            }
          }
        ],
        "description": "",
        "sbg:image_url": null,
        "sbg:job": {
          "allocatedResources": {
            "mem": 2000,
            "cpu": 1
          },
          "inputs": {
            "bam_header_file": {
              "path": "/path/to/header_file.txt",
              "size": 0,
              "secondaryFiles": [],
              "class": "File"
            },
            "run_manifest": {
              "path": "path/to/run_manifest.csv",
              "size": 0,
              "secondaryFiles": [],
              "class": "File"
            },
            "control_defs": {
              "path": "/path/to/control_defs.csv",
              "size": 0,
              "secondaryFiles": [],
              "class": "File"
            },
            "hpv_types_json": {
              "path": "path/to/merged_hpv_types.json",
              "size": 0,
              "secondaryFiles": [],
              "class": "File"
            },
            "is_singularity": false
          }
        },
        "stdin": "",
        "stdout": "",
        "sbg:cmdPreview": "Rscript -e 'require(rmarkdown); render(\"illumina_TypeSeqer_report.R\") '  1>&2",
        "hints": [
          {
            "dockerPull": "cgrlab/typeseqer:0.5.02",
            "class": "DockerRequirement"
          },
          {
            "value": 1,
            "class": "sbg:CPURequirement"
          },
          {
            "value": 2000,
            "class": "sbg:MemRequirement"
          }
        ],
        "sbg:contributors": [
          "dave"
        ],
        "class": "CommandLineTool",
        "temporaryFailCodes": [],
        "sbg:sbgMaintained": false,
        "successCodes": [],
        "sbg:publisher": "sbg",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "arguments": [
          {
            "valueFrom": "1>&2",
            "separate": false,
            "position": 99
          }
        ],
        "sbg:revision": 30,
        "label": "illumina_typeseqer_report",
        "sbg:revisionsInfo": [
          {
            "sbg:revision": 0,
            "sbg:revisionNotes": "Copy of dave/cgrhpv/hpv-typing-report/129",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510342185
          },
          {
            "sbg:revision": 1,
            "sbg:revisionNotes": "changed label to illumina",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510342320
          },
          {
            "sbg:revision": 2,
            "sbg:revisionNotes": "removed some inputs",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510342632
          },
          {
            "sbg:revision": 3,
            "sbg:revisionNotes": "added R script",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510342908
          },
          {
            "sbg:revision": 4,
            "sbg:revisionNotes": "illumina report finishes on db",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510503263
          },
          {
            "sbg:revision": 5,
            "sbg:revisionNotes": "fixed display issue",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510504962
          },
          {
            "sbg:revision": 6,
            "sbg:revisionNotes": "removed thumbnail code",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510505488
          },
          {
            "sbg:revision": 7,
            "sbg:revisionNotes": "added more outputs",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510603784
          },
          {
            "sbg:revision": 8,
            "sbg:revisionNotes": "added contig collapse",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510715360
          },
          {
            "sbg:revision": 9,
            "sbg:revisionNotes": "fixing read metric and b2m issues",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510757699
          },
          {
            "sbg:revision": 10,
            "sbg:revisionNotes": "adjusted filtering criteria",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510769226
          },
          {
            "sbg:revision": 11,
            "sbg:revisionNotes": "fixing scaling",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510806163
          },
          {
            "sbg:revision": 12,
            "sbg:revisionNotes": "fixing failed sample matrix output",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1510806575
          },
          {
            "sbg:revision": 13,
            "sbg:revisionNotes": "removed reads.csv output - added project code to other csvs",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520631118
          },
          {
            "sbg:revision": 14,
            "sbg:revisionNotes": "removed files now in docker container",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520649585
          },
          {
            "sbg:revision": 15,
            "sbg:revisionNotes": "removed hpv_types ouput...pos_neg_matrix is an array now",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520700059
          },
          {
            "sbg:revision": 16,
            "sbg:revisionNotes": "added cp to typeseqer o",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520971760
          },
          {
            "sbg:revision": 17,
            "sbg:revisionNotes": "add cp to /typeSeqerFiles",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520971806
          },
          {
            "sbg:revision": 18,
            "sbg:revisionNotes": "correcting cp to typeseqer",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520989616
          },
          {
            "sbg:revision": 19,
            "sbg:revisionNotes": "add cp *csv *pdf",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1520999606
          },
          {
            "sbg:revision": 20,
            "sbg:revisionNotes": "added rm * split.json",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1521087651
          },
          {
            "sbg:revision": 21,
            "sbg:revisionNotes": "added rm filter.json",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1521159965
          },
          {
            "sbg:revision": 22,
            "sbg:revisionNotes": "renamed filter file in args",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1521177239
          },
          {
            "sbg:revision": 23,
            "sbg:revisionNotes": "cgrlab/typeseqer:0.5.02",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1524596474
          },
          {
            "sbg:revision": 24,
            "sbg:revisionNotes": "added read count matrix output",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1524597294
          },
          {
            "sbg:revision": 25,
            "sbg:revisionNotes": "2017-Nov_HPV_Typing_MiSeq_MQ_and_MinLen_Filters_4.csv",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1524675608
          },
          {
            "sbg:revision": 26,
            "sbg:revisionNotes": "added _is_singularity",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1524678605
          },
          {
            "sbg:revision": 27,
            "sbg:revisionNotes": "removed extra cp and rm that are not needed anymore",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1524678658
          },
          {
            "sbg:revision": 28,
            "sbg:revisionNotes": "changed filename of Rscript",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1524820374
          },
          {
            "sbg:revision": 29,
            "sbg:revisionNotes": null,
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1524839820
          },
          {
            "sbg:revision": 30,
            "sbg:revisionNotes": "fixing qualified barcode report",
            "sbg:modifiedBy": "dave",
            "sbg:modifiedOn": 1524842142
          }
        ],
        "sbg:latestRevision": 30,
        "sbg:createdOn": 1510342185,
        "y": 297.1967869914836,
        "requirements": [
          {
            "fileDef": [
              {
                "fileContent": {
                  "engine": "#cwl-js-engine",
                  "script": "'args_control_defs = \"'+$job.inputs.control_defs.path+'\" \\n\\\nargs_run_manifest_path =  \"'+$job.inputs.run_manifest.path+'\" \\n\\\nargs_bam_header_path =  \"'+$job.inputs.bam_header_file.path+'\" \\n\\\nargs_hpv_types_path = \"'+$job.inputs.hpv_types_json.path+'\" \\n\\\nargs_pos_neg_filtering_criteria_path = \"/opt/2017-06-11_Pos-Neg_matrix_filtering_criteria_RefTable_v3.txt\" \\n\\\nargs_scaling_table = \"/opt/2017-11-24_TypeSeqer_Filtering_Scaling_Table_v2.csv\" \\n\\\nargs_parameter_file_path = \"/opt/2017-Nov_HPV_Typing_MiSeq_MQ_and_MinLen_Filters_4.csv\"';\n\n\n\n\n\n\n\n\n",
                  "class": "Expression"
                },
                "filename": "args.R"
              },
              {
                "fileContent": "#' ---\n#' title: TypeSeqer HPV Typing Report\n#' author: \"illumina MiSeq\"\n#' date: \"`r format(Sys.time(), '%d %B, %Y')`\"\n#' \n#' output:\n#'  pdf_document:\n#'     toc: true\n#' ---\n\n#+ load packages, echo=FALSE, include = FALSE\n\n# load packages or install them if not present on current system\n\ndynamic_require = function(x){\n  for( i in x ){\n    #  require returns TRUE invisibly if it was able to load package\n    if( ! require( i , character.only = TRUE ) ){\n      #  If package was not able to be loaded then re-install\n      install.packages( i , dependencies = TRUE )\n      #  Load package after installing\n      require( i , character.only = TRUE )\n    }\n  }\n}\n\ndynamic_require(c(\"tidyverse\",\n                  \"stringr\",\n                  \"jsonlite\",\n                  \"pander\",\n                  \"scales\",\n                  \"knitr\",\n                  \"rmarkdown\",\n                  \"fuzzyjoin\",\n                  \"ggsci\"))\nsessionInfo()\n\n#+ get args, echo=FALSE, include = FALSE\nread_lines(\"args.R\") %>% \nwriteLines()\nsource(\"args.R\")\n\n#+ parameters_df, echo=FALSE, include = FALSE\nparameters_df = read_csv(args_parameter_file_path) %>% \nmap_if(is.factor, as.character) %>% \nas_tibble() %>% \nselect(HPV_Type, display_order)\n\n#+ stream in and summarize hpv type counts, echo=FALSE, include = FALSE\nhpv_type_counts = stream_in(file(args_hpv_types_path)) %>%\ngroup_by(barcode, HPV_Type) %>%\nmutate(HPV_Type_count = sum(HPV_Type_count)) %>%\nungroup() %>%\nselect(barcode, HPV_Type, HPV_Type_count) %>%\ndistinct() %>%\narrange(barcode, HPV_Type)\n\n#+ read bam header, echo=FALSE, include = FALSE\nbam_header = read_tsv(args_bam_header_path, col_names = c(\"header_col1\", \"HPV_Type\",\"contig_size\")) %>%\nfilter(header_col1 == \"@SQ\") %>%\nmutate(HPV_Type = str_sub(HPV_Type, start=4)) %>%\nselect(HPV_Type) %>%\nglimpse()\n\n#bam_header\n\n#+ create hpv types longform, echo=FALSE, include = FALSE\nhpv_types_long = read_csv(args_run_manifest_path, col_names=TRUE) %>%\nfilter(!is.na(Owner_Sample_ID)) %>%\nmutate(barcode = paste0(BC1, BC2)) %>%\nselect(-BC1,-BC2) %>%\nfull_join(hpv_type_counts, by=\"barcode\")  %>%\nglimpse()\n\n#+ create hpv types dataframe, echo=FALSE, include = FALSE\nhpv_types = hpv_types_long %>%\n\n# bind with bam header to get contig names that might be absent from all samples in this particular run\nbind_rows(bam_header) %>%\n\n# merge with parameters file to get display order\nleft_join(parameters_df) %>% mutate(HPV_Type = factor(HPV_Type, levels=unique(HPV_Type[order(display_order)]), ordered=TRUE)) %>% select(-display_order) %>%\n\n# tranform from long form to actual matrix\nspread(HPV_Type, HPV_Type_count, fill = \"0\") %>% \nfilter(!is.na(Project)) %>%\ndo({\ntemp = .\nif (\"<NA>\" %in% colnames(temp)){temp = temp %>% select(-`<NA>`)}\ntemp = temp\n}) %>%\n# change columns back to numeric\nmutate_at(vars(starts_with(\"HPV\")), funs(as.numeric(.))) %>% mutate_at(vars(starts_with(\"B2M\")), funs(as.numeric(.))) %>%\n\n# condense/merge contigs that are from the same type\nmutate(HPV64 = HPV34 + HPV64) %>% \nmutate(HPV54 = HPV54 + HPV54_B_C_consensus) %>%\nmutate(HPV74 = HPV74 + HPV74_EU911625 + HPV74_EU911664 + HPV74_U40822) %>%\nselect(-HPV34, -HPV54_B_C_consensus, -HPV74_EU911625, -HPV74_EU911664, -HPV74_U40822) #%>% glimpse()\n\n#+ create full run read metrics df, echo=FALSE, include = FALSE\n\nread_metrics = stream_in(file(args_hpv_types_path), verbose=TRUE, pagesize = 100000) %>%\ngroup_by(barcode_1) %>%\nmutate(qualified_hpv_counts = sum(HPV_Type_count)) %>%\nungroup()\n\ntotal_reads_df = read_metrics %>%\nselect(file_name, page_num, pre_demultiplex_pairs) %>%\ndistinct() %>%\nmutate(total_reads = sum(pre_demultiplex_pairs))\n\npost_demultiplex_reads_df = read_metrics %>%\nselect(barcode_1, file_name, page_num, post_demultiplex_reads) %>%\ndistinct() %>%\ngroup_by(barcode_1) %>%\nmutate(total_post_demultiplex_reads = sum(post_demultiplex_reads)) %>%\nselect(barcode_1, total_post_demultiplex_reads) %>%\ndistinct() %>%\nglimpse()\n  \n\nread_metrics = read_metrics %>%\nmutate(total_reads = total_reads_df$total_reads[1]) %>%\nleft_join(post_demultiplex_reads_df) %>%\nungroup() %>%\nselect(barcode_1, total_reads, total_post_demultiplex_reads, qualified_hpv_counts) %>%\ndistinct() %>%\nmutate(qualified_perc = qualified_hpv_counts / total_post_demultiplex_reads) %>%\nselect(barcode_1, qualified_perc, total_reads, total_post_demultiplex_reads, qualified_hpv_counts) %>%\narrange(barcode_1) %>%\nglimpse()\n\n#+ scaling of reads, echo=FALSE, include = FALSE\n\n#1.  sum the pass filter reads for entire chip (all BC's); \"qualified_aligned_reads\" from read_metrics table output\n\nsum_pass_filter_reads = sum(read_metrics$total_post_demultiplex_reads)\n\nprint(sum_pass_filter_reads)\n\n#2.  count number of samples in each run using the manifest\n\ntemp = read_csv(args_run_manifest_path) %>% \nmutate(sample_num = n())\n\nnumber_of_samples = temp$sample_num[1]\n\nnumber_of_samples\n\n#3.  calculate average number of qualified reads per sample\n\nmean_qualified_reads = sum_pass_filter_reads / number_of_samples\n\n#4.  Set B2M min (inclusive) read numbers to min in factoring table\n\nfactoring_table = read_csv(args_scaling_table) %>%\nfilter(min_avg_reads_boundary <= mean_qualified_reads & max_avg_reads_boundary >= mean_qualified_reads)\n\n#+ read in filtering criteria, echo=FALSE, include = FALSE\nfiltering_criteria = read_tsv(args_pos_neg_filtering_criteria_path) %>% \nmap_if(is.factor, as.character) %>% \nas_tibble() %>%  \nrename(type_id = TYPE) %>%\nmutate(factored_min_reads_per_type = factoring_table$HPV_scaling_factor * Min_reads_per_type) %>%\nglimpse()\n\n#+ create pn matrix, echo=FALSE, include = FALSE,\n\n# read in hpv_types and left join with filtering criteria csv\npn_matrix = hpv_types %>% \ngather(\"type_id\", \"read_counts\", starts_with(\"HPV\")) %>%\nleft_join(filtering_criteria) %>%\n\n# calculate total reads and individual type percentage\ngroup_by(barcode) %>% \nmutate(hpv_total_reads = sum(read_counts)) %>% \nungroup() %>% \nmutate(type_perc = read_counts / hpv_total_reads) %>% \n\n# set b2m_status\nmutate(b2m_status = ifelse((B2M >= factoring_table$B2M_min) | hpv_total_reads >=1000, \"pass\", \"fail\")) %>% \n\n# now we set type status to positve and sequentially set to negative if any filters are failed\nmutate(type_status = \"pos\") %>% \nmutate(type_status = ifelse(hpv_total_reads >= 1000, type_status, \"neg\"))  %>% \nmutate(type_status = ifelse(read_counts >= factored_min_reads_per_type, type_status, \"neg\"))  %>% \nmutate(type_status = ifelse(type_perc >= Min_type_percent_hpv_reads, type_status, \"neg\")) %>%\narrange(barcode) %>%\n\n# spread back into matrix format\nmutate(Human_Control = ifelse(b2m_status == \"fail\", \"failed_to_amplify\", b2m_status)) %>%\nselect(-b2m_status, -Min_reads_per_type, -factored_min_reads_per_type, -hpv_total_reads, -type_perc, -Min_type_percent_hpv_reads, -read_counts, -B2M) %>%\nmutate(type_id = factor(type_id,levels=filtering_criteria$type_id)) %>% # This keeps the proper column order\nspread(type_id, type_status, fill=\"neg\") %>%\narrange(barcode)\n\n#' ## Expected Control Results\n\n#+ expected control results, results='asis', echo=FALSE, message=FALSE\n\n# 1.  read in control defs\n\ncontrol_defs = read_csv(args_control_defs) %>% \nmap_if(is.factor, as.character) %>% \nas_tibble() %>%\nungroup() %>%\ngather(\"type\", \"status\", -Control_Code) %>%\narrange(Control_Code) \n\n# 2.  merge pn matrix with control defs\n\ncontrol_results = pn_matrix %>%\nungroup() %>%\nmap_if(is.factor, as.character) %>% \nas_tibble() %>%\nselect(Owner_Sample_ID, starts_with(\"HPV\")) %>%\ngather(\"type\", \"status\", -Owner_Sample_ID) %>%\nfuzzy_join(control_defs, mode = \"inner\", by=c(\"Owner_Sample_ID\" = \"Control_Code\"), match_fun = function(x, y) str_detect(x, fixed(y, ignore_case=TRUE))) %>%\nfilter(type.x == type.y) %>%\narrange(Owner_Sample_ID, type.y) %>%\nselect(Owner_Sample_ID, Control_Code, type = type.x, status_pn = status.x, status_control = status.y) %>%\n           \n# 3. calculate result\n\nmutate(control_value = ifelse(status_pn == status_control, 0, 1)) %>%\ngroup_by(Owner_Sample_ID) %>%\nmutate(failed_type_sum = sum(control_value)) %>%\nungroup() %>%\nselect(Control_Code, Owner_Sample_ID, failed_type_sum) %>%\ndistinct() %>%\nmutate(control_result = ifelse(failed_type_sum==0, \"pass\", \"fail\")) %>%\nselect(-failed_type_sum) %>%\narrange(Control_Code, Owner_Sample_ID)\n\n#+ print expected control results, results='asis', echo=FALSE, message=FALSE\n\npandoc.table(control_results %>% select(-Control_Code), style = \"multiline\", justify=c(\"right\", \"left\"),  caption = \"Expected Control Results - Pass and Fail\", use.hyphening=TRUE, split.cells=30)\n           \nif(length((control_results %>% select(-Control_Code) %>% filter(control_result == \"fail\"))$control_result) > 2){\n           \npandoc.table(control_results %>% select(-Control_Code) %>% filter(control_result == \"fail\"), style = \"multiline\", justify=c(\"right\", \"left\"),  caption = \"Expected Control Results - Failed controls\", use.hyphening=TRUE, split.cells=30)\n           \n  }  else {\n  \nprint(\"There were no control failures\")  \n  \n}   \n\n#' ## Qualified Barcode Reads Histogram\n\n#+ qualified barcode reads histogram, echo=FALSE, message=FALSE, warning=FALSE\n\nggplot(read_metrics %>% rename(`qualifed reads percentage` = qualified_perc), aes(barcode_1, `qualifed reads percentage`)) +\ngeom_bar(stat=\"identity\", aes(fill=`qualifed reads percentage`)) +\ncoord_flip() +\nlabs(title = \"Qualifed Barcode 1 Reads\")\n\n#+ samples only matrix, echo=FALSE, message=FALSE, warning=FALSE\n\nsamples_only_matrix = pn_matrix %>%\nanti_join(control_results)\n\n#+ failed samples matrix, echo=FALSE, message=FALSE, warning=FALSE\n\nfailed_samples_matrix = samples_only_matrix  %>%\nfilter(Human_Control == \"failed_to_amplify\")\n\n#+ control matrix, echo=FALSE, message=FALSE, warning=FALSE, include=FALSE\n\ncontrol_matrix = control_results %>%\nleft_join(pn_matrix) %>%\narrange(control_result, Control_Code)\n\n#+ write all csv files, echo=FALSE, include = FALSE\n\ntemp = pn_matrix %>%\ngroup_by(Project) %>%\ndo({\ntemp = . \nwrite_csv(samples_only_matrix, paste(temp$Project[1], temp$Assay_Batch_Code[1], \"samples_only_matrix.csv\", sep=\"_\"))\n})\n\n#write_csv(read_metrics, paste0(pn_matrix$Assay_Batch_Code[1], \"_read_metrics.csv\")) #need to add \"total_reads\" column to the left of B2M\nwrite_csv(hpv_types, paste0(pn_matrix$Assay_Batch_Code[1], \"_hpv_read_counts_matrix.csv\"))\nwrite_csv(control_matrix, paste0(pn_matrix$Assay_Batch_Code[1], \"_control_results.csv\")) \nwrite_csv(failed_samples_matrix, paste0(pn_matrix$Assay_Batch_Code[1], \"_failed_samples_matrix.csv\"))\nwrite_csv(pn_matrix, paste0(pn_matrix$Assay_Batch_Code[1], \"_full_pn_matrix.csv\"))",
                "filename": "illumina_TypeSeqer_report.R"
              }
            ],
            "class": "CreateFileRequirement"
          },
          {
            "requirements": [
              {
                "dockerPull": "rabix/js-engine",
                "class": "DockerRequirement"
              }
            ],
            "id": "#cwl-js-engine",
            "class": "ExpressionEngineRequirement"
          }
        ],
        "sbg:projectName": "cgrHPV",
        "sbg:validationErrors": [],
        "sbg:project": "dave/cgrhpv",
        "id": "dave/cgrhpv/illumina-typeseqer-report/30",
        "sbg:modifiedBy": "dave",
        "baseCommand": [
          "Rscript",
          "-e",
          "'require(rmarkdown);",
          "render(\"illumina_TypeSeqer_report.R\")",
          "'",
          {
            "engine": "#cwl-js-engine",
            "script": "if ($job.inputs.is_singularity == true){\n\"&& rm ../*/*split.json && rm ../*/*filtered.json \\\n&& mkdir /typeSeqerFiles/illumina_typeseqer_output \\\n&& cp *pdf *csv /typeSeqerFiles/illumina_typeseqer_output \\\n\"\n}",
            "class": "Expression"
          }
        ],
        "inputs": [
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#run_manifest",
            "streamable": false,
            "default": "",
            "required": false
          },
          {
            "sbg:stageInput": null,
            "id": "#is_singularity",
            "type": [
              "null",
              "boolean"
            ]
          },
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#hpv_types_json",
            "streamable": false,
            "default": "",
            "required": false
          },
          {
            "id": "#control_defs",
            "type": [
              "null",
              "File"
            ],
            "required": false
          },
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#bam_header_file",
            "streamable": false,
            "default": "",
            "required": false
          }
        ],
        "sbg:modifiedOn": 1524842142,
        "cwlVersion": "sbg:draft-2",
        "x": 941.9657065440366,
        "sbg:revisionNotes": "fixing qualified barcode report",
        "sbg:createdBy": "dave",
        "sbg:id": "dave/cgrhpv/illumina-typeseqer-report/30"
      },
      "outputs": [
        {
          "id": "#illumina_typeseqer_report.samples_only_matrix"
        },
        {
          "id": "#illumina_typeseqer_report.pos_neg_matrix"
        },
        {
          "id": "#illumina_typeseqer_report.pdf_report"
        },
        {
          "id": "#illumina_typeseqer_report.hpv_read_counts_matrix"
        },
        {
          "id": "#illumina_typeseqer_report.failed_samples_matrix"
        },
        {
          "id": "#illumina_typeseqer_report.control_matrix"
        }
      ],
      "inputs": [
        {
          "id": "#illumina_typeseqer_report.run_manifest",
          "source": [
            "#run_manifest"
          ]
        },
        {
          "id": "#illumina_typeseqer_report.is_singularity",
          "source": [
            "#is_singularity"
          ]
        },
        {
          "id": "#illumina_typeseqer_report.hpv_types_json",
          "source": [
            "#cat_json.merged_json"
          ]
        },
        {
          "id": "#illumina_typeseqer_report.control_defs",
          "source": [
            "#control_defs"
          ]
        },
        {
          "id": "#illumina_typeseqer_report.bam_header_file",
          "source": [
            "#SAMtools_extract_SAM_BAM_header.output_header_file"
          ]
        }
      ],
      "sbg:x": 941.9657065440366,
      "id": "#illumina_typeseqer_report",
      "sbg:y": 297.1967869914836
    }
  ],
  "sbg:revisionsInfo": [
    {
      "sbg:revision": 0,
      "sbg:modifiedOn": 1492530729,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "Copy of dave/cgrhpv/hpv-typing-workflow/80"
    },
    {
      "sbg:revision": 1,
      "sbg:modifiedOn": 1492531022,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 2,
      "sbg:modifiedOn": 1492531743,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 3,
      "sbg:modifiedOn": 1492531793,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "default instance"
    },
    {
      "sbg:revision": 4,
      "sbg:modifiedOn": 1492532341,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "just sambamba view"
    },
    {
      "sbg:revision": 5,
      "sbg:modifiedOn": 1492539957,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "updated run processor app"
    },
    {
      "sbg:revision": 6,
      "sbg:modifiedOn": 1492539998,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed report app"
    },
    {
      "sbg:revision": 7,
      "sbg:modifiedOn": 1492541026,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "\"removing references to A1 barcode\""
    },
    {
      "sbg:revision": 8,
      "sbg:modifiedOn": 1492541506,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added scatter to run processor app"
    },
    {
      "sbg:revision": 9,
      "sbg:modifiedOn": 1492542324,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 10,
      "sbg:modifiedOn": 1492542350,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 11,
      "sbg:modifiedOn": 1492547750,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "c4.8xlarge"
    },
    {
      "sbg:revision": 12,
      "sbg:modifiedOn": 1492634532,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added hpv_typing report back i with illumina capability"
    },
    {
      "sbg:revision": 13,
      "sbg:modifiedOn": 1492634752,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "unlocked report params"
    },
    {
      "sbg:revision": 14,
      "sbg:modifiedOn": 1492635208,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "\"corrected csv.xls output globs\""
    },
    {
      "sbg:revision": 15,
      "sbg:modifiedOn": 1492635371,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 16,
      "sbg:modifiedOn": 1492687776,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "hpv typing report \"fixing get args\""
    },
    {
      "sbg:revision": 17,
      "sbg:modifiedOn": 1492687838,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 18,
      "sbg:modifiedOn": 1492688955,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "sambamba view unlocked nthreads"
    },
    {
      "sbg:revision": 19,
      "sbg:modifiedOn": 1492689125,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "sambamba view - removed json output node"
    },
    {
      "sbg:revision": 20,
      "sbg:modifiedOn": 1492689778,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing report - \"fixing get args again\""
    },
    {
      "sbg:revision": 21,
      "sbg:modifiedOn": 1492691192,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing report - \"added cat get_args.R for debug\""
    },
    {
      "sbg:revision": 22,
      "sbg:modifiedOn": 1492691487,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing_report - \"added print lines to help debug\""
    },
    {
      "sbg:revision": 23,
      "sbg:modifiedOn": 1492691724,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing report \"fixing space after - BC2\""
    },
    {
      "sbg:revision": 24,
      "sbg:modifiedOn": 1492695746,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing report \"fixing get args again\""
    },
    {
      "sbg:revision": 25,
      "sbg:modifiedOn": 1492698050,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing report \"adding write to std.err stuff to hpv_typing_report.R\""
    },
    {
      "sbg:revision": 26,
      "sbg:modifiedOn": 1492699291,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing report \"fixing get_args.R again\""
    },
    {
      "sbg:revision": 27,
      "sbg:modifiedOn": 1492702401,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "\"fixing debut to std.err\""
    },
    {
      "sbg:revision": 28,
      "sbg:modifiedOn": 1492714435,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 29,
      "sbg:modifiedOn": 1492714575,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "\"added bam header input\""
    },
    {
      "sbg:revision": 30,
      "sbg:modifiedOn": 1492714771,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added sam tools extract header"
    },
    {
      "sbg:revision": 31,
      "sbg:modifiedOn": 1492716781,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing_report \"added require stringr package\""
    },
    {
      "sbg:revision": 32,
      "sbg:modifiedOn": 1494508291,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed sambamba view filter parameter"
    },
    {
      "sbg:revision": 33,
      "sbg:modifiedOn": 1494509971,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "save page_size is now locked at 10000"
    },
    {
      "sbg:revision": 34,
      "sbg:modifiedOn": 1495049175,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 35,
      "sbg:modifiedOn": 1495053100,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 36,
      "sbg:modifiedOn": 1495053910,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 37,
      "sbg:modifiedOn": 1510167803,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added bwa-mem"
    },
    {
      "sbg:revision": 38,
      "sbg:modifiedOn": 1510168918,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 39,
      "sbg:modifiedOn": 1510169007,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "corrected outputs"
    },
    {
      "sbg:revision": 40,
      "sbg:modifiedOn": 1510169659,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed tar -z"
    },
    {
      "sbg:revision": 41,
      "sbg:modifiedOn": 1510172125,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\"correcting fasta index command\""
    },
    {
      "sbg:revision": 42,
      "sbg:modifiedOn": 1510173103,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle (\n\"removed some extra commands\""
    },
    {
      "sbg:revision": 43,
      "sbg:modifiedOn": 1510173250,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle\n\"putting commands back in\""
    },
    {
      "sbg:revision": 44,
      "sbg:modifiedOn": 1510173331,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "exposed threads"
    },
    {
      "sbg:revision": 45,
      "sbg:modifiedOn": 1510173969,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed select first file in array and sambamba view is not scattered now"
    },
    {
      "sbg:revision": 46,
      "sbg:modifiedOn": 1510176016,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed some apps and added split_json app"
    },
    {
      "sbg:revision": 47,
      "sbg:modifiedOn": 1510251174,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added illumina splitter"
    },
    {
      "sbg:revision": 48,
      "sbg:modifiedOn": 1510251693,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor (Revision 9) which has a new update available.\nDo you want to update this node?\n\nRevision note:\n\n\"added html out\""
    },
    {
      "sbg:revision": 49,
      "sbg:modifiedOn": 1510251716,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 50,
      "sbg:modifiedOn": 1510252720,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor\n\"renamed args.R\""
    },
    {
      "sbg:revision": 51,
      "sbg:modifiedOn": 1510252898,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor \n\"removed some args from command line\""
    },
    {
      "sbg:revision": 52,
      "sbg:modifiedOn": 1510253489,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "exposed json_spitter number and page size in the other app"
    },
    {
      "sbg:revision": 53,
      "sbg:modifiedOn": 1510257656,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added merge hpv types"
    },
    {
      "sbg:revision": 54,
      "sbg:modifiedOn": 1510343085,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added typeseqer report"
    },
    {
      "sbg:revision": 55,
      "sbg:modifiedOn": 1510343174,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added sam tools extrac sam/bam header"
    },
    {
      "sbg:revision": 56,
      "sbg:modifiedOn": 1510503415,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report (Revision 3) which has a new update available.\nDo you want to update this node?\n\nRevision note:\n\n\"illumina report finishes on db\""
    },
    {
      "sbg:revision": 57,
      "sbg:modifiedOn": 1510505544,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"removed thumbnail code\""
    },
    {
      "sbg:revision": 58,
      "sbg:modifiedOn": 1510583840,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added bwa index"
    },
    {
      "sbg:revision": 59,
      "sbg:modifiedOn": 1510606517,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added more report outputs"
    },
    {
      "sbg:revision": 60,
      "sbg:modifiedOn": 1510615533,
      "sbg:modifiedBy": "sarah",
      "sbg:revisionNotes": "BWA parameters match revision 19 of BWA_Typing_FINAL from April 2017"
    },
    {
      "sbg:revision": 61,
      "sbg:modifiedOn": 1510711613,
      "sbg:modifiedBy": "sarah",
      "sbg:revisionNotes": "turned off soft clipping"
    },
    {
      "sbg:revision": 62,
      "sbg:modifiedOn": 1510715589,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"added contig collapse\""
    },
    {
      "sbg:revision": 63,
      "sbg:modifiedOn": 1510721279,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 64,
      "sbg:modifiedOn": 1510757738,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report\n\"fixing read metric and b2m issues\""
    },
    {
      "sbg:revision": 65,
      "sbg:modifiedOn": 1510769262,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"adjusted filtering criteria\""
    },
    {
      "sbg:revision": 66,
      "sbg:modifiedOn": 1510769328,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "max number of parallel instances is 4"
    },
    {
      "sbg:revision": 67,
      "sbg:modifiedOn": 1510775805,
      "sbg:modifiedBy": "sarah",
      "sbg:revisionNotes": "soft clipping on"
    },
    {
      "sbg:revision": 68,
      "sbg:modifiedOn": 1510792478,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor \n\"fixing barcode orientation\""
    },
    {
      "sbg:revision": 69,
      "sbg:modifiedOn": 1510792705,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor\n\"fixing barcodes\""
    },
    {
      "sbg:revision": 70,
      "sbg:modifiedOn": 1510799376,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor \n\"added fwd rev back in\""
    },
    {
      "sbg:revision": 71,
      "sbg:modifiedOn": 1510806227,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report\n\"fixing scaling\""
    },
    {
      "sbg:revision": 72,
      "sbg:modifiedOn": 1510806643,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"fixing failed sample matrix output\""
    },
    {
      "sbg:revision": 73,
      "sbg:modifiedOn": 1520368695,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "hardcoded true for bwa smart pairing"
    },
    {
      "sbg:revision": 74,
      "sbg:modifiedOn": 1520368770,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "hardcoded filter out secondary alignments"
    },
    {
      "sbg:revision": 75,
      "sbg:modifiedOn": 1520368851,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "bwa hardcoded threads and ram stuff"
    },
    {
      "sbg:revision": 76,
      "sbg:modifiedOn": 1520369003,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "sambamba harcoded threads and ram"
    },
    {
      "sbg:revision": 77,
      "sbg:modifiedOn": 1520369114,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "hardcoded number of lines per json split"
    },
    {
      "sbg:revision": 78,
      "sbg:modifiedOn": 1520369342,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "harcoded page size"
    },
    {
      "sbg:revision": 79,
      "sbg:modifiedOn": 1520387442,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\n\"removed pipe commands at end\""
    },
    {
      "sbg:revision": 80,
      "sbg:modifiedOn": 1520391278,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle\n\"test tar command\""
    },
    {
      "sbg:revision": 81,
      "sbg:modifiedOn": 1520391765,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 82,
      "sbg:modifiedOn": 1520394932,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 83,
      "sbg:modifiedOn": 1520396115,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "bwa version 0"
    },
    {
      "sbg:revision": 84,
      "sbg:modifiedOn": 1520396870,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 85,
      "sbg:modifiedOn": 1520447242,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 86,
      "sbg:modifiedOn": 1520448557,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 87,
      "sbg:modifiedOn": 1520449523,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\n\"added and ending quote\""
    },
    {
      "sbg:revision": 88,
      "sbg:modifiedOn": 1520450318,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle\n\n\"on tar an bwa"
    },
    {
      "sbg:revision": 89,
      "sbg:modifiedOn": 1520450910,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle\n\"moved args around\""
    },
    {
      "sbg:revision": 90,
      "sbg:modifiedOn": 1520451267,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 91,
      "sbg:modifiedOn": 1520454182,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\"aligned.bam\""
    },
    {
      "sbg:revision": 92,
      "sbg:modifiedOn": 1520455767,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added sambamba sort"
    },
    {
      "sbg:revision": 93,
      "sbg:modifiedOn": 1520455901,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 94,
      "sbg:modifiedOn": 1520457532,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\"put many commands back in\""
    },
    {
      "sbg:revision": 95,
      "sbg:modifiedOn": 1520458478,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 96,
      "sbg:modifiedOn": 1520458752,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 97,
      "sbg:modifiedOn": 1520533243,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 98,
      "sbg:modifiedOn": 1520606901,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "turned off smart pairing"
    },
    {
      "sbg:revision": 99,
      "sbg:modifiedOn": 1520631215,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added project names to csv outputs"
    },
    {
      "sbg:revision": 100,
      "sbg:modifiedOn": 1520649918,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"removed files now in docker container\""
    },
    {
      "sbg:revision": 101,
      "sbg:modifiedOn": 1520650551,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 102,
      "sbg:modifiedOn": 1520650914,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor \n\"barcode file is now in the docker\""
    },
    {
      "sbg:revision": 103,
      "sbg:modifiedOn": 1520652903,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added hpv typeseqer reference app"
    },
    {
      "sbg:revision": 104,
      "sbg:modifiedOn": 1520700139,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"removed hpv_types ouput...pos_neg_matrix is an array now\""
    },
    {
      "sbg:revision": 105,
      "sbg:modifiedOn": 1520716152,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "corrected some command line in bwa mem"
    },
    {
      "sbg:revision": 106,
      "sbg:modifiedOn": 1520716482,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "corrected bwa index command line"
    },
    {
      "sbg:revision": 107,
      "sbg:modifiedOn": 1520716822,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\"fixing sambamba command line\""
    },
    {
      "sbg:revision": 108,
      "sbg:modifiedOn": 1520717784,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "SAMtools extract SAM/BAM header \n\"cgrlab/typeseqer:latest\""
    },
    {
      "sbg:revision": 109,
      "sbg:modifiedOn": 1520719010,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed output header in bwa mem"
    },
    {
      "sbg:revision": 110,
      "sbg:modifiedOn": 1520741498,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\n\"removed samblaster\""
    },
    {
      "sbg:revision": 111,
      "sbg:modifiedOn": 1520741988,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "add ram and thread parameters for bwa"
    },
    {
      "sbg:revision": 112,
      "sbg:modifiedOn": 1520743448,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "put sambamba view json back in"
    },
    {
      "sbg:revision": 113,
      "sbg:modifiedOn": 1520743677,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 114,
      "sbg:modifiedOn": 1520743925,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "Sambamba View \ntypeseqer docker\""
    },
    {
      "sbg:revision": 115,
      "sbg:modifiedOn": 1520820514,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed fasta app"
    },
    {
      "sbg:revision": 116,
      "sbg:modifiedOn": 1520824176,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "updated json_splitter and brought back fasta ref app"
    },
    {
      "sbg:revision": 117,
      "sbg:modifiedOn": 1520827682,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed sam header"
    },
    {
      "sbg:revision": 118,
      "sbg:modifiedOn": 1520877020,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor\n\"put barcode back in\""
    },
    {
      "sbg:revision": 119,
      "sbg:modifiedOn": 1520877072,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "bam header file is now an input"
    },
    {
      "sbg:revision": 120,
      "sbg:modifiedOn": 1520971873,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"add cp to /typeSeqerFiles\""
    },
    {
      "sbg:revision": 121,
      "sbg:modifiedOn": 1520991200,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"correcting cp to typeseqer\""
    },
    {
      "sbg:revision": 122,
      "sbg:modifiedOn": 1520999660,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"add cp *csv *pdf\""
    },
    {
      "sbg:revision": 123,
      "sbg:modifiedOn": 1520999785,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added back in samtools sam/bam extract header"
    },
    {
      "sbg:revision": 124,
      "sbg:modifiedOn": 1521087779,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"added rm * split.json\""
    },
    {
      "sbg:revision": 125,
      "sbg:modifiedOn": 1521166125,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"added rm filter.json\""
    },
    {
      "sbg:revision": 126,
      "sbg:modifiedOn": 1521177630,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "updated hardcoded file names for new repo"
    },
    {
      "sbg:revision": 127,
      "sbg:modifiedOn": 1524597154,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "\"cgrlab/typeseqer:0.5.02\""
    },
    {
      "sbg:revision": 128,
      "sbg:modifiedOn": 1524597332,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report\n\"added read count matrix output\""
    },
    {
      "sbg:revision": 129,
      "sbg:modifiedOn": 1524597367,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null
    },
    {
      "sbg:revision": 130,
      "sbg:modifiedOn": 1524599591,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor \n\"args_parameter_file = \"/opt/2017-Nov_HPV_Typing_MiSeq_MQ_and_MinLen_Filters_4.csv\" \\n\\\""
    },
    {
      "sbg:revision": 131,
      "sbg:modifiedOn": 1524675651,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report\n\"2017-Nov_HPV_Typing_MiSeq_MQ_and_MinLen_Filters_4.csv\""
    },
    {
      "sbg:revision": 132,
      "sbg:modifiedOn": 1524678698,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report\n\"removed extra cp and rm that are not needed anymore\""
    },
    {
      "sbg:revision": 133,
      "sbg:modifiedOn": 1524821226,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added output for merged json"
    },
    {
      "sbg:revision": 134,
      "sbg:modifiedOn": 1524842258,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"fixing qualified barcode report\""
    },
    {
      "sbg:revision": 135,
      "sbg:modifiedOn": 1530286835,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "back to version 125 which was sent to the cdc"
    },
    {
      "sbg:revision": 136,
      "sbg:modifiedOn": 1530287103,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "back to latest version of pipeline..also exposed is singularity"
    }
  ],
  "sbg:createdOn": 1492530729,
  "sbg:canvas_y": 95,
  "id": "https://api.sbgenomics.com/v2/apps/dave/cgrhpv/hpv-typing-illumina-workflow/136/raw/",
  "sbg:toolkit": "hpv_typing",
  "sbg:revisionNotes": "back to latest version of pipeline..also exposed is singularity",
  "sbg:canvas_zoom": 0.6499999999999997,
  "sbg:canvas_x": -29,
  "sbg:id": "dave/cgrhpv/hpv-typing-illumina-workflow/136",
  "outputs": [
    {
      "sbg:includeInPorts": true,
      "sbg:y": 73.84618195979647,
      "label": "pos_neg_matrix",
      "sbg:x": 1347.607013742841,
      "id": "#pos_neg_matrix",
      "type": [
        "null",
        "File"
      ],
      "source": [
        "#illumina_typeseqer_report.pos_neg_matrix"
      ],
      "required": false
    },
    {
      "sbg:includeInPorts": true,
      "sbg:y": 162.906041988022,
      "label": "pdf_report",
      "sbg:x": 1515.1284126784042,
      "id": "#pdf_report",
      "type": [
        "null",
        "File"
      ],
      "source": [
        "#illumina_typeseqer_report.pdf_report"
      ],
      "required": false
    },
    {
      "sbg:includeInPorts": true,
      "sbg:y": 5.641045051214377,
      "label": "samples_only_matrix",
      "sbg:x": 1145.0430700717984,
      "id": "#samples_only_matrix",
      "type": [
        "null",
        "File"
      ],
      "source": [
        "#illumina_typeseqer_report.samples_only_matrix"
      ],
      "required": false
    },
    {
      "sbg:includeInPorts": true,
      "sbg:y": 358.11970133847365,
      "label": "failed_samples_matrix",
      "sbg:x": 1309.4874467765203,
      "id": "#failed_samples_matrix",
      "type": [
        "null",
        "File"
      ],
      "source": [
        "#illumina_typeseqer_report.failed_samples_matrix"
      ],
      "required": false
    },
    {
      "sbg:includeInPorts": true,
      "sbg:y": 440.2564863425059,
      "label": "control_matrix",
      "sbg:x": 1160.0000605216399,
      "id": "#control_matrix",
      "type": [
        "null",
        "File"
      ],
      "source": [
        "#illumina_typeseqer_report.control_matrix"
      ],
      "required": false
    },
    {
      "sbg:includeInPorts": true,
      "sbg:y": 298.46156127071987,
      "label": "hpv_read_counts_matrix",
      "sbg:x": 1476.9233018322184,
      "id": "#hpv_read_counts_matrix",
      "type": [
        "null",
        "File"
      ],
      "source": [
        "#illumina_typeseqer_report.hpv_read_counts_matrix"
      ],
      "required": false
    },
    {
      "sbg:includeInPorts": true,
      "sbg:y": -38.46154789106411,
      "label": "merged_json",
      "sbg:x": 976.9231150305473,
      "id": "#merged_json",
      "type": [
        "null",
        "File"
      ],
      "source": [
        "#cat_json.merged_json"
      ],
      "required": false
    },
    {
      "sbg:includeInPorts": true,
      "sbg:x": 975.3846814082224,
      "sbg:y": 667.6923220933535,
      "label": "output_header_file",
      "sbg:fileTypes": "TXT",
      "id": "#output_header_file",
      "type": [
        "File"
      ],
      "source": [
        "#SAMtools_extract_SAM_BAM_header.output_header_file"
      ],
      "required": true
    }
  ],
  "sbg:categories": [
    "hpv_typing"
  ],
  "sbg:modifiedOn": 1530287103,
  "inputs": [
    {
      "sbg:x": -245.10125359832634,
      "sbg:y": 461.0526659884442,
      "label": "input_reads",
      "sbg:fileTypes": "FASTQ, FASTQ.GZ, FQ, FQ.GZ",
      "id": "#input_reads",
      "type": [
        {
          "items": "File",
          "name": "input_reads",
          "type": "array"
        }
      ]
    },
    {
      "sbg:x": 487.35075453284014,
      "sbg:y": 319.9148560482775,
      "id": "#control_defs",
      "type": [
        "null",
        "File"
      ],
      "label": "control_defs"
    },
    {
      "sbg:x": 655.2138693168172,
      "sbg:y": -25.726484094615316,
      "id": "#run_manifest",
      "type": [
        "null",
        "File"
      ],
      "label": "run_manifest"
    },
    {
      "sbg:x": 256.92303579657454,
      "sbg:y": -4.615409128765847,
      "id": "#barcode_file",
      "type": [
        "null",
        "File"
      ],
      "label": "barcode_file"
    },
    {
      "sbg:stageInput": null,
      "id": "#is_singularity",
      "type": [
        "null",
        "boolean"
      ]
    }
  ],
  "class": "Workflow",
  "sbg:appVersion": [
    "sbg:draft-2"
  ],
  "$namespaces": {
    "sbg": "https://sevenbridges.com"
  },
  "sbg:revision": 136,
  "sbg:latestRevision": 136,
  "requirements": [],
  "sbg:projectName": "cgrHPV",
  "sbg:createdBy": "dave",
  "sbg:modifiedBy": "dave",
  "sbg:validationErrors": [],
  "cwlVersion": "sbg:draft-2",
  "label": "hpv typing illumina workflow"
}
