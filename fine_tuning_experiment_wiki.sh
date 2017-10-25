#! /bin/bash

# CuratedTrec

# Preprocessing data
# python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split WikiMovies-train.dstrain-squad-like
# python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split WikiMovies-train.dsdev-squad-like

python scripts/reader/train.py \
    --num-epochs=20 \
    --batch-size=32 \
    --model-dir models/ \
    --model-name MyFinetuneWikiMovies \
    --data-dir data/datasets/ \
    --train-file WikiMovies-train.dstrain-squad-like-processed-corenlp.txt \
    --dev-file WikiMovies-train.dsdev-squad-like-processed-corenlp.txt \
    --dev-json WikiMovies-train.dsdev-squad-like.json \
    --embedding-file glove.840B.300d.txt \
    --checkpoint True \
    --pretrained data/reader/single.mdl \
    --embedding-file glove.840B.300d.txt \
    --expand-dictionary True \
    --tune-partial 1000
    # --restrict-vocab False

python scripts/pipeline/predict.py data/datasets/WikiMovies-test-sm.txt --reader-model models/MyFinetuneWikiMovies.mdl --out-dir `pwd` --batch-size=64 --predict-batch-size=64

python scripts/pipeline/eval.py data/datasets/WikiMovies-test-sm.txt WikiMovies-test-sm-MyFinetuneWikiMovies-pipeline.preds

# python scripts/pipeline/predict.py data/datasets/WikiMovies-test.txt --reader-model models/MyFinetuneWikiMovies.mdl --out-dir `pwd` --batch-size=64 --predict-batch-size=64

# python scripts/pipeline/eval.py data/datasets/WikiMovies-test.txt WikiMovies-test-MyFinetuneWikiMovies-pipeline.preds
