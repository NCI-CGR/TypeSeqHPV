{
  "sbg:sbgMaintained": false,
  "description": "",
  "sbg:id": "dave/cgrhpv/hpv-typing-illumina-workflow/125",
  "steps": [
    {
      "sbg:x": 696.7524094008027,
      "outputs": [
        {
          "id": "#cat_json.merged_json"
        }
      ],
      "run": {
        "sbg:sbgMaintained": false,
        "description": "",
        "baseCommand": [
          "cat",
          {
            "script": "'*' + $job.inputs.input_suffix_and_extension",
            "class": "Expression",
            "engine": "#cwl-js-engine"
          }
        ],
        "sbg:id": "dave/cgrhpv/cat-json/8",
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "sbg:revisionNotes": "added prefix input",
        "stdin": "",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:projectName": "cgrHPV",
        "id": "dave/cgrhpv/cat-json/8",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedOn": 1486841449,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 0
          },
          {
            "sbg:modifiedOn": 1486841686,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 1
          },
          {
            "sbg:modifiedOn": 1486841826,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 2
          },
          {
            "sbg:modifiedOn": 1486858801,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 3
          },
          {
            "sbg:modifiedOn": 1486874369,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 4
          },
          {
            "sbg:modifiedOn": 1494294732,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "made a better cat app",
            "sbg:revision": 5
          },
          {
            "sbg:modifiedOn": 1495472946,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 6
          },
          {
            "sbg:modifiedOn": 1505248169,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "switched to wildcard",
            "sbg:revision": 7
          },
          {
            "sbg:modifiedOn": 1505248365,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added prefix input",
            "sbg:revision": 8
          }
        ],
        "successCodes": [],
        "inputs": [
          {
            "type": [
              "null",
              "string"
            ],
            "id": "#prefix_for_output"
          },
          {
            "sbg:stageInput": "link",
            "required": false,
            "type": [
              "null",
              {
                "items": "File",
                "type": "array"
              }
            ],
            "id": "#json"
          },
          {
            "type": [
              "null",
              "string"
            ],
            "id": "#input_suffix_and_extension"
          }
        ],
        "sbg:modifiedBy": "dave",
        "sbg:image_url": null,
        "stdout": "",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:modifiedOn": 1505248365,
        "sbg:createdOn": 1486841449,
        "outputs": [
          {
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#json",
              "glob": {
                "script": "\"*merged.json\"",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              }
            },
            "type": [
              "null",
              "File"
            ],
            "id": "#merged_json"
          }
        ],
        "sbg:project": "dave/cgrhpv",
        "class": "CommandLineTool",
        "sbg:cmdPreview": "cat *concat.json > HPV_all_vcf_merged.json",
        "sbg:createdBy": "dave",
        "cwlVersion": "sbg:draft-2",
        "label": "merge hpv types",
        "arguments": [
          {
            "position": 99,
            "valueFrom": {
              "script": "$job.inputs.prefix_for_output + \"_merged.json\"",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "separate": true,
            "prefix": ">"
          }
        ],
        "x": 696.7524094008027,
        "hints": [
          {
            "class": "sbg:CPURequirement",
            "value": 1
          },
          {
            "class": "sbg:MemRequirement",
            "value": 1000
          },
          {
            "class": "DockerRequirement",
            "dockerImageId": "",
            "dockerPull": "cgrlab/tidyverse"
          }
        ],
        "sbg:validationErrors": [],
        "sbg:publisher": "sbg",
        "sbg:latestRevision": 8,
        "y": 195.31128403863906,
        "temporaryFailCodes": [],
        "sbg:job": {
          "inputs": {
            "prefix_for_output": "HPV_all_vcf",
            "input_suffix_and_extension": "concat.json",
            "json": [
              {
                "secondaryFiles": [],
                "class": "File",
                "size": 0,
                "path": "path/to/sample01.json"
              },
              {
                "secondaryFiles": [],
                "class": "File",
                "size": 0,
                "path": "path/to/sample02.json"
              }
            ]
          },
          "allocatedResources": {
            "cpu": 1,
            "mem": 1000
          }
        },
        "sbg:revision": 8
      },
      "inputs": [
        {
          "id": "#cat_json.prefix_for_output",
          "default": "illumina_hpv_types"
        },
        {
          "source": [
            "#illumina_typing_run_processor.hpv_types"
          ],
          "id": "#cat_json.json"
        },
        {
          "id": "#cat_json.input_suffix_and_extension",
          "default": "hpv_types.json"
        }
      ],
      "id": "#cat_json",
      "sbg:y": 195.31128403863906
    },
    {
      "sbg:x": -364.61544754660576,
      "outputs": [
        {
          "id": "#illumina_typeseqer_hpv_reference.typing_reference"
        }
      ],
      "run": {
        "sbg:sbgMaintained": false,
        "description": "",
        "baseCommand": [
          "cp",
          "/opt/HPV-Typing_MiSeq_Ref_Nov2017.fasta",
          "./"
        ],
        "sbg:id": "dave/cgrhpv/illumina-typeseqer-hpv-reference/1",
        "requirements": [],
        "stdin": "",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:projectName": "cgrHPV",
        "id": "dave/cgrhpv/illumina-typeseqer-hpv-reference/1",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedOn": 1520652650,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 0
          },
          {
            "sbg:modifiedOn": 1520652803,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 1
          }
        ],
        "sbg:cmdPreview": "cp /opt/HPV-Typing_MiSeq_Ref_Nov2017.fasta ./",
        "y": 282.3197288886598,
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "sbg:modifiedBy": "dave",
        "successCodes": [],
        "stdout": "",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:modifiedOn": 1520652803,
        "sbg:createdOn": 1520652650,
        "outputs": [
          {
            "outputBinding": {
              "glob": {
                "script": "\"*.fasta\"",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              }
            },
            "type": [
              "null",
              "File"
            ],
            "id": "#typing_reference"
          }
        ],
        "sbg:project": "dave/cgrhpv",
        "sbg:image_url": null,
        "sbg:createdBy": "dave",
        "cwlVersion": "sbg:draft-2",
        "label": "illumina-typeseqer-hpv-reference",
        "arguments": [],
        "x": -364.61544754660576,
        "hints": [
          {
            "class": "sbg:CPURequirement",
            "value": 1
          },
          {
            "class": "sbg:MemRequirement",
            "value": 1000
          },
          {
            "class": "DockerRequirement",
            "dockerImageId": "",
            "dockerPull": "cgrlab/typeseqer:latest"
          }
        ],
        "sbg:validationErrors": [],
        "sbg:publisher": "sbg",
        "class": "CommandLineTool",
        "sbg:latestRevision": 1,
        "inputs": [],
        "temporaryFailCodes": [],
        "sbg:job": {
          "inputs": {},
          "allocatedResources": {
            "cpu": 1,
            "mem": 1000
          }
        },
        "sbg:revision": 1
      },
      "inputs": [],
      "id": "#illumina_typeseqer_hpv_reference",
      "sbg:y": 282.3197288886598
    },
    {
      "sbg:x": -191.70946084066048,
      "outputs": [
        {
          "id": "#BWA_INDEX.indexed_reference"
        }
      ],
      "run": {
        "sbg:license": "GNU Affero General Public License v3.0, MIT License",
        "sbg:sbgMaintained": false,
        "temporaryFailCodes": [],
        "baseCommand": [
          {
            "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar'){\n    return 'echo Index files passed without any processing!'\n  }\n  else{\n    index_cmd = 'bwa index '+ reference_file + ' '\n    return index_cmd\n  }\n}",
            "class": "Expression",
            "engine": "#cwl-js-engine"
          }
        ],
        "successCodes": [],
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "sbg:revisionNotes": "corrected bwa command line",
        "stdin": "",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:projectName": "cgrHPV",
        "id": "dave/cgrhpv/bwa-index/1",
        "sbg:toolAuthor": "Heng Li",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedOn": 1510550269,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "Copy of admin/sbg-public-data/bwa-index/33",
            "sbg:revision": 0
          },
          {
            "sbg:modifiedOn": 1520716437,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "corrected bwa command line",
            "sbg:revision": 1
          }
        ],
        "sbg:categories": [
          "Indexing",
          "FASTA-Processing"
        ],
        "sbg:cmdPreview": "bwa index reference.fasta   -a bwtsw      -6    ; tar -cf reference.fasta.tar reference.fasta *.amb *.ann *.bwt *.pac *.sa",
        "y": 217.91468969417403,
        "sbg:job": {
          "inputs": {
            "bwt_construction": "bwtsw",
            "prefix_of_the_index_to_be_output": "prefix",
            "add_64_to_fasta_name": true,
            "block_size": 0,
            "total_memory": null,
            "reference": {
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
              "class": "File",
              "size": 0,
              "path": "/path/to/the/reference.fasta"
            }
          },
          "allocatedResources": {
            "cpu": 1,
            "mem": 1536
          }
        },
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "sbg:modifiedBy": "dave",
        "sbg:links": [
          {
            "label": "Homepage",
            "id": "http://bio-bwa.sourceforge.net/"
          },
          {
            "label": "Source code",
            "id": "https://github.com/lh3/bwa"
          },
          {
            "label": "Wiki",
            "id": "http://bio-bwa.sourceforge.net/bwa.shtml"
          },
          {
            "label": "Download",
            "id": "http://sourceforge.net/projects/bio-bwa/"
          },
          {
            "label": "Publication",
            "id": "http://www.ncbi.nlm.nih.gov/pubmed/19451168"
          }
        ],
        "stdout": "",
        "sbg:id": "dave/cgrhpv/bwa-index/1",
        "sbg:toolkit": "BWA",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:createdOn": 1510550269,
        "outputs": [
          {
            "label": "TARed fasta with its BWA indices",
            "description": "TARed fasta with its BWA indices.",
            "outputBinding": {
              "sbg:metadata": {
                "reference": {
                  "script": "{\n  path = [].concat($job.inputs.reference)[0].path.split('/')\n  last = path.pop()\n  return last\n}",
                  "class": "Expression",
                  "engine": "#cwl-js-engine"
                }
              },
              "sbg:inheritMetadataFrom": "#reference",
              "glob": {
                "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar'){\n    return reference_file\n  }\n  else{\n    return reference_file + '.tar'\n  }\n}\n",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              }
            },
            "type": [
              "null",
              "File"
            ],
            "sbg:fileTypes": "TAR",
            "id": "#indexed_reference"
          }
        ],
        "inputs": [
          {
            "sbg:category": "Configuration",
            "label": "Total memory [Gb]",
            "description": "Total memory [GB] to be reserved for the tool (Default value is 1.5 x size_of_the_reference).",
            "type": [
              "null",
              "int"
            ],
            "id": "#total_memory"
          },
          {
            "label": "Reference",
            "description": "Input reference fasta of TAR file with reference and indices.",
            "type": [
              "File"
            ],
            "required": true,
            "sbg:category": "File input",
            "sbg:fileTypes": "FASTA,FA,FA.GZ,FASTA.GZ,TAR",
            "sbg:stageInput": "link",
            "id": "#reference"
          },
          {
            "sbg:category": "Configuration",
            "label": "Prefix of the index to be output",
            "description": "Prefix of the index [same as fasta name].",
            "type": [
              "null",
              "string"
            ],
            "id": "#prefix_of_the_index_to_be_output"
          },
          {
            "label": "Bwt construction",
            "description": "Algorithm for constructing BWT index. Available options are:s\tIS linear-time algorithm for constructing suffix array. It requires 5.37N memory where N is the size of the database. IS is moderately fast, but does not work with database larger than 2GB. IS is the default algorithm due to its simplicity. The current codes for IS algorithm are reimplemented by Yuta Mori. bwtsw\tAlgorithm implemented in BWT-SW. This method works with the whole human genome. Warning: `-a bwtsw' does not work for short genomes, while `-a is' and `-a div' do not work not for long genomes.",
            "type": [
              "null",
              {
                "type": "enum",
                "name": "bwt_construction",
                "symbols": [
                  "bwtsw",
                  "is",
                  "div"
                ]
              }
            ],
            "sbg:category": "Configuration",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-a",
              "separate": true
            },
            "sbg:toolDefaultValue": "auto",
            "id": "#bwt_construction"
          },
          {
            "label": "Block size",
            "description": "Block size for the bwtsw algorithm (effective with -a bwtsw).",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Configuration",
            "sbg:toolDefaultValue": "10000000",
            "id": "#block_size"
          },
          {
            "sbg:category": "Configuration",
            "label": "Output index files renamed by adding 64",
            "description": "Index files named as <in.fasta>64 instead of <in.fasta>.*.",
            "type": [
              "null",
              "boolean"
            ],
            "id": "#add_64_to_fasta_name"
          }
        ],
        "class": "CommandLineTool",
        "description": "BWA INDEX constructs the FM-index (Full-text index in Minute space) for the reference genome.\nGenerated index files will be used with BWA MEM, BWA ALN, BWA SAMPE and BWA SAMSE tools.\n\nIf input reference file has TAR extension it is assumed that BWA indices came together with it. BWA INDEX will only pass that TAR to the output. If input is not TAR, the creation of BWA indices and its packing in TAR file (together with the reference) will be performed.",
        "sbg:project": "dave/cgrhpv",
        "sbg:createdBy": "dave",
        "cwlVersion": "sbg:draft-2",
        "label": "BWA INDEX",
        "arguments": [
          {
            "valueFrom": {
              "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar' || !$job.inputs.bwt_construction){\n    return ''\n  } else {\n    return '-a ' + $job.inputs.bwt_construction\n  }\n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "separate": true
          },
          {
            "valueFrom": {
              "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar' || !$job.inputs.prefix){\n    return ''\n  } else {\n    return '-p ' + $job.inputs.prefix\n  }\n}\n",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "separate": true
          },
          {
            "valueFrom": {
              "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar' || !$job.inputs.block_size){\n    return ''\n  } else {\n    return '-b ' + $job.inputs.block_size\n  }\n}\n\n",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "separate": true
          },
          {
            "valueFrom": {
              "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar' || !$job.inputs.add_64_to_fasta_name){\n    return ''\n  } else {\n    return '-6 '\n  }\n}\n",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "separate": true
          },
          {
            "valueFrom": {
              "script": "{\n  reference_file = $job.inputs.reference.path.split('/')[$job.inputs.reference.path.split('/').length-1]\n  ext = reference_file.split('.')[reference_file.split('.').length-1]\n  if(ext=='tar'){\n    return ''\n  }\n  else{\n    tar_cmd = 'tar -cf ' + reference_file + '.tar ' + reference_file + ' *.amb' + ' *.ann' + ' *.bwt' + ' *.pac' + ' *.sa' \n    return ' ; ' + tar_cmd\n  }\n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "separate": true
          }
        ],
        "x": -191.70946084066048,
        "hints": [
          {
            "class": "DockerRequirement",
            "dockerImageId": "2f813371e803",
            "dockerPull": "cgrlab/typeseqer:latest"
          },
          {
            "class": "sbg:CPURequirement",
            "value": 1
          },
          {
            "class": "sbg:MemRequirement",
            "value": {
              "script": "{\n  GB_1 = 1024*1024*1024\n  reads_size = $job.inputs.reference.size\n\n  if(!reads_size) { reads_size = GB_1 }\n  \n  if($job.inputs.total_memory){\n    return $job.inputs.total_memory * 1024\n  } else {\n    return (parseInt(1.5 * reads_size / (1024*1024)))\n  }\n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            }
          }
        ],
        "sbg:validationErrors": [],
        "sbg:publisher": "sbg",
        "sbg:latestRevision": 1,
        "sbg:modifiedOn": 1520716437,
        "sbg:image_url": null,
        "sbg:toolkitVersion": "0.7.13",
        "sbg:revision": 1
      },
      "inputs": [
        {
          "id": "#BWA_INDEX.total_memory"
        },
        {
          "source": [
            "#illumina_typeseqer_hpv_reference.typing_reference"
          ],
          "id": "#BWA_INDEX.reference"
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
      "id": "#BWA_INDEX",
      "sbg:y": 217.91468969417403
    },
    {
      "sbg:x": -40.944682963278815,
      "outputs": [
        {
          "id": "#BWA_MEM_Bundle.aligned_reads"
        }
      ],
      "run": {
        "sbg:license": "BWA: GNU Affero General Public License v3.0, MIT License. Sambamba: GNU GENERAL PUBLIC LICENSE. Samblaster: The MIT License (MIT)",
        "sbg:sbgMaintained": false,
        "description": "**BWA MEM** is an algorithm designed for aligning sequence reads onto a large reference genome. BWA MEM is implemented as a component of BWA. The algorithm can automatically choose between performing end-to-end and local alignments. BWA MEM is capable of outputting multiple alignments, and finding chimeric reads. It can be applied to a wide range of read lengths, from 70 bp to several megabases. \n\nIn order to obtain possibilities for additional fast processing of aligned reads, two tools are embedded together into the same package with BWA MEM (0.7.13): Samblaster. (0.1.22) and Sambamba (v0.6.0). \nIf deduplication of alignments is needed, it can be done by setting the parameter 'Duplication'. **Samblaster** will be used internally to perform this action.\nBesides the standard BWA MEM SAM output file, BWA MEM package has been extended to support two additional output options: a BAM file obtained by piping through **Sambamba view** while filtering out the secondary alignments, as well as a Coordinate Sorted BAM option that additionally pipes the output through **Sambamba sort**, along with an accompanying .bai file produced by **Sambamba sort** as side effect. Parameters responsible for these additional features are 'Filter out secondary alignments' and 'Output format'. Passing data from BWA MEM to Samblaster and Sambamba tools has been done through the pipes which saves processing times of two read and write of aligned reads into the hard drive. \n\nFor input reads fastq files of total size less than 10 GB we suggest using the default setting for parameter 'total memory' of 15GB, for larger files we suggest using 58 GB of memory and 32 CPU cores.\n\n**Important:**\nIn order to work BWA MEM Bundle requires fasta reference file accompanied with **bwa fasta indices** in TAR file.\nThere is the **known issue** with samblaster. It does not support processing when number of sequences in fasta is larger than 32768. If this is the case do not use deduplication option because the output BAM will be corrupted.",
        "baseCommand": [
          {
            "script": "{\n  reference_file = $job.inputs.reference_index_tar.path.split('/')[$job.inputs.reference_index_tar.path.split('/').length-1]\n  return 'tar -xf ' + reference_file + ' ; '\n  \n}",
            "class": "Expression",
            "engine": "#cwl-js-engine"
          },
          "bwa",
          "mem"
        ],
        "successCodes": [],
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "sbg:revisionNotes": "removed samblaster",
        "stdin": "",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:projectName": "cgrHPV",
        "id": "dave/cgrhpv/bwa-mem-bundle-0-7-13/49",
        "sbg:toolAuthor": "Heng Li",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedOn": 1481059586,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "Copy of admin/sbg-public-data/bwa-mem-bundle-0-7-13/58",
            "sbg:revision": 0
          },
          {
            "sbg:modifiedOn": 1481068904,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 1
          },
          {
            "sbg:modifiedOn": 1481115815,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 2
          },
          {
            "sbg:modifiedOn": 1481116098,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 3
          },
          {
            "sbg:modifiedOn": 1481116150,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 4
          },
          {
            "sbg:modifiedOn": 1481116184,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 5
          },
          {
            "sbg:modifiedOn": 1481116736,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 6
          },
          {
            "sbg:modifiedOn": 1481116889,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 7
          },
          {
            "sbg:modifiedOn": 1481117045,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 8
          },
          {
            "sbg:modifiedOn": 1481117410,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 9
          },
          {
            "sbg:modifiedOn": 1481117480,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 10
          },
          {
            "sbg:modifiedOn": 1481117704,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 11
          },
          {
            "sbg:modifiedOn": 1481117793,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 12
          },
          {
            "sbg:modifiedOn": 1481117834,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 13
          },
          {
            "sbg:modifiedOn": 1481117908,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 14
          },
          {
            "sbg:modifiedOn": 1481118226,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 15
          },
          {
            "sbg:modifiedOn": 1481119589,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 16
          },
          {
            "sbg:modifiedOn": 1481134488,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 17
          },
          {
            "sbg:modifiedOn": 1481136278,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 18
          },
          {
            "sbg:modifiedOn": 1481136522,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "fixed index",
            "sbg:revision": 19
          },
          {
            "sbg:modifiedOn": 1486399352,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added index output so the index will have metadata",
            "sbg:revision": 20
          },
          {
            "sbg:modifiedOn": 1510169598,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "removed -z",
            "sbg:revision": 21
          },
          {
            "sbg:modifiedOn": 1510169613,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 22
          },
          {
            "sbg:modifiedOn": 1510172078,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "correcting fasta index command",
            "sbg:revision": 23
          },
          {
            "sbg:modifiedOn": 1510173055,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "removed some extra commands",
            "sbg:revision": 24
          },
          {
            "sbg:modifiedOn": 1510173207,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "putting commands back in",
            "sbg:revision": 25
          },
          {
            "sbg:modifiedOn": 1520373672,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "remove pipe thing",
            "sbg:revision": 26
          },
          {
            "sbg:modifiedOn": 1520373846,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "removed pipe commands at end",
            "sbg:revision": 27
          },
          {
            "sbg:modifiedOn": 1520390878,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "test tar command",
            "sbg:revision": 28
          },
          {
            "sbg:modifiedOn": 1520391724,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 29
          },
          {
            "sbg:modifiedOn": 1520394654,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 30
          },
          {
            "sbg:modifiedOn": 1520396075,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "back to version 0",
            "sbg:revision": 31
          },
          {
            "sbg:modifiedOn": 1520396726,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 32
          },
          {
            "sbg:modifiedOn": 1520396832,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 33
          },
          {
            "sbg:modifiedOn": 1520432818,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 34
          },
          {
            "sbg:modifiedOn": 1520448507,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 35
          },
          {
            "sbg:modifiedOn": 1520449475,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added and ending quote",
            "sbg:revision": 36
          },
          {
            "sbg:modifiedOn": 1520450271,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "on tar an bwa",
            "sbg:revision": 37
          },
          {
            "sbg:modifiedOn": 1520450849,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "moved args around",
            "sbg:revision": 38
          },
          {
            "sbg:modifiedOn": 1520451230,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 39
          },
          {
            "sbg:modifiedOn": 1520454117,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "aligned.bam",
            "sbg:revision": 40
          },
          {
            "sbg:modifiedOn": 1520457400,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "put many commands back in",
            "sbg:revision": 41
          },
          {
            "sbg:modifiedOn": 1520458438,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "back to version 0",
            "sbg:revision": 42
          },
          {
            "sbg:modifiedOn": 1520458702,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 43
          },
          {
            "sbg:modifiedOn": 1520513938,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "back to version 0",
            "sbg:revision": 44
          },
          {
            "sbg:modifiedOn": 1520715570,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "changed docker and some cmd lines to typeseqer",
            "sbg:revision": 45
          },
          {
            "sbg:modifiedOn": 1520715973,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "corrected sambamba command line",
            "sbg:revision": 46
          },
          {
            "sbg:modifiedOn": 1520716775,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "fixing sambamba command line",
            "sbg:revision": 47
          },
          {
            "sbg:modifiedOn": 1520740992,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 48
          },
          {
            "sbg:modifiedOn": 1520741385,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "removed samblaster",
            "sbg:revision": 49
          }
        ],
        "sbg:categories": [
          "Alignment",
          "FASTQ-Processing"
        ],
        "sbg:cmdPreview": "tar -xf reference.b37.fasta.gz.tar ;  bwa mem  -R '@RG\\tID:1' -t 8  reference.b37.fasta.gz  /path/to/LP6005524-DNA_C01_lane_7.sorted.converted.filtered.pe_1.gz /path/to/LP6005524-DNA_C01_lane_7.sorted.converted.filtered.pe_2.gz | /sambamba_v0.6.6 view -t 8 --filter 'not secondary_alignment' -f bam -l 0 -S /dev/stdin | /sambamba_v0.6.6 sort -t 8 -m 32GiB --tmpdir ./ -o LP6005524-DNA_C01_lane_7.sorted.converted.filtered.bam -l 5 /dev/stdin",
        "y": 303.4675358868678,
        "sbg:job": {
          "inputs": {
            "rg_median_fragment_length": "",
            "threads": 8,
            "rg_data_submitting_center": "",
            "filter_out_secondary_alignments": true,
            "skip_seeds": null,
            "deduplication": "MarkDuplicates",
            "output_format": "SortedBAM",
            "band_width": null,
            "rg_sample_id": "",
            "rg_platform_unit_id": "",
            "rg_platform": null,
            "sort_memory": 32,
            "input_reads": [
              {
                "secondaryFiles": [],
                "class": "File",
                "size": 30000000000,
                "path": "/path/to/LP6005524-DNA_C01_lane_7.sorted.converted.filtered.pe_1.gz"
              },
              {
                "secondaryFiles": [],
                "path": "/path/to/LP6005524-DNA_C01_lane_7.sorted.converted.filtered.pe_2.gz"
              }
            ],
            "rg_library_id": "",
            "read_group_header": "",
            "output_name": "",
            "reference_index_tar": {
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
              "class": "File",
              "size": 0,
              "path": "/path/to/reference.b37.fasta.gz.tar"
            },
            "sambamba_threads": 8,
            "total_memory": 58,
            "reserved_threads": 3
          },
          "allocatedResources": {
            "cpu": 8,
            "mem": 16000
          }
        },
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "sbg:modifiedBy": "dave",
        "sbg:links": [
          {
            "label": "Homepage",
            "id": "http://bio-bwa.sourceforge.net/"
          },
          {
            "label": "Source code",
            "id": "https://github.com/lh3/bwa"
          },
          {
            "label": "Wiki",
            "id": "http://bio-bwa.sourceforge.net/bwa.shtml"
          },
          {
            "label": "Download",
            "id": "http://sourceforge.net/projects/bio-bwa/"
          },
          {
            "label": "Publication",
            "id": "http://arxiv.org/abs/1303.3997"
          },
          {
            "label": "Publication BWA Algorithm",
            "id": "http://www.ncbi.nlm.nih.gov/pubmed/19451168"
          }
        ],
        "stdout": "",
        "sbg:id": "dave/cgrhpv/bwa-mem-bundle-0-7-13/49",
        "sbg:toolkit": "BWA",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:createdOn": 1481059586,
        "outputs": [
          {
            "label": "Aligned SAM/BAM",
            "description": "Aligned reads.",
            "outputBinding": {
              "secondaryFiles": [
                ".bai",
                "^.bai"
              ],
              "sbg:metadata": {
                "reference_genome": {
                  "script": "{\n  reference_file = $job.inputs.reference_index_tar.path.split('/')[$job.inputs.reference_index_tar.path.split('/').length-1]\n  name = reference_file.slice(0, -4) // cut .tar extension \n  \n  name_list = name.split('.')\n  ext = name_list[name_list.length-1]\n\n  if (ext == 'gz' || ext == 'GZ'){\n    a = name_list.pop() // strip fasta.gz\n    a = name_list.pop()\n  } else\n    a = name_list.pop() //strip only fasta/fa\n  \n  return name_list.join('.')\n  \n}",
                  "class": "Expression",
                  "engine": "#cwl-js-engine"
                }
              },
              "sbg:inheritMetadataFrom": "#input_reads",
              "glob": "{*.sam,*.bam}"
            },
            "type": [
              "null",
              "File"
            ],
            "sbg:fileTypes": "SAM, BAM",
            "id": "#aligned_reads"
          }
        ],
        "inputs": [
          {
            "label": "Verbose level",
            "description": "Verbose level: 1=error, 2=warning, 3=message, 4+=debugging.",
            "type": [
              "null",
              {
                "type": "enum",
                "name": "verbose_level",
                "symbols": [
                  "1",
                  "2",
                  "3",
                  "4"
                ]
              }
            ],
            "sbg:category": "BWA Input/output options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-v",
              "separate": true
            },
            "sbg:toolDefaultValue": "3",
            "id": "#verbose_level"
          },
          {
            "label": "Use soft clipping",
            "description": "Use soft clipping for supplementary alignments.",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-Y",
              "separate": true
            },
            "id": "#use_soft_clipping"
          },
          {
            "label": "Unpaired read penalty",
            "description": "Penalty for an unpaired read pair.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Scoring options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-U",
              "separate": true
            },
            "sbg:toolDefaultValue": "17",
            "id": "#unpaired_read_penalty"
          },
          {
            "label": "Total memory",
            "description": "Total memory to be used by the tool in GB. It's sum of BWA, Sambamba Sort and Samblaster. For fastq files of total size less than 10GB, we suggest using the default setting of 15GB, for larger files we suggest using 58GB of memory (and 32CPU cores).",
            "type": [
              "null",
              "int"
            ],
            "sbg:stageInput": null,
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "15",
            "id": "#total_memory"
          },
          {
            "label": "Threads",
            "description": "Number of threads for BWA, Samblaster and Sambamba sort process.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "8",
            "id": "#threads"
          },
          {
            "label": "Specify distribution parameters",
            "description": "Specify the mean, standard deviation (10% of the mean if absent), max (4 sigma from the mean if absent) and min of the insert size distribution.FR orientation only. This array can have maximum four values, where first two should be specified as FLOAT and last two as INT.",
            "type": [
              "null",
              {
                "items": "float",
                "type": "array",
                "name": "speficy_distribution_parameters"
              }
            ],
            "sbg:category": "BWA Input/output options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-I",
              "itemSeparator": null,
              "separate": false
            },
            "id": "#speficy_distribution_parameters"
          },
          {
            "sbg:category": "Execution",
            "label": "Memory for BAM sorting",
            "description": "Amount of RAM [Gb] to give to the sorting algorithm (if not provided will be set to one third of the total memory).",
            "type": [
              "null",
              "int"
            ],
            "id": "#sort_memory"
          },
          {
            "label": "Smart pairing in input FASTQ file",
            "description": "Smart pairing in input FASTQ file (ignoring in2.fq).",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-p",
              "separate": true
            },
            "id": "#smart_pairing_in_input_fastq"
          },
          {
            "label": "Skip seeds with more than INT occurrences",
            "description": "Skip seeds with more than INT occurrences.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Algorithm options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-c",
              "separate": true
            },
            "sbg:toolDefaultValue": "500",
            "id": "#skip_seeds"
          },
          {
            "label": "Skip pairing",
            "description": "Skip pairing; mate rescue performed unless -S also in use.",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Algorithm options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-P",
              "separate": true
            },
            "id": "#skip_pairing"
          },
          {
            "label": "Skip mate rescue",
            "description": "Skip mate rescue.",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Algorithm options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-S",
              "separate": true
            },
            "id": "#skip_mate_rescue"
          },
          {
            "label": "Select seeds",
            "description": "Look for internal seeds inside a seed longer than {-k} * FLOAT.",
            "type": [
              "null",
              "float"
            ],
            "sbg:category": "BWA Algorithm options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-r",
              "separate": true
            },
            "sbg:toolDefaultValue": "1.5",
            "id": "#select_seeds"
          },
          {
            "label": "Seed occurrence for the 3rd round",
            "description": "Seed occurrence for the 3rd round seeding.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Algorithm options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-y",
              "separate": true
            },
            "sbg:toolDefaultValue": "20",
            "id": "#seed_occurrence_for_the_3rd_round"
          },
          {
            "label": "Score for a sequence match",
            "description": "Score for a sequence match, which scales options -TdBOELU unless overridden.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Scoring options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-A",
              "separate": true
            },
            "sbg:toolDefaultValue": "1",
            "id": "#score_for_a_sequence_match"
          },
          {
            "sbg:category": "Execution",
            "label": "Sambamba Sort threads",
            "description": "Number of threads to pass to Sambamba sort, if used.",
            "type": [
              "null",
              "int"
            ],
            "id": "#sambamba_threads"
          },
          {
            "label": "Sample ID",
            "description": "Specify the sample ID for RG line - A human readable identifier for a sample or specimen, which could contain some metadata information. A sample or specimen is material taken from a biological entity for testing, diagnosis, propagation, treatment, or research purposes, including but not limited to tissues, body fluids, cells, organs, embryos, body excretory products, etc.",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Read Group Options",
            "sbg:toolDefaultValue": "Inferred from metadata",
            "id": "#rg_sample_id"
          },
          {
            "label": "Platform unit ID",
            "description": "Specify the platform unit (lane/slide) for RG line - An identifier for lanes (Illumina), or for slides (SOLiD) in the case that a library was split and ran over multiple lanes on the flow cell or slides.",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Read Group Options",
            "sbg:toolDefaultValue": "Inferred from metadata",
            "id": "#rg_platform_unit_id"
          },
          {
            "label": "Platform",
            "description": "Specify the version of the technology that was used for sequencing, which will be placed in RG line.",
            "type": [
              "null",
              {
                "type": "enum",
                "name": "rg_platform",
                "symbols": [
                  "454",
                  "Helicos",
                  "Illumina",
                  "Solid",
                  "IonTorrent"
                ]
              }
            ],
            "sbg:category": "BWA Read Group Options",
            "sbg:toolDefaultValue": "Inferred from metadata",
            "id": "#rg_platform"
          },
          {
            "sbg:category": "BWA Read Group Options",
            "label": "Median fragment length",
            "description": "Specify the median fragment length for RG line.",
            "type": [
              "null",
              "string"
            ],
            "id": "#rg_median_fragment_length"
          },
          {
            "label": "Library ID",
            "description": "Specify the identifier for the sequencing library preparation, which will be placed in RG line.",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Read Group Options",
            "sbg:toolDefaultValue": "Inferred from metadata",
            "id": "#rg_library_id"
          },
          {
            "sbg:category": "BWA Read Group Options",
            "label": "Data submitting center",
            "description": "Specify the data submitting center for RG line.",
            "type": [
              "null",
              "string"
            ],
            "id": "#rg_data_submitting_center"
          },
          {
            "label": "Reserved number of threads on the instance",
            "description": "Reserved number of threads on the instance used by scheduler.",
            "type": [
              "null",
              "int"
            ],
            "sbg:stageInput": null,
            "sbg:category": "Configuration",
            "sbg:toolDefaultValue": "1",
            "id": "#reserved_threads"
          },
          {
            "label": "Reference Index TAR",
            "description": "Reference fasta file with BWA index files packed in TAR.",
            "type": [
              "File"
            ],
            "required": true,
            "sbg:category": "Input files",
            "sbg:fileTypes": "TAR",
            "sbg:stageInput": "link",
            "id": "#reference_index_tar"
          },
          {
            "label": "Sequencing technology-specific settings",
            "description": "Sequencing technology-specific settings; Setting -x changes multiple parameters unless overriden. pacbio: -k17 -W40 -r10 -A1 -B1 -O1 -E1 -L0  (PacBio reads to ref). ont2d: -k14 -W20 -r10 -A1 -B1 -O1 -E1 -L0  (Oxford Nanopore 2D-reads to ref). intractg: -B9 -O16 -L5  (intra-species contigs to ref).",
            "type": [
              "null",
              {
                "type": "enum",
                "name": "read_type",
                "symbols": [
                  "pacbio",
                  "ont2d",
                  "intractg"
                ]
              }
            ],
            "sbg:category": "BWA Scoring options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-x",
              "separate": true
            },
            "id": "#read_type"
          },
          {
            "label": "Read group header",
            "description": "Read group header line such as '@RG\\tID:foo\\tSM:bar'.  This value takes precedence over per-attribute parameters.",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Read Group Options",
            "sbg:toolDefaultValue": "Constructed from per-attribute parameters or inferred from metadata.",
            "id": "#read_group_header"
          },
          {
            "sbg:category": "Configuration",
            "label": "Output SAM/BAM file name",
            "description": "Name of the output BAM file.",
            "type": [
              "null",
              "string"
            ],
            "id": "#output_name"
          },
          {
            "label": "Output in XA",
            "description": "If there are <INT hits with score >80% of the max score, output all in XA. This array should have no more than two values.",
            "type": [
              "null",
              {
                "items": "int",
                "type": "array"
              }
            ],
            "sbg:category": "BWA Input/output options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-h",
              "itemSeparator": ",",
              "separate": false
            },
            "sbg:toolDefaultValue": "[5, 200]",
            "id": "#output_in_xa"
          },
          {
            "label": "Output header",
            "description": "Output the reference FASTA header in the XR tag.",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-V",
              "separate": true
            },
            "id": "#output_header"
          },
          {
            "label": "Output format",
            "description": "Specify output format (Sorted BAM option will output coordinate sorted BAM).",
            "type": [
              "null",
              {
                "type": "enum",
                "name": "output_format",
                "symbols": [
                  "SAM",
                  "BAM",
                  "SortedBAM"
                ]
              }
            ],
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "SortedBAM",
            "id": "#output_format"
          },
          {
            "label": "Output alignments",
            "description": "Output all alignments for SE or unpaired PE.",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-a",
              "separate": true
            },
            "id": "#output_alignments"
          },
          {
            "label": "Mismatch penalty",
            "description": "Penalty for a mismatch.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Scoring options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-B",
              "separate": true
            },
            "sbg:toolDefaultValue": "4",
            "id": "#mismatch_penalty"
          },
          {
            "label": "Minimum seed length",
            "description": "Minimum seed length for BWA MEM.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Algorithm options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-k",
              "separate": true
            },
            "sbg:toolDefaultValue": "19",
            "id": "#minimum_seed_length"
          },
          {
            "label": "Minimum alignment score for a read to be output in SAM/BAM",
            "description": "Minimum alignment score for a read to be output in SAM/BAM.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Input/output options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-T",
              "separate": true
            },
            "sbg:toolDefaultValue": "30",
            "id": "#minimum_output_score"
          },
          {
            "label": "Mate rescue rounds",
            "description": "Perform at most INT rounds of mate rescues for each read.",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Algorithm options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-m",
              "separate": true
            },
            "sbg:toolDefaultValue": "50",
            "id": "#mate_rescue_rounds"
          },
          {
            "label": "Mark shorter",
            "description": "Mark shorter split hits as secondary.",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-M",
              "separate": true
            },
            "id": "#mark_shorter"
          },
          {
            "label": "Insert string to output SAM or BAM header",
            "description": "Insert STR to header if it starts with @; or insert lines in FILE.",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "BWA Input/output options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-H",
              "separate": true
            },
            "id": "#insert_string_to_header"
          },
          {
            "label": "Input reads",
            "description": "Input sequence reads.",
            "type": [
              {
                "items": "File",
                "type": "array",
                "name": "input_reads"
              }
            ],
            "required": true,
            "sbg:category": "Input files",
            "sbg:fileTypes": "FASTQ, FASTQ.GZ, FQ, FQ.GZ",
            "id": "#input_reads"
          },
          {
            "label": "Ignore ALT file",
            "description": "Treat ALT contigs as part of the primary assembly (i.e. ignore <idxbase>.alt file).",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-j",
              "separate": true
            },
            "id": "#ignore_alt_file"
          },
          {
            "label": "Gap open penalties",
            "description": "Gap open penalties for deletions and insertions. This array can't have more than two values.",
            "type": [
              "null",
              {
                "items": "int",
                "type": "array"
              }
            ],
            "sbg:category": "BWA Scoring options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-O",
              "itemSeparator": ",",
              "separate": false
            },
            "sbg:toolDefaultValue": "[6,6]",
            "id": "#gap_open_penalties"
          },
          {
            "label": "Gap extension",
            "description": "Gap extension penalty; a gap of size k cost '{-O} + {-E}*k'. This array can't have more than two values.",
            "type": [
              "null",
              {
                "items": "int",
                "type": "array"
              }
            ],
            "sbg:category": "BWA Scoring options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-E",
              "itemSeparator": ",",
              "separate": false
            },
            "sbg:toolDefaultValue": "[1,1]",
            "id": "#gap_extension_penalties"
          },
          {
            "label": "Filter out secondary alignments",
            "description": "Filter out secondary alignments. Sambamba view tool will be used to perform this internally.",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:stageInput": null,
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "False",
            "id": "#filter_out_secondary_alignments"
          },
          {
            "label": "Dropoff",
            "description": "Off-diagonal X-dropoff.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Algorithm options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-d",
              "separate": true
            },
            "sbg:toolDefaultValue": "100",
            "id": "#dropoff"
          },
          {
            "label": "Drop chains fraction",
            "description": "Drop chains shorter than FLOAT fraction of the longest overlapping chain.",
            "type": [
              "null",
              "float"
            ],
            "sbg:category": "BWA Algorithm options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-D",
              "separate": true
            },
            "sbg:toolDefaultValue": "0.50",
            "id": "#drop_chains_fraction"
          },
          {
            "label": "Discard exact matches",
            "description": "Discard full-length exact matches.",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Algorithm options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-e",
              "separate": true
            },
            "id": "#discard_exact_matches"
          },
          {
            "label": "Discard chain length",
            "description": "Discard a chain if seeded bases shorter than INT.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Algorithm options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-W",
              "separate": true
            },
            "sbg:toolDefaultValue": "0",
            "id": "#discard_chain_length"
          },
          {
            "label": "PCR duplicate detection",
            "description": "Use Samblaster for finding duplicates on sequence reads.",
            "type": [
              "null",
              {
                "type": "enum",
                "name": "deduplication",
                "symbols": [
                  "None",
                  "MarkDuplicates",
                  "RemoveDuplicates"
                ]
              }
            ],
            "sbg:category": "Samblaster parameters",
            "sbg:toolDefaultValue": "MarkDuplicates",
            "id": "#deduplication"
          },
          {
            "label": "Clipping penalty",
            "description": "Penalty for 5'- and 3'-end clipping.",
            "type": [
              "null",
              {
                "items": "int",
                "type": "array"
              }
            ],
            "sbg:category": "BWA Scoring options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-L",
              "itemSeparator": ",",
              "separate": false
            },
            "sbg:toolDefaultValue": "[5,5]",
            "id": "#clipping_penalty"
          },
          {
            "label": "Band width",
            "description": "Band width for banded alignment.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "BWA Algorithm options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-w",
              "separate": true
            },
            "sbg:toolDefaultValue": "100",
            "id": "#band_width"
          },
          {
            "label": "Append comment",
            "description": "Append FASTA/FASTQ comment to SAM output.",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "BWA Input/output options",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "-C",
              "separate": true
            },
            "id": "#append_comment"
          }
        ],
        "sbg:image_url": null,
        "sbg:project": "dave/cgrhpv",
        "sbg:createdBy": "dave",
        "cwlVersion": "sbg:draft-2",
        "label": "BWA MEM Bundle",
        "arguments": [
          {
            "position": 111,
            "valueFrom": {
              "script": "{  ///  SAMBAMBA VIEW   //////////////////////\n   ///////////////////////////////////////////\nfunction common_substring(a,b) {\n  var i = 0;\n  \n  while(a[i] === b[i] && i < a.length)\n  {\n    i = i + 1;\n  }\n\n  return a.slice(0, i);\n}\n  \n   // Set output file name\n  if($job.inputs.input_reads[0] instanceof Array){\n    input_1 = $job.inputs.input_reads[0][0] // scatter mode\n    input_2 = $job.inputs.input_reads[0][1]\n  } else if($job.inputs.input_reads instanceof Array){\n    input_1 = $job.inputs.input_reads[0]\n    input_2 = $job.inputs.input_reads[1]\n  }else {\n    input_1 = [].concat($job.inputs.input_reads)[0]\n    input_2 = input_1\n  }\n  full_name = input_1.path.split('/')[input_1.path.split('/').length-1] \n\n  if($job.inputs.output_name){name = $job.inputs.output_name }\n  else if ($job.inputs.input_reads.length == 1){ \n    name = full_name\n\n    if(name.slice(-3, name.length) === '.gz' || name.slice(-3, name.length) === '.GZ')\n      name = name.slice(0, -3)   \n    if(name.slice(-3, name.length) === '.fq' || name.slice(-3, name.length) === '.FQ')\n      name = name.slice(0, -3)\n    if(name.slice(-6, name.length) === '.fastq' || name.slice(-6, name.length) === '.FASTQ')\n      name = name.slice(0, -6)\n       \n  }else{\n    full_name2 = input_2.path.split('/')[input_2.path.split('/').length-1] \n    name = common_substring(full_name, full_name2)\n    \n    if(name.slice(-1, name.length) === '_' || name.slice(-1, name.length) === '.')\n      name = name.slice(0, -1)\n    if(name.slice(-2, name.length) === 'p_' || name.slice(-1, name.length) === 'p.')\n      name = name.slice(0, -2)\n    if(name.slice(-2, name.length) === 'P_' || name.slice(-1, name.length) === 'P.')\n      name = name.slice(0, -2)\n    if(name.slice(-3, name.length) === '_p_' || name.slice(-3, name.length) === '.p.')\n      name = name.slice(0, -3)\n    if(name.slice(-3, name.length) === '_pe' || name.slice(-3, name.length) === '.pe')\n      name = name.slice(0, -3)\n  }\n  \n  // Read number of threads if defined\n  if ($job.inputs.sambamba_threads){\n    threads = $job.inputs.sambamba_threads\n  }\n  else if ($job.inputs.threads){\n    threads = $job.inputs.threads\n  }\n  else { threads = 8 }\n  \n  if ($job.inputs.filter_out_secondary_alignments){\n    filt_sec = ' --filter \\'not secondary_alignment\\' '\n  }\n  else {filt_sec=' '}\n   \n  // Set output command\n  sambamba_path = '/sambamba_v0.6.6'\n  if ($job.inputs.output_format == 'BAM') {\n    return \"| \" + sambamba_path + \" view -t \"+ threads + filt_sec + \"-f bam -S /dev/stdin -o \"+ name + \".bam\"\n  }\n  else if ($job.inputs.output_format == 'SAM'){ // SAM\n    return \"> \" + name + \".sam\"\n  }\n  else { // SortedBAM is considered default\n    return \"| \" + sambamba_path + \" view -t \"+ threads + filt_sec + \"-f bam -l 0 -S /dev/stdin\"\n  }\n\n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "separate": false,
            "prefix": ""
          },
          {
            "position": 112,
            "valueFrom": {
              "script": "{ ///  SAMBAMBA SORT   //////////////////////\n///////////////////////////////////////////\n  \nfunction common_substring(a,b) {\n  var i = 0;\n  while(a[i] === b[i] && i < a.length)\n  {\n    i = i + 1;\n  }\n\n  return a.slice(0, i);\n}\n\n   // Set output file name\n  if($job.inputs.input_reads[0] instanceof Array){\n    input_1 = $job.inputs.input_reads[0][0] // scatter mode\n    input_2 = $job.inputs.input_reads[0][1]\n  } else if($job.inputs.input_reads instanceof Array){\n    input_1 = $job.inputs.input_reads[0]\n    input_2 = $job.inputs.input_reads[1]\n  }else {\n    input_1 = [].concat($job.inputs.input_reads)[0]\n    input_2 = input_1\n  }\n  full_name = input_1.path.split('/')[input_1.path.split('/').length-1] \n  \n  if($job.inputs.output_name){name = $job.inputs.output_name }\n  else if ($job.inputs.input_reads.length == 1){\n    name = full_name\n    if(name.slice(-3, name.length) === '.gz' || name.slice(-3, name.length) === '.GZ')\n      name = name.slice(0, -3)   \n    if(name.slice(-3, name.length) === '.fq' || name.slice(-3, name.length) === '.FQ')\n      name = name.slice(0, -3)\n    if(name.slice(-6, name.length) === '.fastq' || name.slice(-6, name.length) === '.FASTQ')\n      name = name.slice(0, -6)\n       \n  }else{\n    full_name2 = input_2.path.split('/')[input_2.path.split('/').length-1] \n    name = common_substring(full_name, full_name2)\n    \n    if(name.slice(-1, name.length) === '_' || name.slice(-1, name.length) === '.')\n      name = name.slice(0, -1)\n    if(name.slice(-2, name.length) === 'p_' || name.slice(-1, name.length) === 'p.')\n      name = name.slice(0, -2)\n    if(name.slice(-2, name.length) === 'P_' || name.slice(-1, name.length) === 'P.')\n      name = name.slice(0, -2)\n    if(name.slice(-3, name.length) === '_p_' || name.slice(-3, name.length) === '.p.')\n      name = name.slice(0, -3)\n    if(name.slice(-3, name.length) === '_pe' || name.slice(-3, name.length) === '.pe')\n      name = name.slice(0, -3)\n  }\n\n  //////////////////////////\n  // Set sort memory size\n  \n  reads_size = 0 // Not used because of situations when size does not exist!\n  GB_1 = 1024*1024*1024\n  if(reads_size < GB_1){ \n    suggested_memory = 4\n    suggested_cpus = 1\n  }\n  else if(reads_size < 10 * GB_1){ \n    suggested_memory = 15\n    suggested_cpus = 8\n  }\n  else { \n    suggested_memory = 58 \n    suggested_cpus = 31\n  }\n  \n  \n  if(!$job.inputs.total_memory){ total_memory = suggested_memory }\n  else{ total_memory = $job.inputs.total_memory }\n\n  // TODO:Rough estimation, should be fine-tuned!\n  if(total_memory > 16){ sorter_memory = parseInt(total_memory / 3) }\n  else{ sorter_memory = 5 }\n          \n  if ($job.inputs.sort_memory){\n    sorter_memory_string = $job.inputs.sort_memory +'GiB'\n  }\n  else sorter_memory_string = sorter_memory + 'GiB' \n  \n  // Read number of threads if defined  \n  if ($job.inputs.sambamba_threads){\n    threads = $job.inputs.sambamba_threads\n  }\n  else if ($job.inputs.threads){\n    threads = $job.inputs.threads\n  }\n  else threads = suggested_cpus\n  \n  sambamba_path = '/sambamba_v0.6.6'\n  \n  // SortedBAM is considered default\n  if (!(($job.inputs.output_format == 'BAM') || ($job.inputs.output_format == 'SAM'))){\n    cmd = \"| \" + sambamba_path + \" sort -t \" + threads\n    return cmd + \" -m \"+sorter_memory_string+\" --tmpdir ./ -o \"+ name +\".bam -l 5 /dev/stdin\"\n  }\n  else return \"\"\n}\n  \n",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "separate": false
          },
          {
            "position": 1,
            "valueFrom": {
              "script": "{\n  \n  if($job.inputs.read_group_header){\n  \treturn '-R ' + $job.inputs.read_group_header\n  }\n    \n  function add_param(key, val){\n    if(!val){\n      return\n\t}\n    param_list.push(key + ':' + val)\n  }\n\n  param_list = []\n\n  // Set output file name\n  if($job.inputs.input_reads[0] instanceof Array){\n    input_1 = $job.inputs.input_reads[0][0] // scatter mode\n  } else if($job.inputs.input_reads instanceof Array){\n    input_1 = $job.inputs.input_reads[0]\n  }else {\n    input_1 = [].concat($job.inputs.input_reads)[0]\n  }\n  \n  //Read metadata for input reads\n  read_metadata = input_1.metadata\n  if(!read_metadata) read_metadata = []\n\n  add_param('ID', '1')\n  \n  if($job.inputs.rg_data_submitting_center){\n  \tadd_param('CN', $job.inputs.rg_data_submitting_center)\n  }\n  else if('data_submitting_center' in  read_metadata){\n  \tadd_param('CN', read_metadata.data_submitting_center)\n  }\n  \n  if($job.inputs.rg_library_id){\n  \tadd_param('LB', $job.inputs.rg_library_id)\n  }\n  else if('library_id' in read_metadata){\n  \tadd_param('LB', read_metadata.library_id)\n  }\n  \n  if($job.inputs.rg_median_fragment_length){\n  \tadd_param('PI', $job.inputs.rg_median_fragment_length)\n  }\n\n  \n  if($job.inputs.rg_platform){\n  \tadd_param('PL', $job.inputs.rg_platform)\n  }\n  else if('platform' in read_metadata){\n    if(read_metadata.platform == 'HiSeq X Ten'){\n      rg_platform = 'Illumina'\n    }\n    else{\n      rg_platform = read_metadata.platform\n    }\n  \tadd_param('PL', rg_platform)\n  }\n  \n  if($job.inputs.rg_platform_unit_id){\n  \tadd_param('PU', $job.inputs.rg_platform_unit_id)\n  }\n  else if('platform_unit_id' in read_metadata){\n  \tadd_param('PU', read_metadata.platform_unit_id)\n  }\n  \n  if($job.inputs.rg_sample_id){\n  \tadd_param('SM', $job.inputs.rg_sample_id)\n  }\n  else if('sample_id' in  read_metadata){\n  \tadd_param('SM', read_metadata.sample_id)\n  }\n    \n  return \"-R '@RG\\\\t\" + param_list.join('\\\\t') + \"'\"\n  \n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "separate": true
          },
          {
            "position": 101,
            "valueFrom": {
              "script": "{\n  /////// Set input reads in the correct order depending of the paired end from metadata\n    \n     // Set output file name\n  if($job.inputs.input_reads[0] instanceof Array){\n    input_reads = $job.inputs.input_reads[0] // scatter mode\n  } else {\n    input_reads = $job.inputs.input_reads = [].concat($job.inputs.input_reads)\n  }\n  \n  \n  //Read metadata for input reads\n  read_metadata = input_reads[0].metadata\n  if(!read_metadata) read_metadata = []\n  \n  order = 0 // Consider this as normal order given at input: pe1 pe2\n  \n  // Check if paired end 1 corresponds to the first given read\n  if(read_metadata == []){ order = 0 }\n  else if('paired_end' in  read_metadata){ \n    pe1 = read_metadata.paired_end\n    if(pe1 != 1) order = 1 // change order\n  }\n\n  // Return reads in the correct order\n  if (input_reads.length == 1){\n    return input_reads[0].path // Only one read present\n  }\n  else if (input_reads.length == 2){\n    if (order == 0) return input_reads[0].path + ' ' + input_reads[1].path\n    else return input_reads[1].path + ' ' + input_reads[0].path\n  }\n\n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "separate": true
          },
          {
            "position": 2,
            "valueFrom": {
              "script": "{\n  \n  reads_size = 0 \n\n  GB_1 = 1024*1024*1024\n  if(reads_size < GB_1){ suggested_threads = 1 }\n  else if(reads_size < 10 * GB_1){ suggested_threads = 8 }\n  else { suggested_threads = 31 }\n  \n  \n  if(!$job.inputs.threads){  \treturn suggested_threads  }  \n  else{    return $job.inputs.threads  }\n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "separate": true,
            "prefix": "-t"
          },
          {
            "position": 10,
            "valueFrom": {
              "script": "{\n  reference_file = $job.inputs.reference_index_tar.path.split('/')[$job.inputs.reference_index_tar.path.split('/').length-1]\n  name = reference_file.slice(0, -4) // cut .tar extension \n  \n  return name\n  \n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "separate": true
          }
        ],
        "x": -40.944682963278815,
        "hints": [
          {
            "class": "DockerRequirement",
            "dockerImageId": "",
            "dockerPull": "cgrlab/typeseqer:latest"
          },
          {
            "class": "sbg:MemRequirement",
            "value": 16000
          },
          {
            "class": "sbg:CPURequirement",
            "value": 8
          }
        ],
        "sbg:validationErrors": [],
        "sbg:publisher": "sbg",
        "class": "CommandLineTool",
        "sbg:latestRevision": 49,
        "sbg:modifiedOn": 1520741385,
        "temporaryFailCodes": [],
        "sbg:toolkitVersion": "0.7.13",
        "sbg:revision": 49
      },
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
          "source": [
            "#BWA_INDEX.indexed_reference"
          ],
          "id": "#BWA_MEM_Bundle.reference_index_tar"
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
          "source": [
            "#input_reads"
          ],
          "id": "#BWA_MEM_Bundle.input_reads"
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
      "id": "#BWA_MEM_Bundle",
      "sbg:y": 303.4675358868678
    },
    {
      "sbg:x": 136.92308780286467,
      "outputs": [
        {
          "id": "#Sambamba_View.filtered"
        }
      ],
      "run": {
        "sbg:license": "GNU General Public License v2.0 only",
        "sbg:sbgMaintained": false,
        "description": "Sambamba View efficiently filters a BAM file for alignments satisfying various conditions. It also accesses its SAM header and information about reference sequences. A JSON output is provided to make this data readily available for use with Perl, Python, and Ruby scripts.\n\nBy default, the tool expects a BAM file as an input. In order to work with a SAM file as an input, specify --sam-input command-line option. The tool does NOT automatically detect file format from its extension. Beware that when reading SAM, the tool will skip tags which don't conform to the SAM/BAM specification and set invalid fields to their default values. However, only syntax is checked, use --valid for full validation.",
        "baseCommand": [
          "/sambamba_v0.6.6",
          "view"
        ],
        "successCodes": [],
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "sbg:revisionNotes": "corrected command line and switch to typeseqer docker",
        "stdin": "",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:projectName": "cgrHPV",
        "id": "dave/cgrhpv/sambamba-view-0-5-9/2",
        "sbg:toolAuthor": "Artem Tarasov",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedOn": 1485478878,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "Copy of dave/cgrwgs/sambamba-view-0-5-9/1",
            "sbg:revision": 0
          },
          {
            "sbg:modifiedOn": 1486834921,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 1
          },
          {
            "sbg:modifiedOn": 1520743858,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "corrected command line and switch to typeseqer docker",
            "sbg:revision": 2
          }
        ],
        "sbg:categories": [
          "SAM/BAM-Processing"
        ],
        "sbg:cmdPreview": "/sambamba_v0.6.6 view --format=bam  /root/dir/example.bam -o example.filtered.bam",
        "y": 199.2427914050468,
        "sbg:job": {
          "inputs": {
            "mem_mb": 7,
            "output": "bam",
            "input": {
              "secondaryFiles": [
                {
                  "path": ".bai"
                }
              ],
              "path": "/root/dir/example.bam"
            },
            "nthreads": null,
            "filter": "unmapped",
            "subsample": 9.236016917973757,
            "reserved_threads": 8
          },
          "allocatedResources": {
            "cpu": 8,
            "mem": 7
          }
        },
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "sbg:modifiedBy": "dave",
        "sbg:links": [
          {
            "label": "Homepage",
            "id": "http://lomereiter.github.io/sambamba/docs/sambamba-view.html"
          },
          {
            "label": "Source code",
            "id": "https://github.com/lomereiter/sambamba"
          },
          {
            "label": "Wiki",
            "id": "https://github.com/lomereiter/sambamba/wiki"
          },
          {
            "label": "Download",
            "id": "https://github.com/lomereiter/sambamba/releases/tag/v0.5.9"
          },
          {
            "label": "Publication",
            "id": "http://lomereiter.github.io/sambamba/docs/sambamba-view.html"
          }
        ],
        "stdout": "",
        "sbg:id": "dave/cgrhpv/sambamba-view-0-5-9/2",
        "sbg:toolkit": "Sambamba",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:createdOn": 1485478878,
        "outputs": [
          {
            "label": "BAM file",
            "description": "Bam file.",
            "outputBinding": {
              "sbg:metadata": {},
              "sbg:inheritMetadataFrom": "#input",
              "glob": {
                "script": "{\n  fnameRegex = /^(.*?)(?:\\.([^.]+))?$/;\n  file_path = $job.inputs.input.path;\n  base_name = fnameRegex.exec(file_path)[1];\n  file_name = base_name.replace(/^.*[\\\\\\/]/, '');\n  \n  if ($job.inputs.output == 'sam'){\n  \treturn file_name + '.filtered.sam'\n  }\n  else if ($job.inputs.output == 'bam'){\n  \treturn file_name.concat('.filtered.bam')\n  }\n  else if ($job.inputs.output == 'json'){\n  \treturn file_name.concat('.filtered.json')\n  }\n  else if ($job.inputs.output == 'msgpack'){\n  \treturn file_name.concat('.filtered.msgpack')\n  }\n  else\t{\n  \treturn file_name + '.filtered.sam'\n  }\n}",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              }
            },
            "type": [
              "null",
              "File"
            ],
            "sbg:fileTypes": "BAM, SAM, JSON, MSGPACK",
            "id": "#filtered"
          }
        ],
        "inputs": [
          {
            "label": "With header",
            "description": "Print header before reads (always done for BAM output).",
            "sbg:altPrefix": "h",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "Execution",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--with-header",
              "separate": true
            },
            "id": "#with_header"
          },
          {
            "sbg:category": "Execution",
            "label": "Valid",
            "description": "Output only valid reads.",
            "type": [
              "null",
              "boolean"
            ],
            "id": "#valid"
          },
          {
            "label": "Subsampling seed",
            "description": "Set seed for subsampling.",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--subsampling-seed",
              "separate": true
            },
            "id": "#subsampling_seed"
          },
          {
            "label": "Subsample",
            "description": "Subsample reads (read pairs).",
            "sbg:altPrefix": "s",
            "type": [
              "null",
              "float"
            ],
            "sbg:stageInput": null,
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--subsample=",
              "separate": true
            },
            "sbg:category": "Execution",
            "id": "#subsample"
          },
          {
            "label": "SAM input",
            "description": "Specify that input is in SAM format.",
            "sbg:altPrefix": "S",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "Execution",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--sam-input",
              "separate": true
            },
            "id": "#sam_input"
          },
          {
            "label": "Number of threads reserved on the instance",
            "description": "Number of threads reserved on the instance passed to the scheduler (number of jobs).",
            "type": [
              "null",
              "int"
            ],
            "sbg:stageInput": null,
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "1",
            "id": "#reserved_threads"
          },
          {
            "label": "Regions",
            "description": "Output only reads overlapping one of regions from the BED file.",
            "sbg:altPrefix": "L",
            "type": [
              "null",
              "File"
            ],
            "required": false,
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--regions=",
              "separate": false
            },
            "sbg:category": "File input.",
            "sbg:fileTypes": "BED",
            "id": "#regions"
          },
          {
            "label": "Reference",
            "description": "Specify reference for writing CRAM.",
            "sbg:altPrefix": "T",
            "type": [
              "null",
              "File"
            ],
            "required": false,
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--ref-filename=",
              "separate": false
            },
            "sbg:category": "Execution",
            "sbg:fileTypes": "FASTA,FA",
            "id": "#ref_filename"
          },
          {
            "label": "Output format",
            "description": "Specify which format to use for output (default is SAM).",
            "sbg:altPrefix": "-f",
            "type": [
              {
                "type": "enum",
                "name": "output",
                "symbols": [
                  "sam",
                  "bam",
                  "cram",
                  "json"
                ]
              }
            ],
            "sbg:category": "Execution",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--format=",
              "position": 1,
              "separate": false
            },
            "id": "#output"
          },
          {
            "label": "Number of threads",
            "description": "Number of threads to use.",
            "sbg:altPrefix": "-t",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--nthreads=",
              "valueFrom": {
                "script": "{\n  if ($job.inputs.nthreads)\n    return $job.inputs.nthreads\n  else\n    return 8\n}",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              },
              "separate": false
            },
            "sbg:toolDefaultValue": "8",
            "id": "#nthreads"
          },
          {
            "label": "Memory in MB",
            "description": "Memory in MB.",
            "type": [
              "null",
              "int"
            ],
            "sbg:stageInput": null,
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "1024",
            "id": "#mem_mb"
          },
          {
            "label": "Input",
            "description": "BAM or SAM file.",
            "type": [
              "File"
            ],
            "required": true,
            "inputBinding": {
              "sbg:cmdInclude": true,
              "secondaryFiles": [
                ".bai"
              ],
              "position": 2,
              "itemSeparator": " ",
              "separate": true
            },
            "sbg:category": "Inputs",
            "sbg:fileTypes": "BAM, SAM",
            "id": "#input"
          },
          {
            "label": "Filter",
            "description": "Set custom filter for alignments.",
            "sbg:altPrefix": "-F",
            "type": [
              "null",
              "string"
            ],
            "sbg:category": "Basic Options",
            "inputBinding": {
              "prefix": "--filter",
              "valueFrom": {
                "script": "{\n  if ($job.inputs.filter)\n  {\n  \treturn '\"'.concat($job.inputs.filter, '\"')\n  }\n}",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              },
              "sbg:cmdInclude": true,
              "itemSeparator": " ",
              "separate": true,
              "position": 0
            },
            "id": "#filter"
          },
          {
            "label": "CRAM input",
            "description": "Specify that input is in CRAM format.",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "Execution",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--cram-input",
              "itemSeparator": null,
              "separate": true
            },
            "id": "#cram_input"
          },
          {
            "label": "Count",
            "description": "Output to stdout only count of matching records, hHI are ignored.",
            "sbg:altPrefix": "c",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:category": "Execution",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--count",
              "separate": true
            },
            "id": "#count"
          },
          {
            "label": "Compression level",
            "description": "Specify compression level (from 0 to 9, works only for BAM output).",
            "sbg:altPrefix": "l",
            "type": [
              "null",
              "int"
            ],
            "sbg:category": "Execution",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--compression-level",
              "separate": true
            },
            "id": "#compression_level"
          }
        ],
        "sbg:image_url": null,
        "sbg:project": "dave/cgrhpv",
        "sbg:createdBy": "dave",
        "cwlVersion": "sbg:draft-2",
        "label": "Sambamba View",
        "arguments": [
          {
            "position": 3,
            "valueFrom": {
              "script": "{\n  fnameRegex = /^(.*?)(?:\\.([^.]+))?$/;\n  if ($job.inputs.input) \n  {\n  \tfile_path = $job.inputs.input.path;\n  \tbase_name = fnameRegex.exec(file_path)[1];\n  \tfile_name = base_name.replace(/^.*[\\\\\\/]/, '');\n  \n  if ($job.inputs.output == 'sam'){\n  \treturn file_name + '.filtered.sam'\n  }\n  else if ($job.inputs.output == 'bam'){\n  \treturn file_name.concat('.filtered.bam')\n  }\n  else if ($job.inputs.output == 'json'){\n  \treturn file_name.concat('.filtered.json')\n  }\n  else if ($job.inputs.output == 'msgpack'){\n  \treturn file_name.concat('.filtered.msgpack')\n  }\n  else\t{\n  \treturn file_name + '.filtered.sam'\n  }\n  }\n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "prefix": "-o",
            "separate": true
          }
        ],
        "x": 136.92308780286467,
        "hints": [
          {
            "class": "DockerRequirement",
            "dockerImageId": "59e577b13d5d",
            "dockerPull": "cgrlab/typeseqer:latest"
          },
          {
            "class": "sbg:CPURequirement",
            "value": {
              "script": "{\n  if ($job.inputs.reserved_threads) {\n    \n    return $job.inputs.reserved_threads\n    \n  } else if ($job.inputs.nthreads) {\n    \n    return $job.inputs.nthreads\n    \n  } else {\n    \n    return 1\n  }\n  \n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            }
          },
          {
            "class": "sbg:MemRequirement",
            "value": {
              "script": "{\n  if ($job.inputs.mem_mb) {\n    \n    return $job.inputs.mem_mb\n    \n  } else {\n    \n    return 1024\n    \n  }\n  \n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            }
          }
        ],
        "sbg:validationErrors": [],
        "sbg:publisher": "sbg",
        "class": "CommandLineTool",
        "sbg:latestRevision": 2,
        "sbg:modifiedOn": 1520743858,
        "temporaryFailCodes": [],
        "sbg:toolkitVersion": "0.5.9",
        "sbg:revision": 2
      },
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
          "source": [
            "#BWA_MEM_Bundle.aligned_reads"
          ],
          "id": "#Sambamba_View.input"
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
      "id": "#Sambamba_View",
      "sbg:y": 199.2427914050468
    },
    {
      "scatter": "#illumina_typing_run_processor.bam_json",
      "sbg:x": 510.5132220877906,
      "outputs": [
        {
          "id": "#illumina_typing_run_processor.hpv_types"
        },
        {
          "id": "#illumina_typing_run_processor.app_html_out"
        }
      ],
      "run": {
        "sbg:sbgMaintained": false,
        "description": "",
        "baseCommand": [
          "Rscript",
          "-e",
          "'require(rmarkdown);",
          "render(\"illumina_demultiplex_read_processor.R\")'"
        ],
        "sbg:id": "dave/cgrhpv/illumina-typing-run-processor/22",
        "requirements": [
          {
            "class": "CreateFileRequirement",
            "fileDef": [
              {
                "filename": "args.R",
                "fileContent": {
                  "script": "\n'# get args \\n\\\nargs_bam_json = data_frame(path = \"'+$job.inputs.bam_json.path+'\", name = \"'+$job.inputs.bam_json.path.split(\"/\").reverse()[0].split(\".fastq.\")[0]+'\") \\n\\\nargs_barcode_file = \"'+$job.inputs.barcode_file.path+'\" \\n\\\nargs_parameter_file = \"/opt/2017-Nov_HPV_Typing_MiSeq_MQ_and_MinLen_Filters_4.csv\" \\n\\\nargs_page_size = ' +$job.inputs.page_size\n",
                  "class": "Expression",
                  "engine": "#cwl-js-engine"
                }
              },
              {
                "filename": "illumina_demultiplex_read_processor.R",
                "fileContent": "# Databricks notebook source\n#+ db only - load spark, echo=FALSE, include = FALSE, eval=FALSE\nlibrary(SparkR)\n\n#+ load packages\nlibrary(GenomicAlignments)\nlibrary(tidyverse)\nlibrary(stringr)\nlibrary(jsonlite)\nlibrary(pander)\nlibrary(scales)\nlibrary(knitr)\nlibrary(rmarkdown)\nlibrary(koRpus)\nlibrary(fuzzyjoin)\nsessionInfo()\n\n\n# COMMAND ----------\n\n#+ databricks args, echo=exists(\"is_test\"), include =FALSE, eval=exists(\"is_test\")\n\nargs_bam_json = data_frame(path = \"/databricks/driver/temp.json\", name = \"Run5_Pool5_S1_L001_R_000\") \nargs_barcode_file = \"/dbfs/mnt/rd111/2017-11-09_TypeSeqer_MiSeq_v2_Barcodes_FandR-rev-comp.csv\"\nargs_parameter_file = \"/dbfs/mnt/rd111/2017-Nov_HPV_Typing_MiSeq_MQ_and_MinLen_Filters_4.csv\"\nargs_page_size = 20000\n\nsystem(\"touch args.R\")\n\n#+ get args\nread_lines(\"args.R\") %>% \nwriteLines()\nsource(\"args.R\")\n\n\n# COMMAND ----------\n\n#+ read barcodes csv\nbarcodes = read_csv(args_barcode_file) %>% \nmap_if(is.factor, as.character) %>% \nas_tibble() %>%\nglimpse()\n\n#+ eval=FALSE, include=FALSE\ndisplay(barcodes)\n\n# COMMAND ----------\n\n#+ read parameters csv\nparameters = read_csv(args_parameter_file) %>% \nmap_if(is.factor, as.character) %>% \nas_tibble() %>% \nmutate(min_mq = mq) %>% \nselect(-mq)\n\n# COMMAND ----------\n\n#+ process reads - init output\n\nhpv_types_output = file(paste0(args_bam_json$name,\"_hpv_types.json\"), open = \"wb\")\n\n#+ process reads - db only, eval=FALSE, include=FALSE\n\nhpv_types_output = file(paste0(\"/databricks/driver/\", args_bam_json$name,\"_hpv_types.json\"), open = \"wb\")\n\n#+ process reads - main code, include=FALSE\n\npage = 1\n\nstream_in(file(args_bam_json$path), handler = function(bam_json){\n# Processes a page of data at a time\n\nreads = bind_cols(bam_json[1:11], as_data_frame(bam_json$tags)) %>% \nas_tibble()\n  \n# demultiplex (add barcode column via fuzzy join)\nreads_demultiplex = reads %>%\nselect(qname, rname, seq, mapq, cigar) %>%\nmutate(pre_demultiplex_pairs = n()/2) %>%\nfuzzy_join(barcodes, mode = \"inner\", by=c(\"seq\" = \"bc_sequence\"), match_fun = function(x, y) str_detect(str_sub(x, start=-25), fixed(y, ignore_case=TRUE))) %>%\nmutate(bc_num = ifelse(str_detect(bc_id, \"Rev\"), 1, 2)) %>%\narrange(qname, bc_num) %>%\ndo({print(\"post fuzzy join\"); temp=.}) %>% glimpse() %>%\ngroup_by(qname) %>%\nmutate(pair_read_count = n()) %>%\nmutate(barcode = paste0(bc_id, collapse=\"\")) %>%\nungroup() %>%\nfilter(!str_detect(bc_id, \"Fwd\")) %>%\nmutate(barcode_1 = bc_id) %>%\ndo({print(\"post str detect rev\"); temp=.}) %>% glimpse() %>%\nselect(barcode_1, barcode, qname, rname, seq, mapq, cigar, pair_read_count, pre_demultiplex_pairs) %>%\ndistinct() %>%\n    \ndo({print(\"post demultiplex\"); temp=.}) %>% glimpse() %>%\n\n# now get barcode_1 metrics\nmutate(barcode_pairs = n()) %>%\nfilter(pair_read_count == 2) %>%\nselect(-pair_read_count) %>%\nfilter(str_detect(barcode, \"Fwd\"), str_detect(barcode, \"Rev\")) %>%\nmutate(total_demultiplex_reads = n()) %>%\ngroup_by(barcode_1) %>% \nmutate(post_demultiplex_reads = n()) %>%\nungroup() %>%\ndo({print(\"post barcode 1 metrics\"); temp=.}) %>% glimpse()\n           \n#filter and reduce\nreads_reduced = reads_demultiplex %>%\nselect(barcode_1, barcode, qname, HPV_Type = rname, seq, mapq, cigar, pre_demultiplex_pairs, total_demultiplex_reads, post_demultiplex_reads) %>%\ngroup_by(barcode) %>%\nmutate(page_num = page) %>%\nmutate(file_name = args_bam_json$name) %>%\nleft_join(parameters) %>%\nfilter(mapq >= min_mq) %>%\nmutate(mapq_reads = n()) %>%\nmutate(seq_length = str_length(seq)) %>%\nfilter(mapq != 0) %>%\nmutate(cigar_seq = as.character(sequenceLayer(DNAStringSet(seq), cigar))) %>%\nmutate(cigar_len = str_length(cigar_seq)) %>%\nfilter(cigar_len >= min_align_len) %>%\nmutate(gt_equal_min_reads = n()) %>%\nmutate(qualified_barcode_reads = n()) %>%\ngroup_by(barcode, HPV_Type) %>%\nmutate(HPV_Type_count = n()) %>%\nungroup() %>%\nselect(barcode_1, barcode, file_name, page_num, pre_demultiplex_pairs, total_demultiplex_reads, post_demultiplex_reads, mapq_reads, gt_equal_min_reads, qualified_barcode_reads, HPV_Type, HPV_Type_count) %>%\ndistinct() %>%\ndo({print(\"post everything\"); temp=.}) %>% glimpse()\n           \npage <<- page + 1\n\nstream_out(reads_reduced, hpv_types_output, verbose = FALSE)\n           \n}, pagesize = args_page_size, verbose = FALSE)\n\nclose(hpv_types_output)\n\n# COMMAND ----------\n\n#+ checking on db, eval=FALSE, include=FALSE\ntemp = stream_in(file(\"/databricks/driver/Run5_Pool5_S1_L001_R_000_hpv_types.json\")) %>%\nglimpse()\n\ndisplay(temp)\n\n# COMMAND ----------\n\n# MAGIC %sh\n# MAGIC #sudo rm -r TypeSeqer-private && \n# MAGIC sudo mkdir TypeSeqer-private && cd TypeSeqer-private && sudo git init && sudo git pull https://86e728b5c68508d0de00422e81126de37c118fbd@github.com/davidroberson/TypeSeqer-private.git &&\n# MAGIC cd ../\n# MAGIC Rscript -e 'require(rmarkdown); is_test=\"true\"; render(\"TypeSeqer-private/scripts/illumina_demultiplex_read_processor.R\");'"
              }
            ]
          },
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "sbg:revisionNotes": "put barcode back in",
        "stdin": "",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:projectName": "cgrHPV",
        "id": "dave/cgrhpv/illumina-typing-run-processor/22",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedOn": 1492530856,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "Copy of dave/cgrhpv/split-barcode-2-get-coverage/36",
            "sbg:revision": 0
          },
          {
            "sbg:modifiedOn": 1492531013,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "changing from the regular ion app",
            "sbg:revision": 1
          },
          {
            "sbg:modifiedOn": 1492539836,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 2
          },
          {
            "sbg:modifiedOn": 1492540967,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "removing references to A1 barcode",
            "sbg:revision": 3
          },
          {
            "sbg:modifiedOn": 1492542278,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 4
          },
          {
            "sbg:modifiedOn": 1495053330,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 5
          },
          {
            "sbg:modifiedOn": 1510244908,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "adding demultiplex",
            "sbg:revision": 6
          },
          {
            "sbg:modifiedOn": 1510244936,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "changed to typeseqer docker",
            "sbg:revision": 7
          },
          {
            "sbg:modifiedOn": 1510245033,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added std.err std.out output",
            "sbg:revision": 8
          },
          {
            "sbg:modifiedOn": 1510251011,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added demultiplex",
            "sbg:revision": 9
          },
          {
            "sbg:modifiedOn": 1510251553,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added barcode file input",
            "sbg:revision": 10
          },
          {
            "sbg:modifiedOn": 1510251661,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added html out",
            "sbg:revision": 11
          },
          {
            "sbg:modifiedOn": 1510252681,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "renamed args.R",
            "sbg:revision": 12
          },
          {
            "sbg:modifiedOn": 1510252842,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "removed some args from command line",
            "sbg:revision": 13
          },
          {
            "sbg:modifiedOn": 1510715534,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "better metrics",
            "sbg:revision": 14
          },
          {
            "sbg:modifiedOn": 1510721184,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 15
          },
          {
            "sbg:modifiedOn": 1510721221,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 16
          },
          {
            "sbg:modifiedOn": 1510792420,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "fixing barcode orientation",
            "sbg:revision": 17
          },
          {
            "sbg:modifiedOn": 1510792666,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "fixing barcodes",
            "sbg:revision": 18
          },
          {
            "sbg:modifiedOn": 1510799338,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added fwd rev back in",
            "sbg:revision": 19
          },
          {
            "sbg:modifiedOn": 1520650394,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "parameter files in jazz area",
            "sbg:revision": 20
          },
          {
            "sbg:modifiedOn": 1520650841,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "barcode file is now in the docker",
            "sbg:revision": 21
          },
          {
            "sbg:modifiedOn": 1520876842,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "put barcode back in",
            "sbg:revision": 22
          }
        ],
        "sbg:categories": [
          "hpv_typing"
        ],
        "sbg:cmdPreview": "Rscript -e 'require(rmarkdown); render(\"illumina_demultiplex_read_processor.R\")'  1>&2",
        "y": 161.80698296935176,
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "sbg:modifiedBy": "dave",
        "successCodes": [],
        "stdout": "",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:createdOn": 1492530856,
        "outputs": [
          {
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#bam_json",
              "glob": {
                "script": "\"*_hpv_types.json\"",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              }
            },
            "type": [
              "null",
              "File"
            ],
            "id": "#hpv_types"
          },
          {
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#bam_json",
              "glob": "*.html"
            },
            "type": [
              "null",
              "File"
            ],
            "id": "#app_html_out"
          }
        ],
        "inputs": [
          {
            "sbg:stageInput": null,
            "type": [
              "null",
              "int"
            ],
            "id": "#page_size"
          },
          {
            "required": false,
            "type": [
              "null",
              "File"
            ],
            "id": "#barcode_file"
          },
          {
            "label": "bam",
            "description": "bam",
            "type": [
              "null",
              "File"
            ],
            "default": "",
            "required": false,
            "streamable": false,
            "sbg:stageInput": null,
            "id": "#bam_json"
          }
        ],
        "sbg:image_url": null,
        "sbg:project": "dave/cgrhpv",
        "sbg:createdBy": "dave",
        "cwlVersion": "sbg:draft-2",
        "label": "illumina typing run processor",
        "arguments": [
          {
            "position": 100,
            "valueFrom": "1>&2",
            "separate": true
          }
        ],
        "x": 510.5132220877906,
        "hints": [
          {
            "class": "DockerRequirement",
            "dockerPull": "cgrlab/typeseqer:latest"
          },
          {
            "class": "sbg:CPURequirement",
            "value": 1
          },
          {
            "class": "sbg:MemRequirement",
            "value": 1000
          }
        ],
        "sbg:validationErrors": [],
        "sbg:publisher": "sbg",
        "class": "CommandLineTool",
        "sbg:latestRevision": 22,
        "sbg:modifiedOn": 1520876842,
        "temporaryFailCodes": [],
        "sbg:job": {
          "inputs": {
            "bam_json": {
              "secondaryFiles": [
                {
                  "path": ".bai"
                }
              ],
              "class": "File",
              "size": 0,
              "path": "path/to/_2_Run1v0202_Pool1_S1_L001_001_barcode_Rev_BC107_2_barcode_Fwd_BC03.fastq.sorted.filtered.json"
            },
            "page_size": 5000,
            "barcode_file": {
              "secondaryFiles": [],
              "class": "File",
              "size": 0,
              "path": "/path/to/barcode_file.ext"
            }
          },
          "allocatedResources": {
            "cpu": 1,
            "mem": 1000
          }
        },
        "sbg:revision": 22
      },
      "inputs": [
        {
          "id": "#illumina_typing_run_processor.page_size",
          "default": 20000
        },
        {
          "source": [
            "#barcode_file"
          ],
          "id": "#illumina_typing_run_processor.barcode_file"
        },
        {
          "source": [
            "#json_splitter.split_variants_json"
          ],
          "id": "#illumina_typing_run_processor.bam_json"
        }
      ],
      "id": "#illumina_typing_run_processor",
      "sbg:y": 161.80698296935176
    },
    {
      "sbg:x": 326.2395835393183,
      "outputs": [
        {
          "id": "#json_splitter.split_variants_json"
        }
      ],
      "run": {
        "sbg:sbgMaintained": false,
        "description": "",
        "baseCommand": [
          "split",
          "--additional-suffix",
          ".split.json",
          "-l",
          {
            "script": "$job.inputs.number_of_lines_per_file",
            "class": "Expression",
            "engine": "#cwl-js-engine"
          },
          "-de",
          "-a",
          "3",
          {
            "script": "$job.inputs.json.path",
            "class": "Expression",
            "engine": "#cwl-js-engine"
          },
          {
            "script": "$job.inputs.json.path.split(\"/\").reverse()[0].split(\".\")[0]+\"_\"",
            "class": "Expression",
            "engine": "#cwl-js-engine"
          }
        ],
        "sbg:id": "dave/cgrhpv/json-splitter/8",
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "sbg:revisionNotes": "updated docker again",
        "stdin": "",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:projectName": "cgrHPV",
        "id": "dave/cgrhpv/json-splitter/8",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedOn": 1485478911,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "Copy of dave/rd161-hpv-integration-working-01/json-splitter/1",
            "sbg:revision": 0
          },
          {
            "sbg:modifiedOn": 1486825823,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "not a copy anymore",
            "sbg:revision": 1
          },
          {
            "sbg:modifiedOn": 1486828885,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 2
          },
          {
            "sbg:modifiedOn": 1486828902,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 3
          },
          {
            "sbg:modifiedOn": 1486859176,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 4
          },
          {
            "sbg:modifiedOn": 1486859373,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "tidygenomics",
            "sbg:revision": 5
          },
          {
            "sbg:modifiedOn": 1486862260,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": null,
            "sbg:revision": 6
          },
          {
            "sbg:modifiedOn": 1520778127,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "switch to typeseqer docker",
            "sbg:revision": 7
          },
          {
            "sbg:modifiedOn": 1520877879,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "updated docker again",
            "sbg:revision": 8
          }
        ],
        "sbg:cmdPreview": "split --additional-suffix .split.json -l 100 -de -a 3 /path/to/IonXpress_075_Auto_user_S5XL-0039-25-2017-01-10_RD111_HPV-T_T163_SUCCEED_104.json IonXpress_075_Auto_user_S5XL-0039-25-2017-01-10_RD111_HPV-T_T163_SUCCEED_104_  > std.out",
        "y": 245.7387124120971,
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "sbg:modifiedBy": "dave",
        "successCodes": [],
        "stdout": "std.out",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:modifiedOn": 1520877879,
        "sbg:createdOn": 1485478911,
        "outputs": [
          {
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#variant_json",
              "glob": {
                "script": "\"*.split.json\"",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              }
            },
            "type": [
              "null",
              {
                "items": "File",
                "type": "array"
              }
            ],
            "id": "#split_variants_json"
          }
        ],
        "sbg:project": "dave/cgrhpv",
        "sbg:image_url": null,
        "sbg:createdBy": "dave",
        "cwlVersion": "sbg:draft-2",
        "label": "json_splitter",
        "arguments": [],
        "x": 326.2395835393183,
        "hints": [
          {
            "class": "sbg:CPURequirement",
            "value": 1
          },
          {
            "class": "sbg:MemRequirement",
            "value": 1000
          },
          {
            "class": "DockerRequirement",
            "dockerImageId": "",
            "dockerPull": "cgrlab/typeseqer:latest"
          }
        ],
        "sbg:validationErrors": [],
        "sbg:publisher": "sbg",
        "class": "CommandLineTool",
        "sbg:latestRevision": 8,
        "inputs": [
          {
            "sbg:stageInput": null,
            "label": "number of lines per file",
            "type": [
              "null",
              "int"
            ],
            "id": "#number_of_lines_per_file"
          },
          {
            "required": false,
            "label": "variant json",
            "type": [
              "null",
              "File"
            ],
            "id": "#json"
          }
        ],
        "temporaryFailCodes": [],
        "sbg:job": {
          "inputs": {
            "json": {
              "secondaryFiles": [],
              "class": "File",
              "size": 0,
              "path": "/path/to/IonXpress_075_Auto_user_S5XL-0039-25-2017-01-10_RD111_HPV-T_T163_SUCCEED_104.json"
            },
            "number_of_lines_per_file": 100
          },
          "allocatedResources": {
            "cpu": 1,
            "mem": 1000
          }
        },
        "sbg:revision": 8
      },
      "inputs": [
        {
          "id": "#json_splitter.number_of_lines_per_file",
          "default": 600000
        },
        {
          "source": [
            "#Sambamba_View.filtered"
          ],
          "id": "#json_splitter.json"
        }
      ],
      "id": "#json_splitter",
      "sbg:y": 245.7387124120971
    },
    {
      "sbg:x": 306.15387536788234,
      "outputs": [
        {
          "id": "#SAMtools_extract_SAM_BAM_header.output_header_file"
        }
      ],
      "run": {
        "sbg:license": "BSD License, MIT License",
        "sbg:sbgMaintained": false,
        "description": "Extract the header from the alignment file in SAM or BAM formats.",
        "baseCommand": [
          "samtools",
          "view"
        ],
        "successCodes": [],
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "sbg:revisionNotes": "cgrlab/typeseqer:latest",
        "stdin": "",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:projectName": "cgrHPV",
        "id": "dave/cgrhpv/samtools-extract-bam-header-1-3/3",
        "sbg:toolAuthor": "Heng Li/Sanger Institute,  Bob Handsaker/Broad Institute, James Bonfield/Sanger Institute,",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedOn": 1492714234,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "Copy of admin/sbg-public-data/samtools-extract-bam-header-1-3/9",
            "sbg:revision": 0
          },
          {
            "sbg:modifiedOn": 1492714376,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "no changes...just want to save a non-copy version in this project",
            "sbg:revision": 1
          },
          {
            "sbg:modifiedOn": 1495125186,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "removed aws instance hint",
            "sbg:revision": 2
          },
          {
            "sbg:modifiedOn": 1520717721,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "cgrlab/typeseqer:latest",
            "sbg:revision": 3
          }
        ],
        "sbg:categories": [
          "SAM/BAM-Processing"
        ],
        "sbg:cmdPreview": "samtools view  input_bam_or_sam_file.bam  -H -o input_bam_or_sam_file.txt",
        "y": 514.6274697208834,
        "sbg:job": {
          "inputs": {
            "input_bam_or_sam_file": {
              "secondaryFiles": [],
              "class": "File",
              "size": 0,
              "path": "input_bam_or_sam_file.bam"
            }
          },
          "allocatedResources": {
            "cpu": 1,
            "mem": 1000
          }
        },
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "sbg:modifiedBy": "dave",
        "sbg:links": [
          {
            "label": "Homepage",
            "id": "http://www.htslib.org"
          },
          {
            "label": "Source Code",
            "id": "https://github.com/samtools/"
          },
          {
            "label": "Download",
            "id": "https://sourceforge.net/projects/samtools/files/samtools/"
          },
          {
            "label": "Publication",
            "id": "http://www.ncbi.nlm.nih.gov/pubmed/19505943"
          },
          {
            "label": "Documentation",
            "id": "http://www.htslib.org/doc/samtools.html"
          },
          {
            "label": "Wiki",
            "id": "http://www.htslib.org"
          }
        ],
        "stdout": "",
        "sbg:id": "dave/cgrhpv/samtools-extract-bam-header-1-3/3",
        "sbg:toolkit": "SAMtools",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:modifiedOn": 1520717721,
        "sbg:createdOn": 1492714234,
        "outputs": [
          {
            "label": "Output header",
            "description": "Output header.",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#input_bam_or_sam_file",
              "glob": "*.txt"
            },
            "type": [
              "File"
            ],
            "sbg:fileTypes": "TXT",
            "id": "#output_header_file"
          }
        ],
        "sbg:project": "dave/cgrhpv",
        "sbg:image_url": null,
        "sbg:createdBy": "dave",
        "cwlVersion": "sbg:draft-2",
        "label": "SAMtools extract SAM/BAM header",
        "arguments": [
          {
            "position": 2,
            "valueFrom": {
              "script": "{\n filepath = $job.inputs.input_bam_or_sam_file.path\n\n filename = filepath.split(\"/\").pop();\n\n file_dot_sep = filename.split(\".\");\n file_ext = file_dot_sep[file_dot_sep.length-1];\n\n new_filename = filename.substr(0,filename.lastIndexOf(\".\"));\n \n extension = '.txt'\n             \n return new_filename + extension; \n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "prefix": "-o",
            "separate": true
          },
          {
            "position": 1,
            "valueFrom": {
              "script": "{\nreturn '-H'\n}",
              "class": "Expression",
              "engine": "#cwl-js-engine"
            },
            "prefix": "",
            "separate": true
          }
        ],
        "x": 306.15387536788234,
        "hints": [
          {
            "class": "sbg:CPURequirement",
            "value": 1
          },
          {
            "class": "sbg:MemRequirement",
            "value": 1000
          },
          {
            "class": "DockerRequirement",
            "dockerImageId": "",
            "dockerPull": "cgrlab/typeseqer:latest"
          }
        ],
        "sbg:validationErrors": [],
        "sbg:publisher": "sbg",
        "class": "CommandLineTool",
        "sbg:latestRevision": 3,
        "inputs": [
          {
            "label": "BAM or SAM input file",
            "description": "BAM or SAM input file.",
            "type": [
              "File"
            ],
            "required": true,
            "inputBinding": {
              "sbg:cmdInclude": true,
              "position": 0,
              "separate": true
            },
            "sbg:category": "File input",
            "sbg:fileTypes": "BAM, SAM",
            "id": "#input_bam_or_sam_file"
          }
        ],
        "temporaryFailCodes": [],
        "sbg:toolkitVersion": "v1.3",
        "sbg:revision": 3
      },
      "inputs": [
        {
          "source": [
            "#BWA_MEM_Bundle.aligned_reads"
          ],
          "id": "#SAMtools_extract_SAM_BAM_header.input_bam_or_sam_file"
        }
      ],
      "id": "#SAMtools_extract_SAM_BAM_header",
      "sbg:y": 514.6274697208834
    },
    {
      "sbg:x": 918.8887561574423,
      "outputs": [
        {
          "id": "#illumina_typeseqer_report.pos_neg_matrix"
        },
        {
          "id": "#illumina_typeseqer_report.pdf_report"
        },
        {
          "id": "#illumina_typeseqer_report.control_matrix"
        },
        {
          "id": "#illumina_typeseqer_report.samples_only_matrix"
        },
        {
          "id": "#illumina_typeseqer_report.failed_samples_matrix"
        }
      ],
      "run": {
        "sbg:sbgMaintained": false,
        "description": "",
        "baseCommand": [
          "Rscript",
          "-e",
          "'require(rmarkdown);",
          "render(\"illumina_TypeSeqer_report_pdf.R\")",
          "'",
          "&&",
          "rm",
          "../*/*split.json",
          "&&",
          "rm",
          "../*/*filtered.json",
          "&&",
          "mkdir",
          "/typeSeqerFiles/illumina_typeseqer_output",
          "&&",
          "cp",
          "*pdf",
          "*csv",
          "/typeSeqerFiles/illumina_typeseqer_output"
        ],
        "sbg:cmdPreview": "Rscript -e 'require(rmarkdown); render(\"illumina_TypeSeqer_report_pdf.R\") ' && rm ../*/*split.json && rm ../*/*filtered.json && mkdir /typeSeqerFiles/illumina_typeseqer_output && cp *pdf *csv /typeSeqerFiles/illumina_typeseqer_output 1>&2",
        "requirements": [
          {
            "class": "CreateFileRequirement",
            "fileDef": [
              {
                "filename": "args.R",
                "fileContent": {
                  "script": "'args_control_defs = \"'+$job.inputs.control_defs.path+'\" \\n\\\nargs_run_manifest_path =  \"'+$job.inputs.run_manifest.path+'\" \\n\\\nargs_bam_header_path =  \"'+$job.inputs.bam_header_file.path+'\" \\n\\\nargs_pos_neg_filtering_criteria_path = \"/opt/2017-06-11_Pos-Neg_matrix_filtering_criteria_RefTable_v3.txt\" \\n\\\nargs_hpv_types_path = \"'+$job.inputs.hpv_types_json.path+'\" \\n\\\nargs_scaling_table = \"/opt/2017-11-24_TypeSeqer_Filtering_Scaling_Table_v2.csv\" \\n\\\nargs_parameter_file_path = \"/opt/2017-Nov_HPV_Typing_MiSeq_MQ_and_MinLen_Filters_4.csv\"';\n\n\n\n\n\n\n\n\n",
                  "class": "Expression",
                  "engine": "#cwl-js-engine"
                }
              },
              {
                "filename": "illumina_TypeSeqer_report_pdf.R",
                "fileContent": "#' ---\n#' title: TypeSeqer HPV Typing Report\n#' author: \"illumina MiSeq\"\n#' date: \"`r format(Sys.time(), '%d %B, %Y')`\"\n#' \n#' output:\n#'  pdf_document:\n#'     toc: true\n#' ---\n\n#+ load packages - db only - load spark, echo=FALSE, include = FALSE, eval=FALSE\nlibrary(SparkR)\n\n#+ load packages, echo=FALSE, include = FALSE\nlibrary(tidyverse)\nlibrary(stringr)\nlibrary(jsonlite)\nlibrary(pander)\nlibrary(scales)\nlibrary(knitr)\nlibrary(rmarkdown)\n#library(koRpus)\nlibrary(fuzzyjoin)\n#library(pandoc)\nsessionInfo()\n\n\n# COMMAND ----------\n\n#+ echo=FALSE, include =FALSE, eval=exists(\"is_test\")\n\nargs_parameter_file_path = \"/dbfs/mnt/rd111/2017-Nov_HPV_Typing_MiSeq_MQ_and_MinLen_Filters_4.csv\"\nargs_pos_neg_filtering_criteria_path = \"/dbfs/mnt/rd111/Prof_TypeSeqer-HPV-DEV_out.629_188_137/2017-06-11_Pos-Neg_matrix_filtering_criteria_RefTable_v3.txt\"\nargs_scaling_table = \"/dbfs/mnt/rd111/Prof_TypeSeqer-HPV-DEV_out.629_188_137/2017-08-07_TypeSeqer_Filtering_Scaling_Table.csv\"\n\nargs_run_manifest_path = \"/dbfs/mnt/rd111/2017-11_CDC_sample_manifest_typing_workflow_MiSeq.csv\"\nargs_control_defs = \"/dbfs/mnt/rd111/2017-11-09_Typing_Controls_Defined_Results_5.csv\" \nargs_hpv_types_path = \"/dbfs/mnt/rd111/_2_illumina_hpv_types_merged.json\"\nargs_bam_header_path = \"/dbfs/mnt/rd111/1_CDC_pool_S1_L001_R.txt\"\n\nsystem(\"touch args.R\")\n\n#+ get args, echo=FALSE, include = FALSE\nread_lines(\"args.R\") %>% \nwriteLines()\nsource(\"args.R\")\n\n\n# COMMAND ----------\n\n#+ parameters_df, echo=FALSE, include = FALSE\nparameters_df = read_csv(args_parameter_file_path) %>% \nmap_if(is.factor, as.character) %>% \nas_tibble() %>% \nselect(HPV_Type, display_order)\n\n# COMMAND ----------\n\n#+ stream in and summarize hpv type counts, echo=FALSE, include = FALSE\nhpv_type_counts = stream_in(file(args_hpv_types_path)) %>%\ngroup_by(barcode, HPV_Type) %>%\nmutate(HPV_Type_count = sum(HPV_Type_count)) %>%\nungroup() %>%\nselect(barcode, HPV_Type, HPV_Type_count) %>%\ndistinct() %>%\narrange(barcode, HPV_Type)\n\n#+ eval=FALSE, include=FALSE\ndisplay(hpv_type_counts)\n\n# COMMAND ----------\n\n#+ read bam header, echo=FALSE, include = FALSE\nbam_header = read_tsv(args_bam_header_path, col_names = c(\"header_col1\", \"HPV_Type\",\"contig_size\")) %>%\nfilter(header_col1 == \"@SQ\") %>%\nmutate(HPV_Type = str_sub(HPV_Type, start=4)) %>%\nselect(HPV_Type)\n\nbam_header\n\n# COMMAND ----------\n\n#+ create hpv types longform, echo=FALSE, include = FALSE\nhpv_types_long = read_csv(args_run_manifest_path, col_names=TRUE) %>%\nfilter(!is.na(Owner_Sample_ID)) %>%\nmutate(barcode = paste0(BC1, BC2)) %>%\nselect(-BC1,-BC2) %>%\nfull_join(hpv_type_counts, by=\"barcode\")  %>%\nglimpse()\n\n# COMMAND ----------\n\n#+ create hpv types dataframe, echo=FALSE, include = FALSE\nhpv_types = hpv_types_long %>%\n# bind with bam header to get contig names that might be absent from all samples in this particular run\nbind_rows(bam_header) %>%\n\n# merge with parameters file to get display order\nleft_join(parameters_df) %>% mutate(HPV_Type = factor(HPV_Type, levels=unique(HPV_Type[order(display_order)]), ordered=TRUE)) %>% select(-display_order) %>%\n\n# tranform from long form to actual matrix\nspread(HPV_Type, HPV_Type_count, fill = \"0\") %>% \nfilter(!is.na(Project)) %>%\ndo({\ntemp = .\nif (\"<NA>\" %in% colnames(temp)){temp = temp %>% select(-`<NA>`)}\ntemp = temp\n}) %>%\n# change columns back to numeric\nmutate_at(vars(starts_with(\"HPV\")), funs(as.numeric(.))) %>% mutate_at(vars(starts_with(\"B2M\")), funs(as.numeric(.))) %>%\n\n# condense/merge contigs that are from the same type\nmutate(HPV64 = HPV34 + HPV64) %>% \nmutate(HPV54 = HPV54 + HPV54_B_C_consensus) %>%\nmutate(HPV74 = HPV74 + HPV74_EU911625 + HPV74_EU911664 + HPV74_U40822) %>%\nselect(-HPV34, -HPV54_B_C_consensus, -HPV74_EU911625, -HPV74_EU911664, -HPV74_U40822) %>%\nglimpse()\n\n# COMMAND ----------\n\n#+ create full run read metrics df, echo=FALSE, include = FALSE\n\nread_metrics = stream_in(file(args_hpv_types_path), verbose=FALSE) %>%\nsample_n(1000, replace = TRUE) %>%\ngroup_by(barcode_1) %>%\nmutate(qualified_hpv_counts = sum(HPV_Type_count)) %>%\nmutate(temp_value = 1) %>%\ngroup_by(temp_value) %>%\ndo({\ndf = .\n  \ntotal_reads_df = df %>%\nselect(file_name, page_num, pre_demultiplex_pairs) %>%\ndistinct() %>%\nmutate(total_reads = sum(pre_demultiplex_pairs))\n  \npost_demultiplex_reads_df = df %>%\nselect(barcode_1, file_name, page_num, post_demultiplex_reads) %>%\ndistinct() %>%\ngroup_by(barcode_1) %>%\nmutate(total_post_demultiplex_reads = sum(post_demultiplex_reads)) %>%\nselect(barcode_1, total_post_demultiplex_reads)\n  \ndf = df %>%\nmutate(total_reads = total_reads_df$total_reads[1]) %>%\nleft_join(post_demultiplex_reads_df)\n  \n}) %>%\nungroup() %>%\nselect(barcode_1, total_reads, total_post_demultiplex_reads, qualified_hpv_counts) %>%\ndistinct() %>%\nmutate(qualified_perc = qualified_hpv_counts / total_post_demultiplex_reads) %>%\nselect(barcode_1, qualified_perc, total_reads, total_post_demultiplex_reads, qualified_hpv_counts) %>%\narrange(barcode_1)\n\n#+ eval=FALSE, include=FALSE\ndisplay(read_metrics)\n\n# COMMAND ----------\n\n#+ scaling of reads, echo=FALSE, include = FALSE\n\n#1.  sum the pass filter reads for entire chip (all BC's); \"qualified_aligned_reads\" from read_metrics table output\n\nsum_pass_filter_reads = sum(read_metrics$total_post_demultiplex_reads)\n\nprint(sum_pass_filter_reads)\n\n#2.  count number of samples in each run using the manifest\n\ntemp = read_csv(args_run_manifest_path) %>% \nmutate(sample_num = n())\n\nnumber_of_samples = temp$sample_num[1]\n\nnumber_of_samples\n\n#3.  calculate average number of qualified reads per sample\n\nmean_qualified_reads = sum_pass_filter_reads / number_of_samples\n\n#4.  Set B2M min (inclusive) read numbers to min in factoring table\n\nfactoring_table = read_csv(args_scaling_table) %>%\nfilter(min_avg_reads_boundary <= mean_qualified_reads & max_avg_reads_boundary >= mean_qualified_reads)\n\n\n# COMMAND ----------\n\n#+ read in filtering criteria, echo=FALSE, include = FALSE\nfiltering_criteria = read_tsv(args_pos_neg_filtering_criteria_path) %>% \nmap_if(is.factor, as.character) %>% \nas_tibble() %>%  \nrename(type_id = TYPE) %>%\nmutate(factored_min_reads_per_type = factoring_table$HPV_scaling_factor * Min_reads_per_type)\nglimpse(filtering_criteria)\n\n\n# COMMAND ----------\n\n#+ create pn matrix, echo=FALSE, include = FALSE,\n\n# read in hpv_types and left join with filtering criteria csv\npn_matrix = hpv_types %>% \ngather(\"type_id\", \"read_counts\", starts_with(\"HPV\")) %>%\nleft_join(filtering_criteria) %>%\n\n# calculate total reads and individual type percentage\ngroup_by(barcode) %>% \nmutate(hpv_total_reads = sum(read_counts)) %>% \nungroup() %>% \nmutate(type_perc = read_counts / hpv_total_reads) %>% \n\n# set b2m_status\nmutate(b2m_status = ifelse((B2M >= factoring_table$B2M_min) | hpv_total_reads >=1000, \"pass\", \"fail\")) %>% \n\n# now we set type status to positve and sequentially set to negative if any filters are failed\nmutate(type_status = \"pos\") %>% \nmutate(type_status = ifelse(hpv_total_reads >= 1000, type_status, \"neg\"))  %>% \nmutate(type_status = ifelse(read_counts >= factored_min_reads_per_type, type_status, \"neg\"))  %>% \nmutate(type_status = ifelse(type_perc >= Min_type_percent_hpv_reads, type_status, \"neg\")) %>%\narrange(barcode) %>%\n\n# spread back into matrix format\nmutate(Human_Control = ifelse(b2m_status == \"fail\", \"failed_to_amplify\", b2m_status)) %>%\nselect(-b2m_status, -Min_reads_per_type, -factored_min_reads_per_type, -hpv_total_reads, -type_perc, -Min_type_percent_hpv_reads, -read_counts, -B2M) %>%\nmutate(type_id = factor(type_id,levels=filtering_criteria$type_id)) %>% # This keeps the proper column order\nspread(type_id, type_status, fill=\"neg\") %>%\narrange(barcode)\n\n#+ echo=FALSE, include =FALSE, eval=FALSE\ndisplay(pn_matrix)\n\n# COMMAND ----------\n\n#' ## Expected Control Results\n\n#+ expected control results, results='asis', echo=FALSE, message=FALSE\n\n# 1.  read in control defs\n\ncontrol_defs = read_csv(args_control_defs) %>% \nmap_if(is.factor, as.character) %>% \nas_tibble() %>%\nungroup() %>%\ngather(\"type\", \"status\", -Control_Code) %>%\narrange(Control_Code) \n\n# 2.  merge pn matrix with control defs\n\ncontrol_results = pn_matrix %>%\nungroup() %>%\nmap_if(is.factor, as.character) %>% \nas_tibble() %>%\nselect(Owner_Sample_ID, starts_with(\"HPV\")) %>%\ngather(\"type\", \"status\", -Owner_Sample_ID) %>%\nfuzzy_join(control_defs, mode = \"inner\", by=c(\"Owner_Sample_ID\" = \"Control_Code\"), match_fun = function(x, y) str_detect(x, fixed(y, ignore_case=TRUE))) %>%\nfilter(type.x == type.y) %>%\narrange(Owner_Sample_ID, type.y) %>%\nselect(Owner_Sample_ID, Control_Code, type = type.x, status_pn = status.x, status_control = status.y) %>%\n           \n# 3. calculate result\n\nmutate(control_value = ifelse(status_pn == status_control, 0, 1)) %>%\ngroup_by(Owner_Sample_ID) %>%\nmutate(failed_type_sum = sum(control_value)) %>%\nungroup() %>%\nselect(Control_Code, Owner_Sample_ID, failed_type_sum) %>%\ndistinct() %>%\nmutate(control_result = ifelse(failed_type_sum==0, \"pass\", \"fail\")) %>%\nselect(-failed_type_sum) %>%\narrange(Control_Code, Owner_Sample_ID)\n           \n#+ print expected control results, results='asis', echo=FALSE, message=FALSE\n\npandoc.table(control_results %>% select(-Control_Code), style = \"multiline\", justify=c(\"right\", \"left\"),  caption = \"Expected Control Results - Pass and Fail\", use.hyphening=TRUE, split.cells=30)\n           \nif(length((control_results %>% select(-Control_Code) %>% filter(control_result == \"fail\"))$control_result) > 2){\n           \npandoc.table(control_results %>% select(-Control_Code) %>% filter(control_result == \"fail\"), style = \"multiline\", justify=c(\"right\", \"left\"),  caption = \"Expected Control Results - Failed controls\", use.hyphening=TRUE, split.cells=30)\n           \n  }  else {\n  \n  \nprint(\"There were no control failures\")  \n  \n}   \n\n# COMMAND ----------\n\n#' ## Qualified Barcode Reads Histogram\n\n#+ qualified barcode reads histogram, echo=FALSE, message=FALSE, warning=FALSE\n\nggplot(read_metrics %>% rename(`qualifed reads percentage` = qualified_perc), aes(barcode_1, `qualifed reads percentage`)) +\ngeom_bar(stat=\"identity\", aes(fill=`qualifed reads percentage`)) +\ncoord_flip() +\nlabs(title = \"Qualifed Barcode 1 Reads\")\n\n# COMMAND ----------\n\n#+ samples only matrix, echo=FALSE, message=FALSE, warning=FALSE\n\nsamples_only_matrix = pn_matrix %>%\nanti_join(control_results)\n\n\n# COMMAND ----------\n\n#+ failed samples matrix, echo=FALSE, message=FALSE, warning=FALSE\n\nfailed_samples_matrix = samples_only_matrix  %>%\nfilter(Human_Control == \"failed_to_amplify\")\n\n# COMMAND ----------\n\n#+ control matrix, echo=FALSE, message=FALSE, warning=FALSE\n\ncontrol_matrix = control_results %>%\nleft_join(pn_matrix) %>%\narrange(control_result, Control_Code)\n\n# COMMAND ----------\n\nsamples_only_matrix\n\n# COMMAND ----------\n\npn_matrix\n\n# COMMAND ----------\n\n#+ write all csv files, echo=FALSE, include = FALSE\n\npn_matrix %>%\ngroup_by(Project) %>%\ndo({\ntemp = . \nwrite_csv(samples_only_matrix, paste(temp$Project[1], temp$Assay_Batch_Code[1], \"samples_only_matrix.csv\", sep=\"_\"))\n})\n\n#write_csv(read_metrics, paste0(pn_matrix$Assay_Batch_Code[1], \"_read_metrics.csv\")) #need to add \"total_reads\" column to the left of B2M\nwrite_csv(hpv_types, paste0(pn_matrix$Assay_Batch_Code[1], \"_hpv_read_counts_matrix.csv\"))\nwrite_csv(control_matrix, paste0(pn_matrix$Assay_Batch_Code[1], \"_control_results.csv\")) \nwrite_csv(failed_samples_matrix, paste0(pn_matrix$Assay_Batch_Code[1], \"_failed_samples_matrix.csv\"))\nwrite_csv(pn_matrix, paste0(pn_matrix$Assay_Batch_Code[1], \"_full_pn_matrix.csv\"))\n\n#+ eval=FALSE, include=FALSE\nsystem(\"ls *csv\")"
              }
            ]
          },
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "sbg:revisionNotes": "added rm filter.json",
        "stdin": "",
        "temporaryFailCodes": [],
        "sbg:projectName": "cgrHPV",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedOn": 1510342185,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "Copy of dave/cgrhpv/hpv-typing-report/129",
            "sbg:revision": 0
          },
          {
            "sbg:modifiedOn": 1510342320,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "changed label to illumina",
            "sbg:revision": 1
          },
          {
            "sbg:modifiedOn": 1510342632,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "removed some inputs",
            "sbg:revision": 2
          },
          {
            "sbg:modifiedOn": 1510342908,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added R script",
            "sbg:revision": 3
          },
          {
            "sbg:modifiedOn": 1510503263,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "illumina report finishes on db",
            "sbg:revision": 4
          },
          {
            "sbg:modifiedOn": 1510504962,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "fixed display issue",
            "sbg:revision": 5
          },
          {
            "sbg:modifiedOn": 1510505488,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "removed thumbnail code",
            "sbg:revision": 6
          },
          {
            "sbg:modifiedOn": 1510603784,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added more outputs",
            "sbg:revision": 7
          },
          {
            "sbg:modifiedOn": 1510715360,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added contig collapse",
            "sbg:revision": 8
          },
          {
            "sbg:modifiedOn": 1510757699,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "fixing read metric and b2m issues",
            "sbg:revision": 9
          },
          {
            "sbg:modifiedOn": 1510769226,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "adjusted filtering criteria",
            "sbg:revision": 10
          },
          {
            "sbg:modifiedOn": 1510806163,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "fixing scaling",
            "sbg:revision": 11
          },
          {
            "sbg:modifiedOn": 1510806575,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "fixing failed sample matrix output",
            "sbg:revision": 12
          },
          {
            "sbg:modifiedOn": 1520631118,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "removed reads.csv output - added project code to other csvs",
            "sbg:revision": 13
          },
          {
            "sbg:modifiedOn": 1520649585,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "removed files now in docker container",
            "sbg:revision": 14
          },
          {
            "sbg:modifiedOn": 1520700059,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "removed hpv_types ouput...pos_neg_matrix is an array now",
            "sbg:revision": 15
          },
          {
            "sbg:modifiedOn": 1520971760,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added cp to typeseqer o",
            "sbg:revision": 16
          },
          {
            "sbg:modifiedOn": 1520971806,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "add cp to /typeSeqerFiles",
            "sbg:revision": 17
          },
          {
            "sbg:modifiedOn": 1520989616,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "correcting cp to typeseqer",
            "sbg:revision": 18
          },
          {
            "sbg:modifiedOn": 1520999606,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "add cp *csv *pdf",
            "sbg:revision": 19
          },
          {
            "sbg:modifiedOn": 1521087651,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added rm * split.json",
            "sbg:revision": 20
          },
          {
            "sbg:modifiedOn": 1521159965,
            "sbg:modifiedBy": "dave",
            "sbg:revisionNotes": "added rm filter.json",
            "sbg:revision": 21
          }
        ],
        "successCodes": [],
        "inputs": [
          {
            "required": false,
            "streamable": false,
            "type": [
              "null",
              "File"
            ],
            "id": "#hpv_types_json",
            "default": ""
          },
          {
            "required": false,
            "streamable": false,
            "type": [
              "null",
              "File"
            ],
            "id": "#run_manifest",
            "default": ""
          },
          {
            "required": false,
            "streamable": false,
            "type": [
              "null",
              "File"
            ],
            "id": "#bam_header_file",
            "default": ""
          },
          {
            "type": [
              "null",
              "File"
            ],
            "id": "#control_defs"
          }
        ],
        "$namespaces": {
          "sbg": "https://sevenbridges.com"
        },
        "sbg:modifiedBy": "dave",
        "id": "https://api.sbgenomics.com/v2/apps/dave/cgrhpv/illumina-typeseqer-report/21/raw/",
        "sbg:image_url": null,
        "stdout": "",
        "sbg:id": "dave/cgrhpv/illumina-typeseqer-report/21",
        "sbg:contributors": [
          "dave"
        ],
        "sbg:createdOn": 1510342185,
        "outputs": [
          {
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#bam_header_file",
              "glob": {
                "script": "\"*pn_matrix.csv\"",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              }
            },
            "type": [
              "null",
              {
                "items": "File",
                "type": "array"
              }
            ],
            "id": "#pos_neg_matrix"
          },
          {
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#run_manifest",
              "glob": {
                "script": "'*pdf'",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              }
            },
            "type": [
              "null",
              "File"
            ],
            "id": "#pdf_report"
          },
          {
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#hpv_types_json",
              "glob": {
                "script": "'*control_results.csv'",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              }
            },
            "type": [
              "null",
              "File"
            ],
            "id": "#control_matrix"
          },
          {
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#hpv_types_json",
              "glob": {
                "script": "\"*samples_only_matrix.csv\"",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              }
            },
            "type": [
              "null",
              "File"
            ],
            "id": "#samples_only_matrix"
          },
          {
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#hpv_types_json",
              "glob": {
                "script": "\"*failed_samples_matrix.csv\"",
                "class": "Expression",
                "engine": "#cwl-js-engine"
              }
            },
            "type": [
              "null",
              "File"
            ],
            "id": "#failed_samples_matrix"
          }
        ],
        "sbg:project": "dave/cgrhpv",
        "class": "CommandLineTool",
        "sbg:createdBy": "dave",
        "cwlVersion": "sbg:draft-2",
        "label": "illumina_typeseqer_report",
        "arguments": [
          {
            "position": 99,
            "valueFrom": "1>&2",
            "separate": false
          }
        ],
        "hints": [
          {
            "class": "DockerRequirement",
            "dockerPull": "cgrlab/typeseqer:latest"
          },
          {
            "class": "sbg:CPURequirement",
            "value": 1
          },
          {
            "class": "sbg:MemRequirement",
            "value": 2000
          }
        ],
        "sbg:validationErrors": [],
        "sbg:publisher": "sbg",
        "sbg:latestRevision": 21,
        "sbg:modifiedOn": 1521159965,
        "sbg:job": {
          "inputs": {
            "run_manifest": {
              "secondaryFiles": [],
              "class": "File",
              "size": 0,
              "path": "path/to/run_manifest.csv"
            },
            "bam_header_file": {
              "secondaryFiles": [],
              "class": "File",
              "size": 0,
              "path": "/path/to/header_file.txt"
            },
            "control_defs": {
              "secondaryFiles": [],
              "class": "File",
              "size": 0,
              "path": "/path/to/control_defs.csv"
            },
            "hpv_types_json": {
              "secondaryFiles": [],
              "class": "File",
              "size": 0,
              "path": "path/to/merged_hpv_types.json"
            }
          },
          "allocatedResources": {
            "cpu": 1,
            "mem": 2000
          }
        },
        "sbg:revision": 21
      },
      "inputs": [
        {
          "source": [
            "#cat_json.merged_json"
          ],
          "id": "#illumina_typeseqer_report.hpv_types_json"
        },
        {
          "source": [
            "#run_manifest"
          ],
          "id": "#illumina_typeseqer_report.run_manifest"
        },
        {
          "source": [
            "#SAMtools_extract_SAM_BAM_header.output_header_file"
          ],
          "id": "#illumina_typeseqer_report.bam_header_file"
        },
        {
          "source": [
            "#control_defs"
          ],
          "id": "#illumina_typeseqer_report.control_defs"
        }
      ],
      "id": "#illumina_typeseqer_report",
      "sbg:y": 303.35062628570694
    }
  ],
  "sbg:revisionNotes": "illumina_typeseqer_report \n\"added rm filter.json\"",
  "sbg:appVersion": [
    "sbg:draft-2"
  ],
  "sbg:projectName": "cgrHPV",
  "sbg:publisher": "sbg",
  "sbg:image_url": "https://igor.sbgenomics.com/ns/brood/images/dave/cgrhpv/hpv-typing-illumina-workflow/125.png",
  "sbg:contributors": [
    "sarah",
    "dave"
  ],
  "sbg:createdOn": 1492530729,
  "class": "Workflow",
  "requirements": [],
  "sbg:createdBy": "dave",
  "hints": [
    {
      "class": "sbg:AWSInstanceType",
      "value": "c4.8xlarge;ebs-gp2;700"
    },
    {
      "class": "sbg:maxNumberOfParallelInstances",
      "value": "4"
    }
  ],
  "sbg:latestRevision": 125,
  "sbg:validationErrors": [],
  "sbg:canvas_y": 74,
  "sbg:categories": [
    "hpv_typing"
  ],
  "id": "https://api.sbgenomics.com/v2/apps/dave/cgrhpv/hpv-typing-illumina-workflow/125/raw/",
  "sbg:revisionsInfo": [
    {
      "sbg:modifiedOn": 1492530729,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "Copy of dave/cgrhpv/hpv-typing-workflow/80",
      "sbg:revision": 0
    },
    {
      "sbg:modifiedOn": 1492531022,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 1
    },
    {
      "sbg:modifiedOn": 1492531743,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 2
    },
    {
      "sbg:modifiedOn": 1492531793,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "default instance",
      "sbg:revision": 3
    },
    {
      "sbg:modifiedOn": 1492532341,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "just sambamba view",
      "sbg:revision": 4
    },
    {
      "sbg:modifiedOn": 1492539957,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "updated run processor app",
      "sbg:revision": 5
    },
    {
      "sbg:modifiedOn": 1492539998,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed report app",
      "sbg:revision": 6
    },
    {
      "sbg:modifiedOn": 1492541026,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "\"removing references to A1 barcode\"",
      "sbg:revision": 7
    },
    {
      "sbg:modifiedOn": 1492541506,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added scatter to run processor app",
      "sbg:revision": 8
    },
    {
      "sbg:modifiedOn": 1492542324,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 9
    },
    {
      "sbg:modifiedOn": 1492542350,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 10
    },
    {
      "sbg:modifiedOn": 1492547750,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "c4.8xlarge",
      "sbg:revision": 11
    },
    {
      "sbg:modifiedOn": 1492634532,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added hpv_typing report back i with illumina capability",
      "sbg:revision": 12
    },
    {
      "sbg:modifiedOn": 1492634752,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "unlocked report params",
      "sbg:revision": 13
    },
    {
      "sbg:modifiedOn": 1492635208,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "\"corrected csv.xls output globs\"",
      "sbg:revision": 14
    },
    {
      "sbg:modifiedOn": 1492635371,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 15
    },
    {
      "sbg:modifiedOn": 1492687776,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "hpv typing report \"fixing get args\"",
      "sbg:revision": 16
    },
    {
      "sbg:modifiedOn": 1492687838,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 17
    },
    {
      "sbg:modifiedOn": 1492688955,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "sambamba view unlocked nthreads",
      "sbg:revision": 18
    },
    {
      "sbg:modifiedOn": 1492689125,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "sambamba view - removed json output node",
      "sbg:revision": 19
    },
    {
      "sbg:modifiedOn": 1492689778,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing report - \"fixing get args again\"",
      "sbg:revision": 20
    },
    {
      "sbg:modifiedOn": 1492691192,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing report - \"added cat get_args.R for debug\"",
      "sbg:revision": 21
    },
    {
      "sbg:modifiedOn": 1492691487,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing_report - \"added print lines to help debug\"",
      "sbg:revision": 22
    },
    {
      "sbg:modifiedOn": 1492691724,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing report \"fixing space after - BC2\"",
      "sbg:revision": 23
    },
    {
      "sbg:modifiedOn": 1492695746,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing report \"fixing get args again\"",
      "sbg:revision": 24
    },
    {
      "sbg:modifiedOn": 1492698050,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing report \"adding write to std.err stuff to hpv_typing_report.R\"",
      "sbg:revision": 25
    },
    {
      "sbg:modifiedOn": 1492699291,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing report \"fixing get_args.R again\"",
      "sbg:revision": 26
    },
    {
      "sbg:modifiedOn": 1492702401,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "\"fixing debut to std.err\"",
      "sbg:revision": 27
    },
    {
      "sbg:modifiedOn": 1492714435,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 28
    },
    {
      "sbg:modifiedOn": 1492714575,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "\"added bam header input\"",
      "sbg:revision": 29
    },
    {
      "sbg:modifiedOn": 1492714771,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added sam tools extract header",
      "sbg:revision": 30
    },
    {
      "sbg:modifiedOn": 1492716781,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "typing_report \"added require stringr package\"",
      "sbg:revision": 31
    },
    {
      "sbg:modifiedOn": 1494508291,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed sambamba view filter parameter",
      "sbg:revision": 32
    },
    {
      "sbg:modifiedOn": 1494509971,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "save page_size is now locked at 10000",
      "sbg:revision": 33
    },
    {
      "sbg:modifiedOn": 1495049175,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 34
    },
    {
      "sbg:modifiedOn": 1495053100,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 35
    },
    {
      "sbg:modifiedOn": 1495053910,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 36
    },
    {
      "sbg:modifiedOn": 1510167803,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added bwa-mem",
      "sbg:revision": 37
    },
    {
      "sbg:modifiedOn": 1510168918,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 38
    },
    {
      "sbg:modifiedOn": 1510169007,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "corrected outputs",
      "sbg:revision": 39
    },
    {
      "sbg:modifiedOn": 1510169659,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed tar -z",
      "sbg:revision": 40
    },
    {
      "sbg:modifiedOn": 1510172125,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\"correcting fasta index command\"",
      "sbg:revision": 41
    },
    {
      "sbg:modifiedOn": 1510173103,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle (\n\"removed some extra commands\"",
      "sbg:revision": 42
    },
    {
      "sbg:modifiedOn": 1510173250,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle\n\"putting commands back in\"",
      "sbg:revision": 43
    },
    {
      "sbg:modifiedOn": 1510173331,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "exposed threads",
      "sbg:revision": 44
    },
    {
      "sbg:modifiedOn": 1510173969,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed select first file in array and sambamba view is not scattered now",
      "sbg:revision": 45
    },
    {
      "sbg:modifiedOn": 1510176016,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed some apps and added split_json app",
      "sbg:revision": 46
    },
    {
      "sbg:modifiedOn": 1510251174,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added illumina splitter",
      "sbg:revision": 47
    },
    {
      "sbg:modifiedOn": 1510251693,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor (Revision 9) which has a new update available.\nDo you want to update this node?\n\nRevision note:\n\n\"added html out\"",
      "sbg:revision": 48
    },
    {
      "sbg:modifiedOn": 1510251716,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 49
    },
    {
      "sbg:modifiedOn": 1510252720,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor\n\"renamed args.R\"",
      "sbg:revision": 50
    },
    {
      "sbg:modifiedOn": 1510252898,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor \n\"removed some args from command line\"",
      "sbg:revision": 51
    },
    {
      "sbg:modifiedOn": 1510253489,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "exposed json_spitter number and page size in the other app",
      "sbg:revision": 52
    },
    {
      "sbg:modifiedOn": 1510257656,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added merge hpv types",
      "sbg:revision": 53
    },
    {
      "sbg:modifiedOn": 1510343085,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added typeseqer report",
      "sbg:revision": 54
    },
    {
      "sbg:modifiedOn": 1510343174,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added sam tools extrac sam/bam header",
      "sbg:revision": 55
    },
    {
      "sbg:modifiedOn": 1510503415,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report (Revision 3) which has a new update available.\nDo you want to update this node?\n\nRevision note:\n\n\"illumina report finishes on db\"",
      "sbg:revision": 56
    },
    {
      "sbg:modifiedOn": 1510505544,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"removed thumbnail code\"",
      "sbg:revision": 57
    },
    {
      "sbg:modifiedOn": 1510583840,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added bwa index",
      "sbg:revision": 58
    },
    {
      "sbg:modifiedOn": 1510606517,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added more report outputs",
      "sbg:revision": 59
    },
    {
      "sbg:modifiedOn": 1510615533,
      "sbg:modifiedBy": "sarah",
      "sbg:revisionNotes": "BWA parameters match revision 19 of BWA_Typing_FINAL from April 2017",
      "sbg:revision": 60
    },
    {
      "sbg:modifiedOn": 1510711613,
      "sbg:modifiedBy": "sarah",
      "sbg:revisionNotes": "turned off soft clipping",
      "sbg:revision": 61
    },
    {
      "sbg:modifiedOn": 1510715589,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"added contig collapse\"",
      "sbg:revision": 62
    },
    {
      "sbg:modifiedOn": 1510721279,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 63
    },
    {
      "sbg:modifiedOn": 1510757738,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report\n\"fixing read metric and b2m issues\"",
      "sbg:revision": 64
    },
    {
      "sbg:modifiedOn": 1510769262,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"adjusted filtering criteria\"",
      "sbg:revision": 65
    },
    {
      "sbg:modifiedOn": 1510769328,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "max number of parallel instances is 4",
      "sbg:revision": 66
    },
    {
      "sbg:modifiedOn": 1510775805,
      "sbg:modifiedBy": "sarah",
      "sbg:revisionNotes": "soft clipping on",
      "sbg:revision": 67
    },
    {
      "sbg:modifiedOn": 1510792478,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor \n\"fixing barcode orientation\"",
      "sbg:revision": 68
    },
    {
      "sbg:modifiedOn": 1510792705,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor\n\"fixing barcodes\"",
      "sbg:revision": 69
    },
    {
      "sbg:modifiedOn": 1510799376,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor \n\"added fwd rev back in\"",
      "sbg:revision": 70
    },
    {
      "sbg:modifiedOn": 1510806227,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report\n\"fixing scaling\"",
      "sbg:revision": 71
    },
    {
      "sbg:modifiedOn": 1510806643,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"fixing failed sample matrix output\"",
      "sbg:revision": 72
    },
    {
      "sbg:modifiedOn": 1520368695,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "hardcoded true for bwa smart pairing",
      "sbg:revision": 73
    },
    {
      "sbg:modifiedOn": 1520368770,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "hardcoded filter out secondary alignments",
      "sbg:revision": 74
    },
    {
      "sbg:modifiedOn": 1520368851,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "bwa hardcoded threads and ram stuff",
      "sbg:revision": 75
    },
    {
      "sbg:modifiedOn": 1520369003,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "sambamba harcoded threads and ram",
      "sbg:revision": 76
    },
    {
      "sbg:modifiedOn": 1520369114,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "hardcoded number of lines per json split",
      "sbg:revision": 77
    },
    {
      "sbg:modifiedOn": 1520369342,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "harcoded page size",
      "sbg:revision": 78
    },
    {
      "sbg:modifiedOn": 1520387442,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\n\"removed pipe commands at end\"",
      "sbg:revision": 79
    },
    {
      "sbg:modifiedOn": 1520391278,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle\n\"test tar command\"",
      "sbg:revision": 80
    },
    {
      "sbg:modifiedOn": 1520391765,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 81
    },
    {
      "sbg:modifiedOn": 1520394932,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 82
    },
    {
      "sbg:modifiedOn": 1520396115,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "bwa version 0",
      "sbg:revision": 83
    },
    {
      "sbg:modifiedOn": 1520396870,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 84
    },
    {
      "sbg:modifiedOn": 1520447242,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 85
    },
    {
      "sbg:modifiedOn": 1520448557,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 86
    },
    {
      "sbg:modifiedOn": 1520449523,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\n\"added and ending quote\"",
      "sbg:revision": 87
    },
    {
      "sbg:modifiedOn": 1520450318,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle\n\n\"on tar an bwa",
      "sbg:revision": 88
    },
    {
      "sbg:modifiedOn": 1520450910,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle\n\"moved args around\"",
      "sbg:revision": 89
    },
    {
      "sbg:modifiedOn": 1520451267,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 90
    },
    {
      "sbg:modifiedOn": 1520454182,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\"aligned.bam\"",
      "sbg:revision": 91
    },
    {
      "sbg:modifiedOn": 1520455767,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added sambamba sort",
      "sbg:revision": 92
    },
    {
      "sbg:modifiedOn": 1520455901,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 93
    },
    {
      "sbg:modifiedOn": 1520457532,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\"put many commands back in\"",
      "sbg:revision": 94
    },
    {
      "sbg:modifiedOn": 1520458478,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 95
    },
    {
      "sbg:modifiedOn": 1520458752,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 96
    },
    {
      "sbg:modifiedOn": 1520533243,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 97
    },
    {
      "sbg:modifiedOn": 1520606901,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "turned off smart pairing",
      "sbg:revision": 98
    },
    {
      "sbg:modifiedOn": 1520631215,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added project names to csv outputs",
      "sbg:revision": 99
    },
    {
      "sbg:modifiedOn": 1520649918,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"removed files now in docker container\"",
      "sbg:revision": 100
    },
    {
      "sbg:modifiedOn": 1520650551,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 101
    },
    {
      "sbg:modifiedOn": 1520650914,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor \n\"barcode file is now in the docker\"",
      "sbg:revision": 102
    },
    {
      "sbg:modifiedOn": 1520652903,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added hpv typeseqer reference app",
      "sbg:revision": 103
    },
    {
      "sbg:modifiedOn": 1520700139,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"removed hpv_types ouput...pos_neg_matrix is an array now\"",
      "sbg:revision": 104
    },
    {
      "sbg:modifiedOn": 1520716152,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "corrected some command line in bwa mem",
      "sbg:revision": 105
    },
    {
      "sbg:modifiedOn": 1520716482,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "corrected bwa index command line",
      "sbg:revision": 106
    },
    {
      "sbg:modifiedOn": 1520716822,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\"fixing sambamba command line\"",
      "sbg:revision": 107
    },
    {
      "sbg:modifiedOn": 1520717784,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "SAMtools extract SAM/BAM header \n\"cgrlab/typeseqer:latest\"",
      "sbg:revision": 108
    },
    {
      "sbg:modifiedOn": 1520719010,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed output header in bwa mem",
      "sbg:revision": 109
    },
    {
      "sbg:modifiedOn": 1520741498,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "BWA MEM Bundle \n\n\"removed samblaster\"",
      "sbg:revision": 110
    },
    {
      "sbg:modifiedOn": 1520741988,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "add ram and thread parameters for bwa",
      "sbg:revision": 111
    },
    {
      "sbg:modifiedOn": 1520743448,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "put sambamba view json back in",
      "sbg:revision": 112
    },
    {
      "sbg:modifiedOn": 1520743677,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": null,
      "sbg:revision": 113
    },
    {
      "sbg:modifiedOn": 1520743925,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "Sambamba View \ntypeseqer docker\"",
      "sbg:revision": 114
    },
    {
      "sbg:modifiedOn": 1520820514,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed fasta app",
      "sbg:revision": 115
    },
    {
      "sbg:modifiedOn": 1520824176,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "updated json_splitter and brought back fasta ref app",
      "sbg:revision": 116
    },
    {
      "sbg:modifiedOn": 1520827682,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "removed sam header",
      "sbg:revision": 117
    },
    {
      "sbg:modifiedOn": 1520877020,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina typing run processor\n\"put barcode back in\"",
      "sbg:revision": 118
    },
    {
      "sbg:modifiedOn": 1520877072,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "bam header file is now an input",
      "sbg:revision": 119
    },
    {
      "sbg:modifiedOn": 1520971873,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"add cp to /typeSeqerFiles\"",
      "sbg:revision": 120
    },
    {
      "sbg:modifiedOn": 1520991200,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"correcting cp to typeseqer\"",
      "sbg:revision": 121
    },
    {
      "sbg:modifiedOn": 1520999660,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"add cp *csv *pdf\"",
      "sbg:revision": 122
    },
    {
      "sbg:modifiedOn": 1520999785,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "added back in samtools sam/bam extract header",
      "sbg:revision": 123
    },
    {
      "sbg:modifiedOn": 1521087779,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"added rm * split.json\"",
      "sbg:revision": 124
    },
    {
      "sbg:modifiedOn": 1521166125,
      "sbg:modifiedBy": "dave",
      "sbg:revisionNotes": "illumina_typeseqer_report \n\"added rm filter.json\"",
      "sbg:revision": 125
    }
  ],
  "sbg:modifiedOn": 1521166125,
  "$namespaces": {
    "sbg": "https://sevenbridges.com"
  },
  "sbg:modifiedBy": "dave",
  "sbg:canvas_x": 97,
  "sbg:toolkit": "hpv_typing",
  "outputs": [
    {
      "label": "pos_neg_matrix",
      "source": [
        "#illumina_typeseqer_report.pos_neg_matrix"
      ],
      "type": [
        "null",
        "File"
      ],
      "sbg:x": 1286.068516083257,
      "required": false,
      "id": "#pos_neg_matrix",
      "sbg:y": 212.30770111083996,
      "sbg:includeInPorts": true
    },
    {
      "label": "pdf_report",
      "source": [
        "#illumina_typeseqer_report.pdf_report"
      ],
      "type": [
        "null",
        "File"
      ],
      "sbg:x": 1355.1282357802743,
      "required": false,
      "id": "#pdf_report",
      "sbg:y": 396.75216706593926,
      "sbg:includeInPorts": true
    },
    {
      "label": "samples_only_matrix",
      "source": [
        "#illumina_typeseqer_report.samples_only_matrix"
      ],
      "type": [
        "null",
        "File"
      ],
      "sbg:x": 1158.8890991446146,
      "required": false,
      "id": "#samples_only_matrix",
      "sbg:y": 82.56411499948972,
      "sbg:includeInPorts": true
    },
    {
      "label": "failed_samples_matrix",
      "source": [
        "#illumina_typeseqer_report.failed_samples_matrix"
      ],
      "type": [
        "null",
        "File"
      ],
      "sbg:x": 1217.1796915319626,
      "required": false,
      "id": "#failed_samples_matrix",
      "sbg:y": 505.8119881176616,
      "sbg:includeInPorts": true
    },
    {
      "label": "control_matrix",
      "source": [
        "#illumina_typeseqer_report.control_matrix"
      ],
      "type": [
        "null",
        "File"
      ],
      "sbg:x": 1099.9999576792309,
      "required": false,
      "id": "#control_matrix",
      "sbg:y": 643.3333505230177,
      "sbg:includeInPorts": true
    }
  ],
  "sbg:project": "dave/cgrhpv",
  "cwlVersion": "sbg:draft-2",
  "label": "hpv typing illumina workflow",
  "inputs": [
    {
      "label": "input_reads",
      "type": [
        {
          "items": "File",
          "type": "array",
          "name": "input_reads"
        }
      ],
      "sbg:x": -245.10125359832634,
      "sbg:fileTypes": "FASTQ, FASTQ.GZ, FQ, FQ.GZ",
      "id": "#input_reads",
      "sbg:y": 461.0526659884442
    },
    {
      "label": "control_defs",
      "type": [
        "null",
        "File"
      ],
      "sbg:x": 487.35075453284014,
      "sbg:y": 319.9148560482775,
      "id": "#control_defs"
    },
    {
      "label": "run_manifest",
      "type": [
        "null",
        "File"
      ],
      "sbg:x": 721.3676675442942,
      "sbg:y": -14.957252371710172,
      "id": "#run_manifest"
    },
    {
      "label": "barcode_file",
      "type": [
        "null",
        "File"
      ],
      "id": "#barcode_file",
      "sbg:y": -4.615409128765847,
      "sbg:x": 256.92303579657454
    }
  ],
  "sbg:canvas_zoom": 0.6499999999999997,
  "sbg:revision": 125
}