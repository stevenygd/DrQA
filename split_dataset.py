import os
import numpy as np

DATASET_DIR = 'data/datasets'
CURATED     = os.path.join(DATASET_DIR, 'CuratedTrec-train.txt')
CURATED_TR  = os.path.join(DATASET_DIR, 'CuratedTrec-train-train.txt')
CURATED_DEV = os.path.join(DATASET_DIR, 'CuratedTrec-train-dev.txt')
WEBQ     = os.path.join(DATASET_DIR, 'WebQuestions-train.txt')
WEBQ_TR  = os.path.join(DATASET_DIR, 'WebQuestions-train-train.txt')
WEBQ_DEV = os.path.join(DATASET_DIR, 'WebQuestions-train-dev.txt')
WIKI_MOV     = os.path.join(DATASET_DIR, 'WikiMovies-train.txt')
WIKI_MOV_TR  = os.path.join(DATASET_DIR, 'WikiMovies-train-train.txt')
WIKI_MOV_DEV = os.path.join(DATASET_DIR, 'WikiMovies-train-dev.txt')
CURATED_SPLIT_RATIO = 0.2
WEBQ_SPLIT_RATIO = 0.2
WIKI_SPLIT_RATIO = 0.1

np.random.seed(38383)

for fname, tr_fname, dev_fname, dev_ratio in [
        (CURATED,   CURATED_TR,  CURATED_DEV,  CURATED_SPLIT_RATIO),
        (WEBQ,      WEBQ_TR,     WEBQ_DEV,     WEBQ_SPLIT_RATIO),
        (WIKI_MOV,  WIKI_MOV_TR, WIKI_MOV_DEV, WIKI_SPLIT_RATIO)
    ]:
    with open(fname) as in_f, \
         open(tr_fname, "w") as tr_f, \
         open(dev_fname,  "w") as dev_f:
        tr_cnt, dev_cnt = 0, 0
        for l in in_f:
            if np.random.rand() > dev_ratio:
                tr_f.write(l)
                tr_cnt += 1
            else:
                dev_f.write(l)
                dev_cnt += 1
        print("%s:DEV=%d,TRAIN=%d"%(fname, dev_cnt, tr_cnt))
