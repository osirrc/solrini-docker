# OSIRRC Docker Image for Solrini

[![Build Status](https://travis-ci.com/osirrc/solrini-docker.svg?branch=master)](https://travis-ci.com/osirrc/solrini-docker)
[![Docker Build Status](https://img.shields.io/docker/cloud/build/osirrc2019/solrini.svg)](https://hub.docker.com/r/osirrc2019/solrini)
[![DOI](https://zenodo.org/badge/182200684.svg)](https://zenodo.org/badge/latestdoi/182200684)

[**Ryan Clancy**](https://github.com/r-clancy/) and [**Jimmy Lin**](https://github.com/lintool/)

This is the docker image for the [Anserini](http://anserini.io/) toolkit (v0.5.1), with Solr indexing, conforming to the [OSIRRC jig](https://github.com/osirrc/jig/) for the [Open-Source IR Replicability Challenge (OSIRRC) at SIGIR 2019](https://osirrc.github.io/osirrc2019/).
This image is available on [Docker Hub](https://hub.docker.com/r/osirrc2019/solrini).
The [OSIRRC 2019 image library](https://github.com/osirrc/osirrc2019-library) contains a log of successful executions of this image.

+ Supported test collections: `robust04`, `core17`, `core18` (newswire); `gov2`, `cw09b`, `cw12b` (web)
+ Supported hooks: `init`, `index`, `interact`

The search results are the same Anserini, thus we use those results.

## Quick Start

The following `jig` command can be used to index TREC disks 4/5 for `robust04`:

```
python run.py prepare \
  --repo osirrc2019/solrini \
  --tag <tag> \
  --collections robust04=/path/to/disk45=trectext \
  --opts solr_memory=8G solr_version 8.0.0
```

The following `jig` command can be used to perform a retrieval run on the collection with the `robust04` test collection.

```
python run.py interact \
  --repo osirrc2019/solrini \
  --tag <tag>
```

Where `<tag>` is a valid [tag](https://github.com/osirrc/solrini-docker/tags).

Use `docker ps` to see the container running with a port mapping that looks like `0.0.0.0:[port]->8983/tcp`. Navigate to `0.0.0.0:[port]` in your web browser to view Solr.

## Retrieval Methods

The Anserini image supports the following retrieval methods:

+ **BM25**: k1=0.9, b=0.4 (Robertson et al., 1995)
+ **QL** (query likelihood with Dirichlet smooth): mu=1000 (Zhai and Lafferty, 2001)
+ **+RM3** (RM3 variant of relevance models, applied on top of initial BM25 or QL results): [exact parameter settings](https://github.com/castorini/anserini/blob/master/src/main/java/io/anserini/search/SearchArgs.java) (Abdul-Jaleel et al., 2004)
+ **+Ax** (Semantic term matching in the axiomatic framework, applied on top of initial BM25 or QL results): [exact parameter settings](https://github.com/castorini/anserini/blob/master/src/main/java/io/anserini/search/SearchArgs.java) (Fang and Zhai, 2006)

## Expected Results

The following numbers should be able to be re-produced using the scripts provided in the [bin](bin) directory.

### robust04

MAP                                     | BM25      | +RM3      | +Ax       | QL        | +RM3      | +Ax       |
:---------------------------------------|-----------|-----------|-----------|-----------|-----------|-----------|
[TREC 2004 Robust Track Topics](http://trec.nist.gov/data/robust/04.testset.gz)| 0.2531    | 0.2903    | 0.2895    | 0.2467    | 0.2747    | 0.2774    |

### core17

MAP                                     | BM25      | +RM3      | +Ax       | QL        | +RM3      | +Ax       |
:---------------------------------------|-----------|-----------|-----------|-----------|-----------|-----------|
[TREC 2017 Common Core Track Topics](https://trec.nist.gov/data/core/core_nist.txt)| 0.2087    | 0.2823    | 0.2787    | 0.2032    | 0.2606    | 0.2613    |

### core18

MAP                                     | BM25      | +RM3  | +Ax   | QL        | +RM3    | +Ax     |
:---------------------------------------|-----------|-----------|-----------|-----------|-----------|-----------|
[TREC 2018 Common Core Track Topics](https://trec.nist.gov/data/core/topics2018.txt)| 0.2495    | 0.3136    | 0.2920    | 0.2526    | 0.3073    | 0.2966    |

### gov2

MAP                                     | BM25      | +RM3      | +Ax       | QL        | +RM3      | +Ax       |
:---------------------------------------|-----------|-----------|-----------|-----------|-----------|-----------|
[TREC 2004 Terabyte Track: Topics 701-750](http://trec.nist.gov/data/terabyte04.html)| 0.2689    | 0.2844    | 0.2665    | 0.2681    | 0.2708    | 0.2666    |
[TREC 2005 Terabyte Track: Topics 751-800](http://trec.nist.gov/data/terabyte05.html)| 0.3390    | 0.3820    | 0.3664    | 0.3303    | 0.3559    | 0.3646    |
[TREC 2006 Terabyte Track: Topics 801-850](http://trec.nist.gov/data/terabyte06.html)| 0.3080    | 0.3377    | 0.3069    | 0.2996    | 0.3154    | 0.3084    |

### cw09b

MAP                                     | BM25      | +RM3      | +Ax       | QL        | +RM3      | +Ax       |
:---------------------------------------|-----------|-----------|-----------|-----------|-----------|-----------|
[TREC 2010 Web Track: Topics 51-100](http://trec.nist.gov/data/web/10/wt2010-topics.xml)| 0.1126    | 0.0933    | 0.0928    | 0.1060    | 0.1019    | 0.1086    |
[TREC 2011 Web Track: Topics 101-150](http://trec.nist.gov/data/web/11/full-topics.xml)| 0.1094    | 0.1081    | 0.0974    | 0.0958    | 0.0837    | 0.0879    |
[TREC 2012 Web Track: Topics 151-200](http://trec.nist.gov/data/web/12/full-topics.xml)| 0.1106    | 0.1107    | 0.1315    | 0.1069    | 0.1059    | 0.1212    |

### cw12b

MAP                                     | BM25      | +RM3      | +Ax       | QL        | +RM3    | +Ax     |
:---------------------------------------|-----------|-----------|-----------|-----------|-----------|-----------|
[TREC 2013 Web Track: Topics 201-250](http://trec.nist.gov/data/web2013.html)| 0.0468    | 0.0412    | 0.0435    | 0.0397    | 0.0322    | 0.0359    |
[TREC 2014 Web Track: Topics 251-300](http://trec.nist.gov/data/web2014.html)| 0.0224    | 0.0210    | 0.0180    | 0.0235    | 0.0203    | 0.0186    |

## Implementation

The following is a quick breakdown of what happens in each of the scripts in this repo.

### Dockerfile

The `Dockerfile` installs dependencies, copies scripts to the root dir, exposes port 8983, and sets the working dir to `/work`.

### init

The `init` [script](init) clones Anserini, installs Solr, and bootstraps Solr with Anserini configs.

### index

The `index` [script](index) indexes the collection with Solr.

## References

+ Stephen E. Robertson, Steve Walker, Micheline Hancock-Beaulieu, Mike Gatford, and A. Payne. (1995) Okapi at TREC-4. _TREC_
+ ChengXiang Zhai and John Lafferty. (2001) A Study of Smoothing Methods for Language Models Applied to Ad Hoc Information Retrieval. _SIGIR_.
+ Nasreen Abdul-Jaleel, James Allan, W. Bruce Croft, Fernando Diaz, Leah Larkey, Xiaoyan Li, Donald Metzler, Mark D. Smucker, Trevor Strohman, Howard Turtle, and Courtney Wade. (2004) UMass at TREC 2004: Novelty and HARD. _TREC_.
+ Hui Fang and ChengXiang Zhai. (2006) Semantic Term Matching in Axiomatic Approaches to Information Retrieval. _SIGIR_.

## Reviews

+ Documentation reviewed at commit [`xxxxx`](xxxxx) (xx/xx/xxxx) by [xxxxx](https://github.com/xxxxx/).
